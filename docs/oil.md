# Oil - Filesystem Editor

> Edit your filesystem as a Neovim buffer

## Quick Reference

| Component | Tool |
|-----------|------|
| Plugin | stevearc/oil.nvim |
| Role | Secondary file explorer (neo-tree is default) |
| Columns | icon, permissions, size, mtime |

## Keybindings

### Global

| Key | Action |
|-----|--------|
| `-` | Open parent directory |
| `<leader>fo` | Open in floating window |

### Buffer Keymaps

| Key | Action |
|-----|--------|
| `g?` | Show help |
| `<CR>` | Select entry |
| `<C-v>` | Open in vsplit |
| `<C-s>` | Open in split |
| `<C-t>` | Open in tab |
| `<C-p>` | Preview |
| `<C-c>` | Close |
| `<C-r>` | Refresh |
| `-` | Go to parent directory |
| `_` | Open cwd |
| `` ` `` | cd to directory |
| `~` | tcd to directory |
| `gs` | Change sort |
| `gx` | Open external |
| `g.` | Toggle hidden files |
| `g\` | Toggle trash |

## Features

- Create, rename, move, and delete files by editing text
- Hidden files shown by default
- Floating window mode with rounded border
- Skip confirmation for simple edits
- Prompt to save on new entry selection

## Usage

```
1. Press `-` to open oil in current file's directory
2. Edit filenames to rename, delete lines to remove files
3. Save the buffer (:w) to apply changes
4. Press `-` again to navigate up
```

## Configuration

Located in `lua/plugins/oil.lua`

- Not set as default file explorer (neo-tree handles that)
- Float window: max 120 wide, 40 tall, rounded border
- Natural sort order enabled
