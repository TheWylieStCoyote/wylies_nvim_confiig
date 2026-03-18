Output screenshots/output/avante.gif

Set Shell "bash"
Set FontSize 14
Set Width 1200
Set Height 800
Set Theme "Catppuccin Mocha"
Set TypingSpeed 80ms
Set Padding 0

# Ensure Ollama is running
Type "ollama serve > /tmp/ollama.log 2>&1 &"
Enter
Type "until curl -s http://127.0.0.1:11434 > /dev/null 2>&1; do sleep 1; done && echo 'Ollama ready'"
Enter
Sleep 5s

# Clear persisted Avante chat history so no stale error messages appear
Type "rm -rf ~/.local/state/nvim/avante/projects/__home__wylie__.config__nvim/history/"
Enter
Sleep 0.5s

Type "nvim lua/plugins/avante.lua"
Enter
Sleep 4s

# Open a fresh chat (default provider is now ollama — no API key errors)
Type " Ac"
Sleep 2s

Screenshot screenshots/output/avante-open.png
Sleep 0.5s

Type "What providers does this config support and what is the default?"
Sleep 0.5s

Screenshot screenshots/output/avante-prompt.png

Ctrl+S
Sleep 30s

Screenshot screenshots/output/avante-response.png
Sleep 0.5s

# --- Avante: provider picker ---
Type " Ap"
Sleep 2s

Screenshot screenshots/output/avante-switch-provider.png
Escape
Sleep 0.5s

# --- Avante: inline edit on a visual selection ---
Type "gg"
Sleep 0.3s
Type "V"
Sleep 0.2s
Type "10j"
Sleep 0.3s
Type " Ae"
Sleep 2s

Screenshot screenshots/output/avante-edit-prompt.png
Sleep 0.5s

Type "Add a brief comment above each provider explaining when to use it"
Ctrl+S
Sleep 30s

Screenshot screenshots/output/avante-edit-diff.png
Sleep 1s
