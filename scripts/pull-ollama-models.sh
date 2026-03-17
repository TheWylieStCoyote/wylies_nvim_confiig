#!/usr/bin/env bash
# Pull recommended Ollama models for Neovim coding use
# Usage: ./scripts/pull-ollama-models.sh [--fast-only]

set -euo pipefail

FAST_ONLY=${1:-}

echo "Checking Ollama is running..."
if ! curl -sf http://localhost:11434 > /dev/null 2>&1; then
  echo "Error: Ollama is not running. Start it with: ollama serve"
  exit 1
fi

pull() {
  local model=$1
  local desc=$2
  echo ""
  echo ">>> Pulling $model ($desc)..."
  ollama pull "$model"
}

# Fast / low resource models (always pulled)
pull qwen2.5-coder:3b  "3B - fast, low resource"
pull gemma2:2b         "2B - tiny, works on any machine"

if [[ "$FAST_ONLY" != "--fast-only" ]]; then
  # Best coding models
  pull qwen2.5-coder:7b    "7B - best overall coding model"
  pull codegemma:7b        "7B - Google coding model"
  pull codellama:13b       "13B - current default"
  pull deepseek-coder-v2   "16B - excellent for complex tasks"
  pull phi4                "14B - Microsoft, very efficient"

  # General purpose
  pull llama3.1:8b  "8B - strong all-rounder"
  pull mistral:7b   "7B - fast, good reasoning"
fi

echo ""
echo "Done! Installed models:"
ollama list
echo ""
echo "To set a default model:"
echo "  export OLLAMA_MODEL=qwen2.5-coder:7b"
