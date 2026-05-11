# Flutter Production Sanity Audit Notes

## 1) Navigation sanity (`lib/main.dart`)
- `AppShell` uses a single `index` source of truth for tab state.
- AI Command FAB sets `index = 1`, which maps to `ChatScreen`.
- Bottom navigation destination at index `1` is also Chat, so FAB and tab are aligned.

## 2) Theme consistency
- App uses one dark Material 3 theme with neon blue/purple accents.
- Navigation bar theme and card palette are centralized in `LeadAiApp`.

## 3) flutter analyze readiness
- This environment does not include Flutter SDK, so analyzer cannot be run here.
- Run locally:
  - `cd frontend`
  - `flutter pub get`
  - `flutter analyze`

## 4) Android package setup (`com.leadai.mobile`)
- This repository currently contains Dart source and `pubspec.yaml`, but does not include generated Android project files.
- Create Android scaffolding locally and set package id:
  1. `cd frontend`
  2. `flutter create . --platforms=android`
  3. Set `applicationId` and `namespace` to `com.leadai.mobile` in generated Gradle files.

## 5) Environment/config notes
- Provide API base URL via `--dart-define=API_BASE_URL=...`.
- `.env.example` documents expected values for local and emulator usage.
