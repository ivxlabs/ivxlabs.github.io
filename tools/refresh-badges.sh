#!/usr/bin/env bash
# Refresh the self-hosted badge SVGs in static/badges/.
#
# They are vendored so visitors never hit a third party. The cost of that is
# that the numbers on them are only as current as the last run of this script,
# which is why the publish workflow runs it on every deploy — a badge nobody
# remembers to refresh reads as a stale site rather than a private one.
#
# A badge that cannot be fetched is not a reason to fail a deploy: the copy
# already in the tree is a perfectly good badge, only older. So a failure here
# says so and leaves that copy alone.
#
# Usage: tools/refresh-badges.sh
set -uo pipefail

cd "$(dirname "$0")/.."

# Written to a temp file first. curl -o truncates its target before it knows
# whether the request will succeed, which on a network blip would replace a
# working badge with an empty file.
fetch() {
  local url=$1 dest=$2 tmp
  tmp=$(mktemp)
  if curl -sSfL --max-time 20 "$url" -o "$tmp" && [ -s "$tmp" ]; then
    mv "$tmp" "$dest"
    echo "refreshed $dest"
  else
    rm -f "$tmp"
    echo "warning: could not refresh $dest — keeping the copy in the tree" >&2
  fi
}

fetch "https://img.shields.io/github/stars/ivxlabs/ivxai-app?style=social" \
      static/badges/github-stars.svg
fetch "https://alternativeto.net/static/badges/badge-compact-dark.svg" \
      static/badges/alternativeto.svg
