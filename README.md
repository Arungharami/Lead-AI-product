# Lead.AI — AI Lead Capture Assistant

Simple Android-first MVP with Flutter frontend + FastAPI backend.

## Clean Folder Structure
- `backend/` FastAPI API starter
- `frontend/` Flutter app starter

## Backend Run (FastAPI)
```bash
cd backend
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
export $(cat .env | xargs)
uvicorn app.main:app --reload --port 8000
```
> If you use Python 3.14, the backend requirements are pinned for compatibility (`pydantic==2.13.0`).

## Frontend Run (Flutter)
```bash
cd frontend
flutter pub get
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000
```

## Production / Google Play Store
- Configure Android Firebase by placing `google-services.json` into `android/app/`.
- Set `API_BASE_URL` to your production backend URL.
- Run `flutter pub get` and then build a release bundle:
  ```bash
  flutter build appbundle --dart-define=API_BASE_URL=https://api.yourdomain.com
  ```
- Upload the generated `build/app/outputs/bundle/release/app.aab` to Google Play Console.
- Test the release build on internal testing before publishing.

## Firebase Setup (Required)
1. Enable Firebase Email/Password auth.
2. Enable Firestore.
3. Put Android `google-services.json` in `frontend/android/app/`.
4. Put service account key path in `FIREBASE_CREDENTIALS`.

## Notes
- Subscription screen is placeholder only.
- Keep secrets in `.env` and never commit them.
