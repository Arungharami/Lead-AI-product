import json
import os
from datetime import datetime, timezone
from functools import lru_cache
from typing import Any, Dict, List, Optional

from fastapi import Depends, FastAPI, Header, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from firebase_admin import auth, credentials, firestore, initialize_app
from openai import OpenAI
from pydantic import BaseModel, EmailStr, Field

app = FastAPI(title="Lead.AI API", version="1.0.1")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


class ChatRequest(BaseModel):
    message: str
    state: Dict[str, Optional[str]] = Field(default_factory=dict)


class ChatResponse(BaseModel):
    reply: str
    state: Dict[str, Optional[str]]
    complete: bool


class LeadIn(BaseModel):
    name: str
    phone: str
    email: EmailStr
    need: str


class LeadOut(LeadIn):
    id: str
    user_id: str
    created_at: str


FIELDS = ["name", "phone", "email", "need"]
PROMPTS = {
    "name": "What is your full name?",
    "phone": "What is your phone number?",
    "email": "What is your email address?",
    "need": "What business need can we help with?",
}


@lru_cache(maxsize=1)
def get_db():
    firebase_cred_path = os.getenv("FIREBASE_CREDENTIALS")
    if not firebase_cred_path:
        raise HTTPException(status_code=500, detail="FIREBASE_CREDENTIALS is not configured")
    if not os.path.exists(firebase_cred_path):
        raise HTTPException(status_code=500, detail="Firebase credentials file not found")

    cred = credentials.Certificate(firebase_cred_path)
    try:
        initialize_app(cred)
    except ValueError:
        # already initialized
        pass
    return firestore.client()


@lru_cache(maxsize=1)
def get_openai_client() -> OpenAI:
    api_key = os.getenv("OPENAI_API_KEY")
    if not api_key:
        raise HTTPException(status_code=500, detail="OPENAI_API_KEY is not configured")
    return OpenAI(api_key=api_key)


def get_user_id(token: str) -> str:
    try:
        decoded = auth.verify_id_token(token)
        return decoded["uid"]
    except Exception as exc:
        raise HTTPException(status_code=401, detail="Invalid auth token") from exc


def user_from_auth_header(authorization: str = Header(default="")) -> str:
    if not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Missing bearer token")
    token = authorization.split(" ", 1)[1]
    return get_user_id(token)


def next_missing(state: Dict[str, Optional[str]]) -> Optional[str]:
    for field in FIELDS:
        if not state.get(field):
            return field
    return None


@app.get("/health")
def health():
    return {"status": "ok"}


@app.post("/chat", response_model=ChatResponse)
def chat(req: ChatRequest):
    state = dict(req.state)
    missing_before = next_missing(state)

    if missing_before:
        system = (
            "You are a lead capture assistant. Return JSON only with keys: "
            "name, phone, email, need. Fill only values you can infer confidently, else null."
        )
        completion = get_openai_client().chat.completions.create(
            model=os.getenv("OPENAI_MODEL", "gpt-4.1-mini"),
            temperature=0,
            response_format={"type": "json_object"},
            messages=[
                {"role": "system", "content": system},
                {
                    "role": "user",
                    "content": f"Current state: {json.dumps(state)}\nUser message: {req.message}",
                },
            ],
        )
        parsed = json.loads(completion.choices[0].message.content)
        for key in FIELDS:
            if parsed.get(key) and not state.get(key):
                state[key] = str(parsed[key]).strip()

    missing_after = next_missing(state)
    if missing_after:
        return ChatResponse(reply=PROMPTS[missing_after], state=state, complete=False)

    return ChatResponse(
        reply="Great, I captured your details. We will contact you soon. Tap Save Lead to store this lead.",
        state=state,
        complete=True,
    )


@app.post("/lead", response_model=LeadOut)
def create_lead(lead: LeadIn, user_id: str = Depends(user_from_auth_header)):
    data = lead.model_dump()
    data["user_id"] = user_id
    data["created_at"] = datetime.now(timezone.utc).isoformat()
    ref = get_db().collection("leads").document()
    ref.set(data)
    return LeadOut(id=ref.id, **data)


@app.get("/leads", response_model=List[LeadOut])
def get_leads(user_id: str = Depends(user_from_auth_header)):
    docs = (
        get_db()
        .collection("leads")
        .where("user_id", "==", user_id)
        .order_by("created_at", direction=firestore.Query.DESCENDING)
        .stream()
    )
    out: List[LeadOut] = []
    for doc in docs:
        item: Dict[str, Any] = doc.to_dict()
        out.append(LeadOut(id=doc.id, **item))
    return out
