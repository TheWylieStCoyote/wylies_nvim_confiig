Output screenshots/output/trouble.gif

Set Shell "bash"
Set FontSize 14
Set FontFamily "JetBrainsMono Nerd Font Mono"
Set Width 1200
Set Height 800
Set Theme "Catppuccin Mocha"
Set TypingSpeed 80ms
Set Padding 0

Type "nvim lua/plugins/trouble.lua"
Enter
Sleep 3s

# Open workspace diagnostics
Type " xx"
Sleep 2s

Screenshot screenshots/output/trouble-diagnostics.png
Sleep 0.5s

# Switch to buffer-only diagnostics
Type " xX"
Sleep 1.5s

Screenshot screenshots/output/trouble-buffer-diagnostics.png
Sleep 0.5s

# Show symbols panel
Type " xs"
Sleep 1.5s

Screenshot screenshots/output/trouble-symbols.png
Sleep 0.5s

# Close trouble and show todo-comments via Telescope
Type "q"
Sleep 0.5s
Type " st"
Sleep 1.5s

Screenshot screenshots/output/todo-telescope.png
Sleep 0.5s

# Close and jump between TODOs inline
Escape
Sleep 0.3s
Type "]t"
Sleep 0.5s
Type "]t"
Sleep 0.5s

Screenshot screenshots/output/todo-inline.png
Sleep 1s
