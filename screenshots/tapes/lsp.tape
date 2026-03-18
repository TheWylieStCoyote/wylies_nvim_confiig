Output screenshots/output/lsp.gif

Set Shell "bash"
Set FontSize 14
Set FontFamily "JetBrainsMono Nerd Font Mono"
Set Width 1200
Set Height 800
Set Theme "Catppuccin Mocha"

# Open a Lua file with LSP active
Type "nvim lua/config/options.lua"
Enter
Sleep 3s

# Move to a symbol and trigger hover
Type "gg"
Sleep 0.5s
Type "/vim.opt"
Enter
Sleep 0.5s
Type "K"
Sleep 2s

Screenshot screenshots/output/lsp-hover.png

# Dismiss and show diagnostics
Escape
Sleep 0.3s
Type " xx"
Sleep 2s

Screenshot screenshots/output/lsp-diagnostics.png
Sleep 1s
