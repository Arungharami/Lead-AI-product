# Lead.AI — AI Lead Capture Assistant

## Backend (FastAPI MVP)
In-memory backend for quick MVP testing.

### Run
```bash
cd backend
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
# add OPENAI_API_KEY in .env
uvicorn main:app --reload
```

### Endpoints
- `GET /`
- `POST /chat`
- `POST /lead`
- `GET /leads`

### Quick curl examples
```bash
# Health/root
curl http://127.0.0.1:8000/

# Step chat
curl -X POST http://127.0.0.1:8000/chat \
  -H 'Content-Type: application/json' \
  -d '{"message":"Jane Doe","state":{}}'

# Save lead (token acts as user_id in MVP)
curl -X POST http://127.0.0.1:8000/lead \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer demo-user-1' \
  -d '{"name":"Jane Doe","phone":"+15551234567","email":"jane@example.com","need":"Website redesign"}'

# List leads for same user token
curl http://127.0.0.1:8000/leads -H 'Authorization: Bearer demo-user-1'
```

## Frontend (Flutter)
```bash
cd frontend
flutter pub get
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000
```


## Git project / GitHub repo setup
This folder is already a Git project. To create and connect a GitHub repository:

```bash
./scripts/create_github_repo.sh lead-ai-mobile private
# or
./scripts/create_github_repo.sh lead-ai-mobile public
```

Then push:

```bash
git push -u origin main
```


### OpenAI setup
Set `OPENAI_API_KEY` in `backend/.env` to enable AI lead-capture responses.\nIf missing, `/chat` returns a safe fallback prompt.
