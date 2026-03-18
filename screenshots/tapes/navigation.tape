Output screenshots/output/navigation.gif

Set Shell "bash"
Set FontSize 14
Set FontFamily "JetBrainsMono Nerd Font Mono"
Set Width 1200
Set Height 800
Set Theme "Catppuccin Mocha"
Set TypingSpeed 80ms
Set Padding 0

Type "nvim lua/plugins/flash.lua"
Enter
Sleep 3s

# --- Flash.nvim: labeled jump ---
Type "s"
Sleep 0.5s
Type "re"
Sleep 1s

Screenshot screenshots/output/flash-labels.png
Escape
Sleep 0.5s

# Flash treesitter selection
Type "V"
Sleep 0.2s
Type "S"
Sleep 0.5s
Type "fu"
Sleep 1s

Screenshot screenshots/output/flash-treesitter.png
Escape
Sleep 0.5s

# --- Oil.nvim: filesystem as buffer ---
Type " fo"
Sleep 1.5s

Screenshot screenshots/output/oil-float.png
Sleep 0.5s

# Navigate into lua/plugins directory
Type "/plugins"
Enter
Sleep 0.5s
Enter
Sleep 1s

Screenshot screenshots/output/oil-directory.png
Sleep 0.5s

Escape
Sleep 0.3s

# --- Yazi: floating file manager ---
Type " fy"
Sleep 2s

Screenshot screenshots/output/yazi-float.png
Sleep 1s
