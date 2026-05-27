#!/usr/bin/env bash
# render.sh — Render a Mermaid .mmd file to PNG or SVG
# Usage: render.sh <input.mmd> [output.png|output.svg]
#
# Env overrides:
#   MERMAID_SCALE              pixel scale factor for PNG (default 3 — keeps text crisp)
#   MERMAID_WIDTH              viewport width in px (default 1600)
#   MERMAID_BG                 background color (default white)
#   PUPPETEER_EXECUTABLE_PATH  explicit chrome binary; otherwise auto-detected

set -euo pipefail

INPUT="${1:-}"
OUTPUT="${2:-}"

if [[ -z "$INPUT" ]]; then
  echo "Usage: render.sh <input.mmd> [output.png|output.svg]" >&2
  exit 1
fi

if [[ ! -f "$INPUT" ]]; then
  echo "Error: File not found: $INPUT" >&2
  exit 1
fi

if [[ -z "$OUTPUT" ]]; then
  OUTPUT="${INPUT%.*}.png"
fi

mkdir -p "$(dirname "$OUTPUT")"

SCALE="${MERMAID_SCALE:-3}"
WIDTH="${MERMAID_WIDTH:-1600}"
BG="${MERMAID_BG:-white}"

# Find a Chrome binary. mermaid-cli pins a specific version that puppeteer
# may not have cached; auto-detect anything usable to avoid spurious installs.
find_chrome() {
  if [[ -n "${PUPPETEER_EXECUTABLE_PATH:-}" && -x "$PUPPETEER_EXECUTABLE_PATH" ]]; then
    echo "$PUPPETEER_EXECUTABLE_PATH"; return
  fi
  local cache="${PUPPETEER_CACHE_DIR:-$HOME/.cache/puppeteer}"
  # Prefer chrome-headless-shell (smaller, no .app bundle), newest first.
  local hit
  hit=$(ls -t "$cache"/chrome-headless-shell/*/chrome-headless-shell-*/chrome-headless-shell 2>/dev/null | head -1 || true)
  if [[ -n "$hit" && -x "$hit" ]]; then echo "$hit"; return; fi
  # Fall back to full Chrome.app on macOS.
  hit=$(ls -t "$cache"/chrome/*/chrome-mac-*/*.app/Contents/MacOS/* 2>/dev/null | head -1 || true)
  if [[ -n "$hit" && -x "$hit" ]]; then echo "$hit"; return; fi
}

CHROME="$(find_chrome || true)"

# Build a runtime puppeteer config (committed config has only args; the binary
# path is machine-specific so we inject it at runtime).
RUNTIME_CFG="$(mktemp -t mermaid-puppeteer.XXXXXX.json)"
trap 'rm -f "$RUNTIME_CFG"' EXIT
ARGS_JSON='["--no-sandbox","--disable-setuid-sandbox","--disable-dev-shm-usage"]'
if [[ -n "$CHROME" ]]; then
  printf '{"executablePath":%s,"args":%s}\n' \
    "$(printf '%s' "$CHROME" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))')" \
    "$ARGS_JSON" > "$RUNTIME_CFG"
else
  printf '{"args":%s}\n' "$ARGS_JSON" > "$RUNTIME_CFG"
fi

if command -v mmdc &>/dev/null; then
  MMDC_CMD=(mmdc)
elif command -v npx &>/dev/null; then
  echo "mmdc not found globally — using npx (may download on first run)..."
  MMDC_CMD=(npx --yes -p @mermaid-js/mermaid-cli mmdc)
else
  echo "Error: Neither mmdc nor npx found. Install Node.js first." >&2
  exit 1
fi

echo "Rendering: $INPUT → $OUTPUT (scale=${SCALE}x, width=${WIDTH}, bg=${BG})"
[[ -n "$CHROME" ]] && echo "Using Chrome: $CHROME"
"${MMDC_CMD[@]}" -p "$RUNTIME_CFG" -i "$INPUT" -o "$OUTPUT" -s "$SCALE" -w "$WIDTH" -b "$BG"
echo "✓ Done: $OUTPUT"
