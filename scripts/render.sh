#!/usr/bin/env bash
# render.sh — Render a Mermaid .mmd file to PNG or SVG
# Usage: render.sh <input.mmd> [output.png|output.svg]

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

# Default output: same name, .png extension
if [[ -z "$OUTPUT" ]]; then
  OUTPUT="${INPUT%.*}.png"
fi

# Ensure output directory exists
mkdir -p "$(dirname "$OUTPUT")"

# Detect mmdc
if command -v mmdc &>/dev/null; then
  MMDC="mmdc"
elif command -v npx &>/dev/null; then
  echo "mmdc not found globally — using npx (may download on first run)..."
  MMDC="npx --yes @mermaid-js/mermaid-cli mmdc"
else
  echo "Error: Neither mmdc nor npx found. Install Node.js first." >&2
  exit 1
fi

echo "Rendering: $INPUT → $OUTPUT"
$MMDC -i "$INPUT" -o "$OUTPUT"
echo "✓ Done: $OUTPUT"
