# Zen Mode - Distraction-Free Writing

Focus mode that hides UI elements and centers your content.

## Quick Reference

| Feature | Tool |
|---------|------|
| Plugin | zen-mode.nvim |
| Author | folke |
| Companion | twilight.nvim |

## Keybindings

| Key | Mode | Action |
|-----|------|--------|
| `<leader>uz` | n | Toggle Zen mode |

## Usage

```
1. Open a file you want to focus on
2. Press <leader>uz
3. UI elements disappear, content centers
4. Write without distractions
5. Press <leader>uz again to exit
```

## What Changes in Zen Mode

### Hidden Elements
- Line numbers
- Relative line numbers
- Sign column (git signs, diagnostics)
- Cursor line highlight

### Visual Changes
- Window width limited to 90 columns
- Content centered on screen
- Twilight dims surrounding code (optional)

### Plugin Integration
- tmux status bar hidden (if using tmux)
- gitsigns disabled

## Twilight Integration

Zen mode includes twilight.nvim which dims inactive code:

```
- Code near cursor is fully visible
- Code farther away is dimmed
- Helps focus on current context
- 15 lines of context shown
```

## Configuration

Current settings in `lua/plugins/zen-mode.lua`:

```lua
opts = {
  window = {
    width = 90,  -- Window width
    options = {
      number = false,
      relativenumber = false,
      signcolumn = "no",
      cursorline = false,
    },
  },
  plugins = {
    twilight = { enabled = true },
    gitsigns = { enabled = false },
    tmux = { enabled = true },
  },
}
```

## Customization

### Change Window Width

Edit `lua/plugins/zen-mode.lua`:

```lua
window = {
  width = 80,  -- Narrower
  -- or
  width = 120, -- Wider
}
```

### Disable Twilight

```lua
plugins = {
  twilight = { enabled = false },
}
```

### Keep Line Numbers

```lua
window = {
  options = {
    number = true,
    relativenumber = true,
  },
}
```

## Best Used For

- Writing documentation
- Long coding sessions
- Code review (one file focus)
- Writing prose in markdown
- Presentations

## Tips

### Quick Toggle

```
<leader>uz  -> Enter zen mode
... work ...
<leader>uz  -> Exit zen mode
```

### With Markdown

Great for writing README files or documentation:
- Centers text
- Removes distractions
- Twilight works with markdown headings

### Focus on Single Function

1. Navigate to function
2. `<leader>uz` to enter zen mode
3. Twilight dims other functions
4. Work on your function
5. `<leader>uz` to exit
