Output screenshots/output/ollama.gif

Set Shell "bash"
Set FontSize 14
Set Width 1200
Set Height 800
Set Theme "Catppuccin Mocha"
Set TypingSpeed 80ms
Set Padding 0

# Start Ollama if not already running, then wait until it's ready
Type "ollama serve > /tmp/ollama.log 2>&1 &"
Enter
Type "until curl -s http://127.0.0.1:11434 > /dev/null 2>&1; do sleep 1; done && echo 'Ollama ready'"
Enter
Sleep 5s

# Use a smaller model so responses are fast enough for the recording
Type "export OLLAMA_MODEL=qwen2.5-coder:3b"
Enter

# Open a Lua file to use as the subject for AI prompts
Type "nvim lua/plugins/ollama.lua"
Enter
Sleep 4s

# --- ollama.nvim: which-key menu showing all Ollama prompts ---
Type " O"
Sleep 1.5s

Screenshot screenshots/output/ollama-whichkey.png
Escape
Sleep 0.5s

# --- ollama.nvim: Explain Code ---
# Visually select a block of code
Type "gg"
Sleep 0.3s
Type "/function"
Enter
Sleep 0.5s
Type "V"
Sleep 0.2s
Type "10j"
Sleep 0.3s

# Trigger Explain Code (<leader>Oe in visual mode)
Type " Oe"
Sleep 20s

Screenshot screenshots/output/ollama-explain.png
Sleep 1s

# Dismiss the display window
Type "q"
Sleep 0.5s

# --- ollama.nvim: Review Code ---
Type "gg"
Sleep 0.3s
Type "V"
Sleep 0.2s
Type "15j"
Sleep 0.3s
Type " Or"
Sleep 20s

Screenshot screenshots/output/ollama-review.png
Sleep 1s
