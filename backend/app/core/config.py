from pydantic_settings import BaseSettings, SettingsConfigDict

class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8", extra="ignore")
    app_name: str = "Lead.AI API"
    app_version: str = "1.0.0"
    openai_model: str = "gpt-4.1-mini"
    openai_api_key: str = ""
    firebase_credentials: str = ""

settings = Settings()
