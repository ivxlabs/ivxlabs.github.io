#!/usr/bin/env bash
# Refresh the self-hosted badge SVGs in static/badges/.
# They are vendored so visitors never hit a third party; re-run this when the
# star count has drifted far enough to be worth updating.
# Usage: tools/refresh-badges.sh
set -euo pipefail

cd "$(dirname "$0")/.."

curl -sSfL "https://img.shields.io/github/stars/ivxlabs/ivxai-app?style=social" -o static/badges/github-stars.svg
curl -sSfL "https://alternativeto.net/static/badges/badge-compact-dark.svg"      -o static/badges/alternativeto.svg

echo "refreshed static/badges/"
