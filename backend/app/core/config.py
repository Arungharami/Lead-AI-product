from pydantic import BaseSettings

class Settings(BaseSettings):
    app_name: str = "Lead.AI API"
    app_version: str = "1.0.0"
    openai_model: str = "gpt-4.1-mini"
    openai_api_key: str = ""
    firebase_credentials: str = ""

    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"

settings = Settings()
