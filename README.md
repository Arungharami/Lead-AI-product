# Lead.AI — Revenue Automation Platform

Production-focused multi-surface SaaS project for AI lead capture, AI agents, and trustworthy automation.

- Web platform (React + TypeScript + Tailwind): `web/`
- Mobile app (Flutter): `frontend/`
- AI chat backend (FastAPI): `backend/`
- Domain: https://www.lead-ai.us

## Web Platform (React + TypeScript + Tailwind)
Includes:
- Premium landing page
- AI Marketplace / Explore Models
- Product details
- Pricing
- Dashboard
- Billing
- Orders
- Usage analytics
- Settings
- Custom AI Solutions
- Lead.AI Labs / Research
- Hugging Face AI Assets
- Admin panel

### Local run
```bash
cd web
npm install
npm run dev
```

### Production build
```bash
cd web
npm run build
npm run preview
```

### Deploy options
**Vercel**
```bash
npm i -g vercel
cd web
vercel
```

**Netlify**
```bash
cd web
npm run build
# deploy dist/ via Netlify UI or CLI
```

## Backend (FastAPI: AI chat)
`/chat` uses OpenAI to guide lead capture and return structured lead fields.

```bash
cd backend
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
# set OPENAI_API_KEY in .env
uvicorn main:app --reload
```

## Frontend Mobile (Flutter + Firebase)
```bash
cd frontend
flutter pub get
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000
```

### Firebase setup
1. Enable **Authentication > Sign-in method > Email/Password**.
2. Enable **Firestore Database** with **Start in test mode** for MVP.
3. Register Android app `com.leadai.mobile` and place `google-services.json` in `frontend/android/app/`.
4. Never commit Firebase private keys or service account secrets.
