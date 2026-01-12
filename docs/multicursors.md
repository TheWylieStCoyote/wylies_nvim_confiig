# Multi-Cursors (vim-visual-multi)

Multiple cursors for simultaneous editing, similar to VS Code and Sublime Text.

## Quick Reference

| Component | Value |
|-----------|-------|
| Plugin | mg979/vim-visual-multi |
| Theme | iceblue |
| Leader | `\` (backslash) |

## Keybindings

### Adding Cursors

| Key | Action |
|-----|--------|
| `<C-n>` | Select word under cursor / Find next occurrence |
| `<C-S-n>` | Select all occurrences of word |
| `<C-Down>` | Add cursor below |
| `<C-Up>` | Add cursor above |

### Managing Cursors

| Key | Action |
|-----|--------|
| `q` | Skip current match, move to next |
| `Q` | Remove current cursor/region |
| `u` | Undo |
| `<C-r>` | Redo |

### In Multi-Cursor Mode

Once you have multiple cursors active:

| Key | Action |
|-----|--------|
| `n` / `N` | Get next/previous occurrence |
| `[` / `]` | Select next/previous cursor |
| `<Tab>` | Switch between cursor/extend mode |
| `<Esc>` | Exit multi-cursor mode |

## Usage Examples

### Rename a Variable

1. Place cursor on variable name
2. Press `<C-n>` to select it
3. Press `<C-n>` repeatedly to select more occurrences
4. Type `c` to change, then type the new name
5. Press `<Esc>` to exit

### Select All Occurrences

1. Place cursor on word
2. Press `<C-S-n>` to select all occurrences at once
3. Edit all simultaneously

### Add Cursors Vertically

1. Press `<C-Down>` to add cursor below
2. Repeat to add more cursors
3. Edit multiple lines at once
4. Press `<Esc>` to exit

### Skip Unwanted Matches

1. Press `<C-n>` to start selecting
2. Press `q` to skip a match you don't want
3. Continue with `<C-n>` for the next match

## Modes

vim-visual-multi has two modes:

### Cursor Mode
- Multiple cursors act independently
- Good for typing at multiple locations

### Extend Mode
- Selections can be extended
- Good for selecting regions of text
- Press `<Tab>` to switch between modes

## Visual Feedback

- **Cursors**: Highlighted with the "iceblue" theme
- **Matches**: Underlined to show potential selections

## Comparison with VS Code

| VS Code | vim-visual-multi |
|---------|------------------|
| `Ctrl+D` | `<C-n>` |
| `Ctrl+Shift+L` | `<C-S-n>` |
| `Ctrl+Alt+Down` | `<C-Down>` |
| `Ctrl+Alt+Up` | `<C-Up>` |

## Tips

1. **Start small**: Begin with `<C-n>` to add cursors one at a time
2. **Use skip**: Press `q` to skip matches you don't want to edit
3. **Quick rename**: `<C-S-n>` followed by `c` is great for renaming
4. **Vertical editing**: `<C-Down>` is perfect for editing aligned code
5. **Exit cleanly**: Press `<Esc>` when done to return to normal mode
