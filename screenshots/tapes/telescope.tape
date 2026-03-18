Output screenshots/output/telescope.gif

Set Shell "bash"
Set FontSize 14
Set Width 1200
Set Height 800
Set Theme "Catppuccin Mocha"

Type "nvim ."
Enter
Sleep 3s

# Open Telescope file finder
Type " ff"
Sleep 1s

Screenshot screenshots/output/telescope-files.png

# Type to filter
Type "options"
Sleep 1s

Screenshot screenshots/output/telescope-filtered.png

Escape
Sleep 0.5s

# Open live grep
Type " sg"
Sleep 1s
Type "keymap"
Sleep 1.5s

Screenshot screenshots/output/telescope-grep.png
Sleep 1s
