from datetime import datetime, timezone
from typing import Dict, List, Optional
from uuid import uuid4

from fastapi import FastAPI, Header, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, EmailStr, Field

app = FastAPI(title="Lead.AI Backend MVP", version="1.0.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

LEADS: List[Dict[str, str]] = []


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


def next_missing(state: Dict[str, Optional[str]]) -> Optional[str]:
    for field in FIELDS:
        if not state.get(field):
            return field
    return None


def get_user_id(authorization: str = "") -> str:
    if not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Missing Bearer token")
    token = authorization.split(" ", 1)[1].strip()
    if not token:
        raise HTTPException(status_code=401, detail="Empty token")
    # MVP in-memory auth: treat token as user id
    return token


@app.get("/")
def root():
    return {"service": "Lead.AI Backend MVP", "status": "ok"}


@app.post("/chat", response_model=ChatResponse)
def chat(req: ChatRequest):
    state = dict(req.state)
    field = next_missing(state)
    if field and req.message.strip():
        state[field] = req.message.strip()

    missing = next_missing(state)
    if missing:
        return ChatResponse(reply=PROMPTS[missing], state=state, complete=False)

    return ChatResponse(reply="Thanks! I captured your details. Tap Save Lead.", state=state, complete=True)


@app.post("/lead", response_model=LeadOut)
def create_lead(lead: LeadIn, authorization: str = Header(default="")):
    user_id = get_user_id(authorization)
    record = {
        "id": str(uuid4()),
        "user_id": user_id,
        "name": lead.name,
        "phone": lead.phone,
        "email": lead.email,
        "need": lead.need,
        "created_at": datetime.now(timezone.utc).isoformat(),
    }
    LEADS.append(record)
    return LeadOut(**record)


@app.get("/leads", response_model=List[LeadOut])
def list_leads(authorization: str = Header(default="")):
    user_id = get_user_id(authorization)
    return [LeadOut(**lead) for lead in LEADS if lead["user_id"] == user_id]
