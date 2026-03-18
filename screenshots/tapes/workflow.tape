Output screenshots/output/workflow.gif

Set Shell "bash"
Set FontSize 14
Set Width 1200
Set Height 800
Set Theme "Catppuccin Mocha"
Set TypingSpeed 80ms
Set Padding 0

# --- Vim-Visual-Multi: multiple cursors ---
# Open a file with repeated identifiers to demo multi-select
Type "nvim lua/config/keymaps.lua"
Enter
Sleep 3s

Type "gg"
Sleep 0.3s
Type "/keymap"
Enter
Sleep 0.5s

# Ctrl+N selects word under cursor; each additional Ctrl+N adds next occurrence
Ctrl+N
Sleep 0.5s
Ctrl+N
Sleep 0.5s
Ctrl+N
Sleep 0.5s
Ctrl+N
Sleep 0.5s

Screenshot screenshots/output/multicursors.png

Escape
Sleep 0.5s

# --- Neogen: auto-generate docstring ---
Type ":e lua/plugins/dap.lua"
Enter
Sleep 2s
Type "gg"
Sleep 0.3s
# Find a function definition to generate docs for
Type "/function"
Enter
Sleep 0.5s
Type " cg"
Sleep 2s

Screenshot screenshots/output/neogen-docstring.png
Sleep 0.5s

# Dismiss the generated annotation and move on
Escape
Sleep 0.3s

# --- Refactoring: extract variable via Telescope menu ---
Type ":e lua/plugins/refactoring.lua"
Enter
Sleep 2s
Type "gg"
Sleep 0.3s
Type "/require"
Enter
Sleep 0.5s
# Visually select the string argument to extract
Type "vi'"
Sleep 0.3s
Type " er"
Sleep 1.5s

Screenshot screenshots/output/refactoring-menu.png
Sleep 0.5s

Escape
Sleep 0.3s

# --- NeoComposer: macro browser ---
Type ":e lua/config/keymaps.lua"
Enter
Sleep 2s
# Record a short macro first so the menu isn't empty
Type "qq"
Sleep 0.3s
Type "itest"
Escape
Sleep 0.3s
Type "q"
Sleep 0.5s
# Open the macro menu
Alt+Q
Sleep 1.5s

Screenshot screenshots/output/neocomposer-menu.png
Sleep 1s
