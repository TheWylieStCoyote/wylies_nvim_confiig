Output screenshots/output/ui-extras.gif

Set Shell "bash"
Set FontSize 14
Set FontFamily "JetBrainsMono Nerd Font Mono"
Set Width 1200
Set Height 800
Set Theme "Catppuccin Mocha"
Set TypingSpeed 80ms
Set Padding 0

# --- Render-Markdown: styled markdown rendering ---
Type "nvim docs/keybindings.md"
Enter
Sleep 3s

Screenshot screenshots/output/markdown-raw.png
Sleep 0.3s

Type " um"
Sleep 1s

Screenshot screenshots/output/markdown-rendered.png
Sleep 0.5s

# --- Treesitter context: sticky context header ---
Type ":e lua/plugins/treesitter.lua"
Enter
Sleep 2s

Type "50G"
Sleep 0.5s

Screenshot screenshots/output/treesitter-context.png
Sleep 0.5s

# Scroll deeper to show context updating
Type "20j"
Sleep 0.5s

Screenshot screenshots/output/treesitter-context-deep.png
Sleep 0.5s

# --- Zen Mode: distraction-free editing ---
Type " uz"
Sleep 1.5s

Screenshot screenshots/output/zen-mode.png
Sleep 0.5s

# Twilight dims surrounding code — scroll to show it
Type "gg"
Sleep 0.3s
Type "20j"
Sleep 0.5s

Screenshot screenshots/output/zen-mode-twilight.png
Sleep 0.5s

# Exit zen mode
Type " uz"
Sleep 1s
