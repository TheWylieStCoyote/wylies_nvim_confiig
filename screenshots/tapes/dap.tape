Output screenshots/output/dap.gif

Set Shell "bash"
Set FontSize 14
Set Width 1200
Set Height 800
Set Theme "Catppuccin Mocha"
Set TypingSpeed 80ms
Set Padding 0

Type "nvim lua/plugins/dap.lua"
Enter
Sleep 3s

# Set a breakpoint on line 10
Type "10G"
Sleep 0.3s
Type " db"
Sleep 0.8s

Screenshot screenshots/output/dap-breakpoint.png
Sleep 0.3s

# Set a second breakpoint and a log point
Type "20G"
Sleep 0.3s
Type " db"
Sleep 0.5s
Type "30G"
Sleep 0.3s
Type " dL"
Sleep 0.5s

# Open DAP UI
Type " du"
Sleep 2s

Screenshot screenshots/output/dap-ui.png
Sleep 0.5s

# Show the breakpoints list
Type " dB"
Sleep 1.5s

Screenshot screenshots/output/dap-breakpoints-list.png
Sleep 0.5s

# Add a watch expression
Type " dw"
Sleep 1s
Type "vim.o.columns"
Enter
Sleep 1s

Screenshot screenshots/output/dap-watches.png
Sleep 1s
