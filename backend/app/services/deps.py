from functools import lru_cache

from fastapi import Header, HTTPException
from firebase_admin import auth, credentials, firestore, get_app, initialize_app
from firebase_admin.exceptions import FirebaseError
from openai import OpenAI

from app.core.config import settings

@lru_cache(maxsize=1)
def get_firebase_app():
    try:
        return get_app()
    except ValueError:
        pass
    cred_path = settings.firebase_credentials
    if not cred_path:
        raise HTTPException(status_code=500, detail="FIREBASE_CREDENTIALS is not configured")
    return initialize_app(credentials.Certificate(cred_path))

@lru_cache(maxsize=1)
def get_db():
    return firestore.client(app=get_firebase_app())

@lru_cache(maxsize=1)
def get_openai_client() -> OpenAI:
    key = settings.openai_api_key
    if not key:
        raise HTTPException(status_code=500, detail="OPENAI_API_KEY is not configured")
    return OpenAI(api_key=key)

def user_from_auth_header(authorization: str = Header(default="")) -> str:
    if not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Missing bearer token")
    token = authorization.split(" ", 1)[1]
    if not token.strip():
        raise HTTPException(status_code=401, detail="Missing bearer token")
    firebase_app = get_firebase_app()
    try:
        decoded = auth.verify_id_token(token, app=firebase_app)
        return decoded["uid"]
    except (ValueError, FirebaseError, KeyError) as exc:
        raise HTTPException(status_code=401, detail="Invalid auth token") from exc
