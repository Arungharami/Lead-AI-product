# Lead.AI Web Deployment Guide

This document prepares the `web/` app for production deployment at `https://www.lead-ai.us`.

## 1) Prerequisites
- Node.js 20+
- npm 10+
- Access to the Lead.AI domain DNS
- Vercel account and/or Firebase project

## 2) Environment setup
1. Copy env template:
   ```bash
   cp web/.env.example web/.env
   ```
2. Fill all required `VITE_*` values.
3. Never commit `.env`.

## 3) Local pre-deploy checks
From `web/`:
```bash
npm install
npm run typecheck
npm run build
npm run preview
```

## 4) Route sanity list (manual)
Verify these load without errors:
- `/`
- `/marketplace`
- `/product/website-chatbot`
- `/pricing`
- `/dashboard`
- `/billing`
- `/orders`
- `/usage`
- `/settings`
- `/custom-ai`
- `/labs`
- `/hf-assets`
- `/admin`

## 5) Deploy with Vercel
1. Import repository in Vercel.
2. Set Root Directory to `web`.
3. Build command: `npm run build`
4. Output directory: `dist`
5. Add all `VITE_*` env vars in Vercel project settings.
6. Add custom domain `www.lead-ai.us` and verify DNS.

## 6) Deploy with Firebase Hosting
```bash
npm i -g firebase-tools
firebase login
cd web
npm run build
firebase init hosting
```
During init:
- Public directory: `dist`
- Single-page app rewrite: `Yes`
- GitHub Actions deploy: optional

Deploy:
```bash
firebase deploy --only hosting
```

## 7) Production checklist
- [ ] `npm run typecheck` passes
- [ ] `npm run build` passes
- [ ] All routes above render correctly
- [ ] Environment variables populated in host platform
- [ ] Domain HTTPS is active for `www.lead-ai.us`
- [ ] Favicon, title, and metadata render in production
- [ ] External links open safely (`rel=noreferrer`)
- [ ] No secrets committed
