# Aerial - Code Outline

A code outline window for navigating and viewing code structure.

## Quick Reference

| Component | Value |
|-----------|-------|
| Plugin | stevearc/aerial.nvim |
| Backend | LSP, TreeSitter, Markdown, Man |
| Trigger | `<leader>cs` |

## Keybindings

### Global Keybindings

| Key | Action |
|-----|--------|
| `<leader>cs` | Toggle Aerial (Symbols sidebar) |
| `<leader>cS` | Toggle Aerial Nav (floating navigation) |
| `[s` | Jump to previous symbol |
| `]s` | Jump to next symbol |
| `[[` | Jump to previous parent symbol |
| `]]` | Jump to next parent symbol |

### Aerial Window Keybindings

When the Aerial window is focused:

| Key | Action |
|-----|--------|
| `<CR>` | Jump to symbol |
| `<C-v>` | Jump in vertical split |
| `<C-s>` | Jump in horizontal split |
| `p` | Scroll to symbol (preview) |
| `<C-j>` | Move down and scroll |
| `<C-k>` | Move up and scroll |
| `{` / `}` | Previous / Next symbol |
| `[[` / `]]` | Previous / Next parent symbol |
| `q` | Close Aerial |
| `?` / `g?` | Show help |

### Tree Navigation

| Key | Action |
|-----|--------|
| `o` / `za` | Toggle fold |
| `O` / `zA` | Toggle fold recursively |
| `l` / `zo` | Open tree node |
| `L` / `zO` | Open tree node recursively |
| `h` / `zc` | Close tree node |
| `H` / `zC` | Close tree node recursively |
| `zr` | Increase fold level |
| `zR` | Open all folds |
| `zm` | Decrease fold level |
| `zM` | Close all folds |

## Configuration

### Filtered Symbol Kinds

Aerial shows only these symbol types by default:
- Class
- Constructor
- Enum
- Function
- Interface
- Module
- Method
- Struct
- Type

### Layout

- Position: Right edge of window
- Width: 20-40 characters (max 20% of screen)
- Shows guides for hierarchy

## Usage Tips

1. **Quick Overview**: Use `<leader>cs` to get a bird's-eye view of your file structure
2. **Fast Navigation**: Press `[s` and `]s` to quickly jump between functions/methods
3. **Parent Navigation**: Use `[[` and `]]` to navigate up/down the hierarchy
4. **Preview Mode**: Press `p` in Aerial to preview a symbol without leaving the outline

## Integration

Aerial integrates with:
- LSP servers for accurate symbol information
- TreeSitter for syntax-aware parsing
- Markdown files for heading navigation
- Man pages for section navigation
