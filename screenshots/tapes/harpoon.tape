Output screenshots/output/harpoon.gif

Set Shell "bash"
Set FontSize 14
Set Width 1200
Set Height 800
Set Theme "Catppuccin Mocha"

Type "nvim lua/config/options.lua"
Enter
Sleep 3s

# Add file to harpoon
Type "ma"
Sleep 0.5s

# Open another file and add it
Type ":e lua/config/keymaps.lua"
Enter
Sleep 1s
Type "ma"
Sleep 0.5s

# Open harpoon menu
Type "mm"
Sleep 1s

Screenshot screenshots/output/harpoon-menu.png

# Navigate between files
Type "1"
Sleep 0.5s
Type "m1"
Sleep 1s

Screenshot screenshots/output/harpoon-nav.png
Sleep 1s
