import os

class Settings:
    app_name: str = "Lead.AI API"
    app_version: str = "1.0.0"
    openai_model: str = os.getenv("OPENAI_MODEL", "gpt-4.1-mini")
    openai_api_key: str = os.getenv("OPENAI_API_KEY", "")
    firebase_credentials: str = os.getenv("FIREBASE_CREDENTIALS", "")

settings = Settings()
