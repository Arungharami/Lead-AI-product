from functools import lru_cache
import os

from fastapi import Header, HTTPException
from firebase_admin import auth, credentials, firestore, initialize_app
from openai import OpenAI

@lru_cache(maxsize=1)
def get_db():
    cred_path = os.getenv("FIREBASE_CREDENTIALS", "")
    if not cred_path:
        raise HTTPException(status_code=500, detail="FIREBASE_CREDENTIALS is not configured")
    cred = credentials.Certificate(cred_path)
    try:
        initialize_app(cred)
    except ValueError:
        pass
    return firestore.client()

@lru_cache(maxsize=1)
def get_openai_client() -> OpenAI:
    key = os.getenv("OPENAI_API_KEY", "")
    if not key:
        raise HTTPException(status_code=500, detail="OPENAI_API_KEY is not configured")
    return OpenAI(api_key=key)

def user_from_auth_header(authorization: str = Header(default="")) -> str:
    if not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Missing bearer token")
    token = authorization.split(" ", 1)[1]
    decoded = auth.verify_id_token(token)
    return decoded["uid"]
