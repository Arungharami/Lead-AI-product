# Lead.AI Product Platform

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![FastAPI](https://img.shields.io/badge/Backend-FastAPI-009688)
![Flutter](https://img.shields.io/badge/Mobile-Flutter-02569B)
![React](https://img.shields.io/badge/Web-React%20%2B%20Vite-61DAFB)
![Firebase](https://img.shields.io/badge/Auth%20%26%20Database-Firebase-FFCA28)
![OpenAI](https://img.shields.io/badge/AI-OpenAI-111111)

## Overview

**Lead.AI Product Platform** is an AI-powered lead capture, business automation, and customer intelligence platform designed for small businesses, agencies, and service providers.

The system helps businesses capture leads, qualify prospects, automate conversations, manage customer inquiries, and prepare AI-driven workflows across web and mobile experiences.

This repository contains a multi-platform MVP with:

- **FastAPI backend** for AI chat, lead capture, and Firebase-secured lead storage
- **Flutter mobile app** for Android-first lead capture and customer communication
- **React + Vite web app** for Lead.AI marketplace, dashboard, pricing, billing, usage, labs, and admin pages
- **Firebase integration** for authentication and Firestore lead storage
- **OpenAI integration** for intelligent lead qualification and conversational AI
- **Production deployment documentation** for web launch readiness

---

## Product Vision

Lead.AI is built to become a practical AI automation platform for businesses that need:

- Website AI chatbot
- WhatsApp and Instagram lead automation
- AI-powered customer qualification
- Appointment and service inquiry capture
- Business workflow automation
- Lead dashboard and analytics
- AI product marketplace
- Trustworthy AI tools for real-world business operations

---

## Current Status

**Status:** MVP / Production-readiness in progress

The project already includes working architecture for:

- Backend API
- AI chat endpoint
- Auth-protected lead saving
- Firebase setup
- Flutter frontend baseline
- React web dashboard and marketplace structure
- Deployment and release checklists

Some advanced production features are planned but not fully completed yet, including payment processing, real-time messaging, advanced analytics, hardened security rules, and full CI/CD automation.

---

## Repository Structure

```text
Lead-AI-product/
│
├── backend/                         # FastAPI backend API
│   ├── app/
│   │   ├── api/
│   │   ├── core/
│   │   ├── schemas/
│   │   ├── services/
│   │   └── main.py
│   ├── .env.example
│   ├── main.py
│   └── requirements.txt
│
├── frontend/                        # Flutter mobile app
│   ├── lib/
│   │   ├── models/
│   │   ├── screens/
│   │   ├── services/
│   │   └── main.dart
│   ├── .env.example
│   ├── PRODUCTION_SANITY.md
│   └── pubspec.yaml
│
├── web/                             # React + Vite web application
│   ├── public/
│   ├── src/
│   │   ├── data/
│   │   ├── layouts/
│   │   ├── pages/
│   │   ├── App.tsx
│   │   ├── main.tsx
│   │   └── styles.css
│   ├── .env.example
│   ├── package.json
│   ├── tailwind.config.js
│   ├── tsconfig.json
│   └── vite.config.ts
│
├── gigfinanceapp/                   # Additional app module / experiment
├── scripts/                         # Utility scripts
├── desktop_export/                  # Exported desktop assets
│
├── DEPLOYMENT.md
├── FINAL_RELEASE_CHECKLIST.md
├── GOOGLE_LAUNCH_CHECKLIST.md
├── MOBILE_PRODUCTION_ROADMAP.md
├── LICENSE
└── README.md
