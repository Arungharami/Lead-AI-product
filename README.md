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
