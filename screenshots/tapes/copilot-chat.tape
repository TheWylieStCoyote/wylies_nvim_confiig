Output screenshots/output/copilot-chat.gif

Set Shell "bash"
Set FontSize 14
Set FontFamily "JetBrainsMono Nerd Font Mono"
Set Width 1200
Set Height 800
Set Theme "Catppuccin Mocha"
Set TypingSpeed 80ms
Set Padding 0

Type "nvim lua/plugins/copilot.lua"
Enter
Sleep 3s

# Toggle Copilot Chat sidebar
Type " aa"
Sleep 2s

Screenshot screenshots/output/copilot-chat-open.png
Sleep 0.5s

# Ask a question about the current file
Type "What does this plugin configure and what are the main keybindings?"
Sleep 0.5s

Screenshot screenshots/output/copilot-chat-prompt.png

Enter
Sleep 6s

Screenshot screenshots/output/copilot-chat-response.png
Sleep 0.5s

# Go back to code and show explain code workflow
Type " aa"
Sleep 1s
Type "gg"
Sleep 0.3s
Type "V"
Sleep 0.2s
Type "20j"
Sleep 0.3s
Type " ae"
Sleep 4s

Screenshot screenshots/output/copilot-explain.png
Sleep 1s
