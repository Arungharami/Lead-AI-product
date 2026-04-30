import json
import os
from datetime import datetime, timezone
from typing import Dict, List
from uuid import uuid4

from dotenv import load_dotenv
from fastapi import FastAPI, Header, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from openai import OpenAI
from pydantic import BaseModel, EmailStr

load_dotenv()

app = FastAPI(title="Lead.AI Backend MVP", version="1.1.0")
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


class LeadData(BaseModel):
    name: str = ""
    phone: str = ""
    email: str = ""
    need: str = ""


class ChatResponse(BaseModel):
    reply: str
    lead_detected: bool
    lead: LeadData


class LeadIn(BaseModel):
    name: str
    phone: str
    email: EmailStr
    need: str


class LeadOut(LeadIn):
    id: str
    user_id: str
    created_at: str


def get_user_id(authorization: str = "") -> str:
    if not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Missing Bearer token")
    token = authorization.split(" ", 1)[1].strip()
    if not token:
        raise HTTPException(status_code=401, detail="Empty token")
    return token


@app.get("/")
def root():
    return {"service": "Lead.AI Backend MVP", "status": "ok"}


@app.post("/chat", response_model=ChatResponse)
def chat(req: ChatRequest):
    api_key = os.getenv("OPENAI_API_KEY", "")
    if not api_key:
        return ChatResponse(
            reply="Hello! I can help capture a lead. Please share name, phone, email, and business need.",
            lead_detected=False,
            lead=LeadData(),
        )

    client = OpenAI(api_key=api_key)
    system_prompt = (
        "You are a professional AI lead-capture assistant for small businesses. "
        "Collect name, phone, email, and business need. "
        "Return ONLY valid JSON with keys: reply, lead_detected, lead. "
        "lead must include: name, phone, email, need. "
        "If any field is missing, set it to empty string and keep lead_detected=false."
    )

    completion = client.chat.completions.create(
        model=os.getenv("OPENAI_MODEL", "gpt-4.1-mini"),
        temperature=0.2,
        response_format={"type": "json_object"},
        messages=[
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": req.message},
        ],
    )
    content = completion.choices[0].message.content or "{}"

    try:
        parsed = json.loads(content)
        lead_payload = parsed.get("lead", {})
        return ChatResponse(
            reply=str(parsed.get("reply", "Please share your name, phone, email, and business need.")),
            lead_detected=bool(parsed.get("lead_detected", False)),
            lead=LeadData(
                name=str(lead_payload.get("name", "") or ""),
                phone=str(lead_payload.get("phone", "") or ""),
                email=str(lead_payload.get("email", "") or ""),
                need=str(lead_payload.get("need", "") or ""),
            ),
        )
    except Exception:
        return ChatResponse(
            reply="Please share your name, phone, email, and business need.",
            lead_detected=False,
            lead=LeadData(),
        )


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
