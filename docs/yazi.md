# Yazi

> Yazi terminal file manager integration

## Quick Reference

| Component | Tool |
|-----------|------|
| Plugin | mikavilpas/yazi.nvim |
| Dependencies | plenary.nvim |
| Requires | yazi (terminal file manager) |

## Installation

Yazi must be installed on your system:

```bash
# Arch Linux
pacman -S yazi

# macOS
brew install yazi

# Cargo
cargo install yazi-fm
```

## Keybindings

### Opening Yazi

| Key | Description |
|-----|-------------|
| `<leader>y` | Yazi at current file |
| `<leader>Y` | Yazi at cwd |
| `<leader>fy` | Yazi File Manager |

### Inside Yazi

| Key | Description |
|-----|-------------|
| `<C-v>` | Open in vertical split |
| `<C-x>` | Open in horizontal split |
| `<C-t>` | Open in new tab |
| `<C-s>` | Grep in directory |
| `<C-g>` | Replace in directory |
| `<C-y>` | Copy relative path |
| `<C-q>` | Send to quickfix |
| `<Tab>` | Cycle open buffers |
| `<F1>` | Show help |

## Features

- Float window file manager
- Open files in splits/tabs
- Grep/replace in directories
- Send files to quickfix
- Highlight current buffer in Yazi

## Yazi Basics

Once inside Yazi:

| Key | Description |
|-----|-------------|
| `j`/`k` | Navigate up/down |
| `h`/`l` | Go up/enter directory |
| `<Enter>` | Open file |
| `y` | Copy file |
| `d` | Cut file |
| `p` | Paste file |
| `a` | Create file |
| `r` | Rename |
| `D` | Delete (trash) |
| `/` | Search |
| `z` | Jump (zoxide) |
| `q` | Quit |

## Configuration

Located in `lua/plugins/yazi.lua`

Features:
- 90% window scaling
- Rounded border
- Buffer highlighting
- Multi-file selection
