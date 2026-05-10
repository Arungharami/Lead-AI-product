# Lead.AI — AI Lead Capture & Business Automation Platform

<p align="center">
  <strong>Modern AI automation for lead capture, customer messaging, appointment booking, and small business growth.</strong>
</p>

<p align="center">
  <a href="https://www.lead-ai.us">Website</a> ·
  <a href="https://huggingface.co/arun-gharami">Hugging Face</a> ·
  <a href="https://huggingface.co/lead-ai-labs">Lead.AI Labs</a>
</p>

---

## Overview

**Lead.AI** is an AI-powered business automation MVP designed to help small businesses capture leads, respond faster to customers, and manage conversations through intelligent digital assistants.

This repository contains an Android-first product foundation with a **Flutter frontend** and **FastAPI backend**, structured for future integration with AI models, Firebase, analytics, and production deployment workflows.

The long-term goal is to build a practical AI automation platform for:

- Website AI chatbots
- WhatsApp and Instagram business assistants
- Lead qualification agents
- Appointment booking assistants
- Customer support automation
- Usage analytics and business insights
- Trustworthy AI workflows with explainable outputs

---

## Product Vision

Lead.AI is built around a simple idea:

> Give small businesses access to practical AI employees that can capture leads, answer questions, qualify customers, and support growth without requiring an internal AI team.

The platform is designed to combine:

- **Conversational AI** for customer interaction
- **Predictive analytics** for lead scoring and business insights
- **Automation workflows** for response handling and booking
- **Trustworthy AI principles** for transparency, validation, and reliability
- **Mobile-first UX** for real-world small business users

---

## Current Architecture

```text
Lead.AI
├── frontend/          # Flutter mobile application
├── backend/           # FastAPI backend starter
├── README.md          # Project documentation
└── .env.example       # Environment variable template
```

### Frontend

- Flutter mobile app foundation
- Android-first development approach
- API-ready configuration using `API_BASE_URL`
- Designed for future Firebase Authentication and Firestore integration

### Backend

- FastAPI starter API
- Environment-based configuration
- Structured for future AI model/API integration
- Ready for expansion into lead capture, chat, analytics, and billing endpoints

---

## Key Features Planned

| Module | Description |
|---|---|
| AI Chat Assistant | Website/mobile chatbot for customer questions and lead capture |
| Lead Qualification | Scores and categorizes leads based on intent and urgency |
| Business Dashboard | Tracks conversations, leads, conversion activity, and usage |
| Appointment Booking | Automates scheduling flows for service businesses |
| WhatsApp AI Bot | Connects business messaging with AI-powered replies |
| Analytics Layer | Provides usage, risk, and performance insights |
| Trustworthy AI Layer | Adds explainability, validation, and monitoring for AI decisions |

---

## Technology Stack

| Layer | Technology |
|---|---|
| Mobile Frontend | Flutter |
| Backend API | FastAPI |
| Language | Python, Dart |
| Auth / Database Target | Firebase Auth, Firestore |
| AI Integration Target | OpenAI, Hugging Face, custom ML APIs |
| Deployment Target | Firebase Hosting, Cloud Run, VPS, or containerized backend |

---

## Backend Setup

```bash
cd backend
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
export $(cat .env | xargs)
uvicorn app.main:app --reload --port 8000
```

> Note: Keep all API keys, Firebase credentials, and production secrets inside environment variables. Never commit secrets to GitHub.

---

## Frontend Setup

```bash
cd frontend
flutter pub get
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000
```

For a production backend:

```bash
flutter run --dart-define=API_BASE_URL=https://api.yourdomain.com
```

---

## Firebase Setup

1. Enable Firebase Email/Password Authentication.
2. Enable Firestore.
3. Add Android `google-services.json` to:

```text
frontend/android/app/google-services.json
```

4. Add backend service account configuration through environment variables.
5. Keep Firebase service credentials out of version control.

---

## Android Release Build

```bash
cd frontend
flutter pub get
flutter build appbundle --dart-define=API_BASE_URL=https://api.yourdomain.com
```

Generated release bundle:

```text
build/app/outputs/bundle/release/app-release.aab
```

Before publishing:

- Test internal release builds
- Confirm Firebase authentication works
- Validate API connectivity
- Review privacy policy and terms
- Confirm no secrets are included in the app bundle

---

## Roadmap

### Phase 1 — MVP Foundation

- Mobile app shell
- FastAPI backend
- Firebase setup
- Basic lead capture flow
- AI assistant prototype

### Phase 2 — AI Automation

- AI chat workflow
- Lead scoring logic
- Business dashboard metrics
- Admin configuration panel
- Knowledge base Q&A integration

### Phase 3 — Business Platform

- WhatsApp/Twilio integration
- Stripe subscription billing
- Usage analytics
- Customer account dashboard
- Multi-business support

### Phase 4 — Trustworthy AI Layer

- Explainable AI outputs
- Model monitoring
- Bias and reliability checks
- Audit-friendly decision logs
- SME-ready deployment templates

---

## Related AI Work

This project is part of a broader applied AI portfolio focused on:

- Explainable AI
- Fraud detection
- Predictive analytics
- Customer intelligence
- Business automation
- Trustworthy machine learning systems

Related platforms:

- **Lead.AI Website:** https://www.lead-ai.us
- **Hugging Face Profile:** https://huggingface.co/arun-gharami
- **Lead.AI Labs:** https://huggingface.co/lead-ai-labs

---

## Author

**Arun Kumar Gharami**  
AI Engineer · Applied Researcher · QA Automation Engineer  
Focused on trustworthy AI, predictive analytics, business automation, and real-world AI deployment.

---

## License

This project is currently maintained as a professional MVP and portfolio project. Add a formal open-source license before external production reuse.
