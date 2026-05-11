#!/usr/bin/env bash
set -euo pipefail

REPO_NAME="${1:-lead-ai-mobile}"
VISIBILITY="${2:-private}" # public|private
DESCRIPTION="AI lead capture assistant mobile app using Flutter, FastAPI, Firebase, and OpenAI"

if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI (gh) is not installed. Install it first: https://cli.github.com/"
  exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git init
fi

# Create GitHub repo and set remote origin
if [ "$VISIBILITY" = "public" ]; then
  gh repo create "$REPO_NAME" --public --source=. --remote=origin --description "$DESCRIPTION"
else
  gh repo create "$REPO_NAME" --private --source=. --remote=origin --description "$DESCRIPTION"
fi

echo "Repository created and origin remote configured."
