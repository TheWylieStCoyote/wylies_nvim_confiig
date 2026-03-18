Output screenshots/output/avante-test.gif
Set Shell "bash"
Set FontSize 14
Set Width 1200
Set Height 800
Set Theme "Catppuccin Mocha"

Type "nvim lua/plugins/avante.lua"
Enter
Sleep 5s
Type " Ap"
Sleep 2s
Type "ollama"
Sleep 0.5s
Enter
Sleep 2s
Type " Aa"
Sleep 3s
Screenshot screenshots/output/avante-test-open.png
Type "say hi"
Enter
Sleep 20s
Screenshot screenshots/output/avante-test-response.png
