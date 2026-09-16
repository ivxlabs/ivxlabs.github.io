#!/usr/bin/env bash
# Regenerate static/og.png from tools/og.html.
# Usage: tools/make-og.sh
set -euo pipefail

cd "$(dirname "$0")/.."
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
[ -x "$CHROME" ] || CHROME="$(command -v chromium || command -v google-chrome)"

PROFILE="$(mktemp -d)"
OUT="$PWD/static/og.png"
rm -f "$OUT"

"$CHROME" --headless --disable-gpu --hide-scrollbars \
  --user-data-dir="$PROFILE" \
  --window-size=1200,630 \
  --force-device-scale-factor=2 \
  --screenshot="$OUT" \
  "file://$PWD/tools/og.html" >/dev/null 2>&1 &

for _ in $(seq 1 25); do [ -f "$OUT" ] && break; sleep 1; done
pkill -f "user-data-dir=$PROFILE" 2>/dev/null || true
sleep 1
rm -rf "$PROFILE" 2>/dev/null || true

[ -f "$OUT" ] || { echo "failed to render $OUT" >&2; exit 1; }
echo "wrote $OUT"
