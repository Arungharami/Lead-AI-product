# Lead.AI Product

<p align="center">
  <strong>AI lead capture and business automation platform for small businesses.</strong>
</p>

<p align="center">
  <a href="https://www.lead-ai.us">Website</a> ·
  <a href="https://huggingface.co/arun-gharami">Hugging Face</a> ·
  <a href="https://huggingface.co/lead-ai-labs">Lead.AI Labs</a> ·
  <a href="https://scholar.google.com/citations?user=uy4i5soAAAAJ&hl=en">Google Scholar</a>
</p>

<p align="center">
  <img alt="AI" src="https://img.shields.io/badge/AI-Business%20Automation-blue">
  <img alt="Backend" src="https://img.shields.io/badge/API-FastAPI-009688">
  <img alt="Mobile" src="https://img.shields.io/badge/Mobile-Flutter-02569B">
  <img alt="License" src="https://img.shields.io/badge/License-MIT-green">
</p>

---

## Overview

**Lead.AI** is an applied AI product foundation for helping small businesses capture leads, respond to customers faster, and prepare customer conversations for follow-up, booking, and analytics workflows.

This repository contains the early product structure for a mobile-first Lead.AI experience:

- **Flutter frontend** for a mobile business interface
- **FastAPI backend** for API-driven automation workflows
- Environment-based configuration for AI providers and Firebase integration
- Documentation focused on professional portfolio review, product direction, and future deployment

The project is part of Arun Kumar Gharami's broader AI engineering portfolio across trustworthy AI, predictive analytics, fraud detection, business automation, QA automation, and Hugging Face deployment.

## Problem Solved

Many small businesses lose potential customers because they cannot respond quickly, qualify leads consistently, or organize customer intent across channels. Lead.AI is designed as a practical AI assistant layer that can help businesses:

- Capture customer interest from digital channels
- Qualify leads with structured questions
- Summarize conversations for business owners
- Prepare appointment or follow-up workflows
- Track lead activity and business outcomes
- Support more transparent and auditable AI-assisted decisions

## Current Status

This repository is an MVP/product foundation. It is not presented as a finished production SaaS platform yet. The current codebase establishes the mobile and backend structure for future AI, authentication, database, analytics, and deployment work.

## Features

### Current foundation

- Flutter mobile application starter
- FastAPI backend starter
- API base URL configuration for local and deployed environments
- Environment variable examples for backend and frontend setup
- Project structure ready for Firebase, AI API, and analytics expansion

### Planned product modules

| Module | Purpose |
|---|---|
| AI Chat Assistant | Help answer customer questions and collect lead details |
| Lead Qualification | Score or categorize leads by intent, urgency, and fit |
| Business Dashboard | Track conversations, leads, response activity, and outcomes |
| Appointment Workflow | Prepare scheduling and follow-up actions |
| Knowledge Base Q&A | Ground responses in business-specific service information |
| Analytics Layer | Summarize usage, lead quality, and conversion signals |
| Trustworthy AI Layer | Add explainability, validation, monitoring, and audit-friendly logs |

## Tech Stack

| Layer | Technology |
|---|---|
| Mobile frontend | Flutter, Dart |
| Backend API | FastAPI, Python |
| Target authentication | Firebase Auth |
| Target database | Firestore |
| AI integration target | OpenAI APIs, Hugging Face models, custom ML APIs |
| Deployment targets | Firebase, Cloud Run, VPS, or containerized backend |

## Architecture

```text
Lead-AI-product/
├── frontend/                 # Flutter mobile app foundation
│   ├── lib/
│   └── pubspec.yaml
├── backend/                  # FastAPI backend foundation
│   ├── app/
│   └── requirements.txt
├── README.md
└── LICENSE
```

### Backend responsibilities

- Provide API endpoints for lead, chat, and automation workflows
- Load sensitive configuration from environment variables
- Prepare integration points for AI providers and Firebase services
- Keep service credentials outside version control

### Frontend responsibilities

- Provide a mobile-first business owner interface
- Connect to the backend through a configurable API base URL
- Prepare screens and flows for leads, conversations, and analytics
- Support future Firebase Authentication integration

## Setup Instructions

### Prerequisites

- Python 3.10+
- Flutter SDK
- Android Studio or a configured Flutter device/emulator
- Optional: Firebase project for authentication/database work

### Backend setup

```bash
cd backend
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
uvicorn app.main:app --reload --port 8000
```

Expected local API URL:

```text
http://localhost:8000
```

### Frontend setup

```bash
cd frontend
flutter pub get
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000
```

For a deployed API, pass the production backend URL:

```bash
flutter run --dart-define=API_BASE_URL=https://api.yourdomain.com
```

## Environment Variables

Use local environment files for development and platform-managed secrets for deployed environments.

Example backend variables:

```env
OPENAI_API_KEY=your_openai_key
FIREBASE_CREDENTIALS=./serviceAccountKey.json
```

Important security rules:

- Do not commit `.env` files.
- Do not commit Firebase service account JSON files.
- Do not commit OpenAI, Hugging Face, Stripe, Twilio, or other private API keys.
- Use `.env.example` only for placeholders.

## Usage Examples

Run the backend locally:

```bash
cd backend
uvicorn app.main:app --reload --port 8000
```

Run the Flutter app against the local backend:

```bash
cd frontend
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000
```

Build an Android release bundle:

```bash
cd frontend
flutter build appbundle --dart-define=API_BASE_URL=https://api.yourdomain.com
```

## Screenshots

Screenshots should be added as the MVP UI stabilizes.

Suggested screenshots:

- Mobile lead capture screen
- Conversation or AI assistant screen
- Business dashboard screen
- Backend API documentation page

```text
assets/screenshots/
├── mobile-leads.png
├── ai-assistant.png
├── dashboard.png
└── api-docs.png
```

## Roadmap

### Phase 1: MVP foundation

- Mobile app shell
- FastAPI backend
- Environment configuration
- Basic lead capture data model
- Initial AI assistant workflow

### Phase 2: AI automation

- Business-specific Q&A workflow
- Lead qualification prompts
- Conversation summaries
- Admin settings for business profile and services
- Basic analytics dashboard

### Phase 3: Product readiness

- Firebase Authentication
- Firestore persistence
- Deployment pipeline
- Privacy policy and terms workflow
- Error monitoring and logging
- Usage analytics

### Phase 4: Trustworthy AI layer

- Explainable lead scoring
- Human review controls
- Prompt and response audit logs
- Reliability checks for AI outputs
- Bias and safety review checklist

## Portfolio Context

Lead.AI connects with related work across:

- Trustworthy AI
- Explainable AI
- Predictive analytics
- Business automation
- AI SaaS platforms
- Hugging Face model deployment
- QA automation and software testing

Related links:

- Website: https://www.lead-ai.us
- Hugging Face: https://huggingface.co/arun-gharami
- Lead.AI Labs: https://huggingface.co/lead-ai-labs
- Google Scholar: https://scholar.google.com/citations?user=uy4i5soAAAAJ&hl=en

## Author

**Arun Kumar Gharami**  
AI Engineer · Applied Researcher · QA Automation Engineer

Focus areas: trustworthy AI, explainable AI, fraud detection, predictive analytics, business automation, AI SaaS platforms, QA automation, and software testing.

## License

This repository is available under the MIT License. See [LICENSE](LICENSE) for details.
