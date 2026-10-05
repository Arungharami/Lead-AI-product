# Engineering review — October 4, 2026

## Scope

Source review of `backend/app/main.py`, routes, dependency providers, schemas, configuration, requirements and Flutter API client. This review addresses a bounded correctness issue; it does not certify the entire application, rerun all research experiments, or establish production readiness.

## Finding and repair

Pydantic v2 was pinned while modular settings imported the removed pydantic.BaseSettings API. app/main duplicated routes and providers instead of using the modular implementation. Modular token verification did not initialize Firebase or translate invalid tokens into 401.

Use pydantic-settings, mount the existing router as the canonical mobile API, share Firebase initialization across auth/storage, handle invalid bearer tokens, and document `uvicorn app.main:app`. Retain the separate older chat-only prototype explicitly as legacy. Add a credential-free backend contract CI job.

## Verification

Python syntax compilation passed. FastAPI/Firebase/OpenAI runtime and 6 new contract tests are NOT_RUN locally: package installation was blocked. The new GitHub workflow installs the real dependencies and exercises mocked external providers.

All changed Python files were syntax-compiled. Package installation from this workspace is blocked, so full dependency-backed suites and production builds are not described as passed. GitHub checks on the pull request provide the remaining integration validation.

## Next implementation work

Run the full mobile sign-in → chat → save → list flow with actual Firebase credentials and required Firestore indexes. Then address public-chat abuse limits, validated contact-field extraction, and deployment origin configuration. Billing and messaging provider integrations remain unfinished.

## Evidence boundary

No raw benchmark data, measured research results, corpus approval records, model releases or production deployments were changed. Any affected scientific output must be re-executed and linked to the accepted source commit before updating manuscript claims.
