#!/usr/bin/env bash
# Render all VHS tape files and copy output to docs/img/
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TAPES_DIR="$REPO_ROOT/screenshots/tapes"
OUTPUT_DIR="$REPO_ROOT/screenshots/output"
DOCS_IMG_DIR="$REPO_ROOT/docs/img"

# Ensure ~/go/bin is on PATH (VHS is commonly installed there)
export PATH="$HOME/go/bin:$PATH"

# Install VHS if missing
if ! command -v vhs &>/dev/null; then
  echo "VHS not found. Installing..."
  if command -v go &>/dev/null; then
    go install github.com/charmbracelet/vhs@latest
    export PATH="$HOME/go/bin:$PATH"
  elif command -v brew &>/dev/null; then
    brew install vhs
  elif command -v apt-get &>/dev/null; then
    sudo apt-get install -y vhs
  else
    echo "ERROR: Cannot install VHS automatically. Install manually: https://github.com/charmbracelet/vhs"
    exit 1
  fi
fi

# Install ttyd if missing (required by VHS)
if ! command -v ttyd &>/dev/null; then
  echo "ttyd not found. Installing..."
  if command -v brew &>/dev/null; then
    brew install ttyd
  elif command -v apt-get &>/dev/null; then
    sudo apt-get install -y ttyd
  else
    echo "ERROR: ttyd is required by VHS. Install from https://github.com/tsl0922/ttyd"
    exit 1
  fi
fi

# Check for ffmpeg
if ! command -v ffmpeg &>/dev/null; then
  echo "WARNING: ffmpeg not found — GIF/MP4 output may fail. Install ffmpeg."
fi

mkdir -p "$OUTPUT_DIR" "$DOCS_IMG_DIR"

# Render each tape from the repo root so relative Output paths resolve correctly
cd "$REPO_ROOT"

RENDERED=0
FAILED=0

for tape in "$TAPES_DIR"/*.tape; do
  name="$(basename "$tape" .tape)"
  echo "Rendering: $name..."
  if vhs "$tape"; then
    RENDERED=$((RENDERED + 1))
  else
    echo "  FAILED: $name"
    FAILED=$((FAILED + 1))
  fi
done

# Copy all generated PNGs and GIFs to docs/img/
echo ""
echo "Copying output to docs/img/..."
find "$OUTPUT_DIR" -name "*.png" -o -name "*.gif" -o -name "*.mp4" -o -name "*.webp" | while read -r f; do
  cp "$f" "$DOCS_IMG_DIR/"
  echo "  Copied: $(basename "$f")"
done

echo ""
echo "Done. Rendered: $RENDERED, Failed: $FAILED"
echo "Output:   $OUTPUT_DIR"
echo "Docs img: $DOCS_IMG_DIR"
