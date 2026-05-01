import json
import os

from dotenv import load_dotenv
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from openai import OpenAI
from pydantic import BaseModel

load_dotenv()

app = FastAPI(title="Lead.AI Backend MVP", version="1.2.0")
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


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


@app.get("/")
def root():
    return {"service": "Lead.AI Backend MVP", "status": "ok"}


@app.post("/chat", response_model=ChatResponse)
def chat(req: ChatRequest):
    api_key = os.getenv("OPENAI_API_KEY", "")
    if not api_key:
        return ChatResponse(
            reply="Hello! Please share your name, phone, email, and business need.",
            lead_detected=False,
            lead=LeadData(),
        )

    client = OpenAI(api_key=api_key)
    completion = client.chat.completions.create(
        model=os.getenv("OPENAI_MODEL", "gpt-4.1-mini"),
        temperature=0.2,
        response_format={"type": "json_object"},
        messages=[
            {
                "role": "system",
                "content": "You are a professional lead-capture assistant. Return JSON with reply, lead_detected, lead{name,phone,email,need}.",
            },
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
        return ChatResponse(reply="Please share your name, phone, email, and business need.", lead_detected=False, lead=LeadData())
