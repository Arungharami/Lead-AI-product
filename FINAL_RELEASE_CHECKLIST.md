# Lead.AI Web Final Release Checklist

Scope: documentation and deployment readiness for launching `www.lead-ai.us`.

## 1) Required environment variables
Set these in deployment platform (Vercel/Firebase CI env):

### Core web
- `VITE_APP_NAME=Lead.AI`
- `VITE_APP_URL=https://www.lead-ai.us`
- `VITE_API_BASE_URL=https://api.lead-ai.us`

### Firebase web config
- `VITE_FIREBASE_API_KEY`
- `VITE_FIREBASE_AUTH_DOMAIN`
- `VITE_FIREBASE_PROJECT_ID`
- `VITE_FIREBASE_STORAGE_BUCKET`
- `VITE_FIREBASE_MESSAGING_SENDER_ID`
- `VITE_FIREBASE_APP_ID`

### Optional observability
- `VITE_GA_MEASUREMENT_ID`
- `VITE_SENTRY_DSN`

## 2) Domain setup for `www.lead-ai.us`
- [ ] Create/verify DNS zone for `lead-ai.us`.
- [ ] Configure `www` CNAME to hosting provider target.
- [ ] Keep apex/root redirect strategy defined (`lead-ai.us` -> `www.lead-ai.us` recommended).
- [ ] Enable TLS/HTTPS certificate for both root + www.
- [ ] Confirm HSTS/HTTPS redirect behavior.

## 3) Firebase Hosting option
- [ ] Install CLI: `npm i -g firebase-tools`
- [ ] `firebase login`
- [ ] Build web app: `cd web && npm run build`
- [ ] `firebase init hosting`
  - public directory: `dist`
  - single-page app rewrite: `Yes`
- [ ] `firebase deploy --only hosting`
- [ ] Add custom domain `www.lead-ai.us` in Firebase Console and verify DNS.

## 4) Vercel option
- [ ] Import repository into Vercel.
- [ ] Set Project Root to `web`.
- [ ] Build command: `npm run build`
- [ ] Output directory: `dist`
- [ ] Configure all required `VITE_*` environment variables.
- [ ] Add custom domain `www.lead-ai.us` and complete DNS verification.

## 5) Backend API connection checklist
- [ ] `VITE_API_BASE_URL` points to correct production backend URL.
- [ ] CORS on backend allows `https://www.lead-ai.us`.
- [ ] Backend health endpoint responds from production environment.
- [ ] `/chat` endpoint returns expected JSON schema.
- [ ] API timeouts/retries are defined at edge/proxy level.

## 6) Security checklist
- [ ] No secrets committed to git (`.env`, service keys, private tokens).
- [ ] Only `VITE_*` values intended for browser exposure are used in web app.
- [ ] Firebase rules are not left permanently in open test mode.
- [ ] CSP/headers configured in hosting layer where possible.
- [ ] External links use safe attributes (`rel=noreferrer` when opening new tab).

## 7) Manual QA checklist
- [ ] `npm run typecheck` passes.
- [ ] `npm run build` passes.
- [ ] `npm run preview` loads expected homepage.
- [ ] Route checks pass:
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
- [ ] Mobile viewport check (hero/buttons/cards/navigation).
- [ ] Metadata check (title/description/favicon).

## 8) Launch-day checklist
- [ ] Deploy production build.
- [ ] Verify domain + HTTPS certificate status.
- [ ] Smoke test critical pages and API connectivity.
- [ ] Verify analytics events and Search Console ownership.
- [ ] Announce release and monitor logs/error rates for first 24 hours.
- [ ] Keep rollback plan ready (previous deployment snapshot).
