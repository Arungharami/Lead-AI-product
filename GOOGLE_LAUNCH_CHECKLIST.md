# Lead.AI Google Launch Checklist

This checklist prepares Lead.AI web for Google-ready production launch.

## 1) Build and runtime
- Install deps in `web/`: `npm install`
- Typecheck: `npm run typecheck`
- Build: `npm run build`
- Preview: `npm run preview`

## 2) Domain and hosting
- Deploy `web/dist` to Vercel or Firebase Hosting.
- Set custom domain: `www.lead-ai.us`.
- Force HTTPS.

## 3) SEO essentials
- Verify title and description in `web/index.html`.
- Submit sitemap in Google Search Console.
- Verify ownership for `lead-ai.us` and `www.lead-ai.us`.

## 4) Google integrations
- Add GA4 measurement ID to `VITE_GA_MEASUREMENT_ID`.
- Add Search Console verification tag in `index.html` (if required).

## 5) Security
- Ensure no secrets in repo.
- Only expose `VITE_*` values intended for browser use.

## 6) Environment troubleshooting for npm 403
If your environment blocks npm registry access:
- Use a machine/network with npmjs.org access.
- Or configure your enterprise artifact proxy/allowlist for:
  - `https://registry.npmjs.org/react`
  - `https://registry.npmjs.org/react-dom`
  - `https://registry.npmjs.org/react-router-dom`
  - `https://registry.npmjs.org/typescript`
  - `https://registry.npmjs.org/vite`

## 7) Release gate
- [ ] Build passes
- [ ] Routes load without errors
- [ ] Domain resolves and HTTPS is valid
- [ ] Search Console verified
- [ ] GA4 receiving events
