Output screenshots/output/neotest.gif

Set Shell "bash"
Set FontSize 14
Set Width 1200
Set Height 800
Set Theme "Catppuccin Mocha"
Set TypingSpeed 80ms
Set Padding 0

Type "nvim lua/plugins/neotest.lua"
Enter
Sleep 3s

# Open the Neotest summary panel
Type " tS"
Sleep 2s

Screenshot screenshots/output/neotest-summary.png
Sleep 0.5s

# Run all tests in the suite
Type " ta"
Sleep 4s

Screenshot screenshots/output/neotest-running.png
Sleep 3s

Screenshot screenshots/output/neotest-results.png
Sleep 0.5s

# Show output for nearest test
Type " to"
Sleep 1.5s

Screenshot screenshots/output/neotest-output.png
Sleep 0.5s

# Load and toggle coverage overlay
Escape
Sleep 0.3s
Type " tcl"
Sleep 3s
Type " tcc"
Sleep 1.5s

Screenshot screenshots/output/neotest-coverage.png
Sleep 1s
