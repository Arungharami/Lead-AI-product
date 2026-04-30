from typing import Dict, Optional
from pydantic import BaseModel, EmailStr, Field

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
