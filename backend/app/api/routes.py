import json
from datetime import datetime, timezone
from typing import Any, Dict, List, Optional

from fastapi import APIRouter, Depends
from firebase_admin import firestore

from app.schemas.lead import ChatRequest, ChatResponse, LeadIn, LeadOut
from app.services.deps import get_db, get_openai_client, user_from_auth_header

router = APIRouter()
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

@router.get('/health')
def health():
    return {'status': 'ok'}

@router.post('/chat', response_model=ChatResponse)
def chat(req: ChatRequest):
    state = dict(req.state)
    if next_missing(state):
        completion = get_openai_client().chat.completions.create(
            model='gpt-4.1-mini',
            temperature=0,
            response_format={'type': 'json_object'},
            messages=[
                {'role': 'system', 'content': 'Extract lead fields name, phone, email, need as JSON.'},
                {'role': 'user', 'content': f"Current state: {json.dumps(state)}\nUser message: {req.message}"},
            ],
        )
        parsed = json.loads(completion.choices[0].message.content)
        for k in FIELDS:
            if parsed.get(k) and not state.get(k):
                state[k] = str(parsed[k]).strip()

    missing = next_missing(state)
    if missing:
        return ChatResponse(reply=PROMPTS[missing], state=state, complete=False)
    return ChatResponse(reply='Great, I captured your details. Tap Save Lead.', state=state, complete=True)

@router.post('/lead', response_model=LeadOut)
def create_lead(lead: LeadIn, user_id: str = Depends(user_from_auth_header)):
    payload = lead.model_dump()
    payload['user_id'] = user_id
    payload['created_at'] = datetime.now(timezone.utc).isoformat()
    ref = get_db().collection('leads').document()
    ref.set(payload)
    return LeadOut(id=ref.id, **payload)

@router.get('/leads', response_model=List[LeadOut])
def get_leads(user_id: str = Depends(user_from_auth_header)):
    docs = get_db().collection('leads').where('user_id', '==', user_id).order_by('created_at', direction=firestore.Query.DESCENDING).stream()
    out: List[LeadOut] = []
    for doc in docs:
        item: Dict[str, Any] = doc.to_dict()
        out.append(LeadOut(id=doc.id, **item))
    return out
