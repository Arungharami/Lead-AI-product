# Lead.AI Mobile — Production Upgrade Roadmap

This document aligns the current Flutter MVP with the production target for **Lead-Ai.us**.

## Current framework choice
- **Flutter** (kept) for high-performance animations and consistent Android-first delivery.

## Delivered in this update
- Dark-mode glassmorphic navigation shell with neon AI accents.
- Center-docked **AI Command** action button for fast navigation to AI Chat.
- Updated UI baseline without adding backend-breaking behavior.

## Required environment/API keys
- OpenAI (or Gemini) key for AI responses.
- Twilio key pair for messaging/calling if Twilio is chosen.
- Firebase project config for Auth + Firestore.
- Backend base URL and secure token settings.

## Production modules to implement next
1. Realtime messaging (WebSocket), read receipts, voice note attachments.
2. WebRTC voice/video calling with recording consent flow.
3. Lead Feed vertical cards with AI-generated summaries.
4. MFA + Google/Apple social login.
5. End-to-end encryption for chat and calls.
6. CI/CD with Docker and GitHub Actions.
7. Node.js + PostgreSQL + Redis real-time backend track (parallel to MVP backend).

## Deployment readiness checklist
- [ ] Flutter `analyze` and release Android build pass.
- [ ] App secrets stored in CI secret manager.
- [ ] Firebase App Check and Firestore rules hardened for prod.
- [ ] API rate limits and audit logging enabled.
- [ ] Privacy policy and Terms linked in app settings.

