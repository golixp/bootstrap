#!/usr/bin/env bash

set -euo pipefail

REPO_URL="https://github.com/golixp/dotfiles.git"

echo "checking chezmoi..."

if ! command -v chezmoi >/dev/null 2>&1; then
  echo "error: chezmoi not found in PATH"
  echo "please install chezmoi first"
  exit 1
fi

echo "initializing dotfiles from ${REPO_URL}"

chezmoi init \
  --apply \
  "${REPO_URL}"

echo "done"
