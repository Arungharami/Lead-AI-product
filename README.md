## lead-ai-mobile

# Lead.AI — AI Lead Capture Assistant (MVP)

Production-ready MVP with Flutter frontend + FastAPI backend + Firebase + OpenAI.

**Description:** AI lead capture assistant mobile app using Flutter, FastAPI, Firebase, and OpenAI.

**Suggested visibility:** Public or Private.

## Architecture
- `frontend/`: Flutter Android-first app
- `backend/`: FastAPI API server

## Backend Setup
1. Create virtual env and install deps:
   ```bash
   cd backend
   python -m venv .venv
   source .venv/bin/activate
   pip install -r requirements.txt
   ```
2. Add Firebase service account JSON and set env:
   ```bash
   cp .env.example .env
   # edit .env values
   export $(cat .env | xargs)
   ```
3. Run API:
   ```bash
   uvicorn app.main:app --reload --port 8000
   ```

## Frontend Setup
1. Install Flutter SDK + Android toolchain.
2. Configure Firebase app (Android package) and place `google-services.json` in `frontend/android/app/`.
3. Enable Firebase Auth (Email/Password) and Firestore.
4. Run:
   ```bash
   cd frontend
   flutter pub get
   flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000
   ```

## API Endpoints
- `POST /chat` — AI step-by-step lead capture state
- `POST /lead` — Save lead (requires Firebase ID token bearer)
- `GET /leads` — Get current user leads

## Notes
- Subscription is UI placeholder only (`Free` vs `Pro`).
- All secrets must be env vars (`OPENAI_API_KEY`, `FIREBASE_CREDENTIALS`).
