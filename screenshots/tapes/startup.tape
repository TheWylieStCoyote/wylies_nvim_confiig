Output screenshots/output/startup.gif

Set Shell "bash"
Set FontSize 14
Set FontFamily "JetBrainsMono Nerd Font Mono"
Set Width 1200
Set Height 800
Set Theme "Catppuccin Mocha"
Set TypingSpeed 80ms
Set Padding 0

# Open Neovim on the config directory
Type "nvim ."
Enter
Sleep 4s

# Show the dashboard / file tree
Screenshot screenshots/output/startup-dashboard.png
Sleep 1s

# Open a Lua plugin file via Telescope
Type " ff"
Sleep 1s
Type "copilot"
Sleep 0.8s
Enter
Sleep 2s

# Show the file with syntax highlighting
Screenshot screenshots/output/startup-syntax.png
Sleep 0.5s

# Trigger LSP hover on a symbol
Type "gg"
Sleep 0.3s
Type "/require"
Enter
Sleep 0.5s
Type "K"
Sleep 2s

Screenshot screenshots/output/startup-lsp-hover.png
Escape
Sleep 0.3s

# Show blink.cmp completion
Type "o"
Sleep 0.3s
Type "vim."
Sleep 1.5s

Screenshot screenshots/output/startup-completion.png
Escape
Sleep 0.3s
Type "u"

# Show which-key menu
Type " "
Sleep 1.5s

Screenshot screenshots/output/startup-whichkey.png
Escape
Sleep 0.3s

# Open file tree (neo-tree)
Type " e"
Sleep 1.5s

Screenshot screenshots/output/startup-filetree.png
Sleep 0.5s

# Close file tree
Type " e"
Sleep 0.5s

# Show code outline with aerial
Type " cs"
Sleep 1.5s

Screenshot screenshots/output/startup-outline.png
Sleep 1s
