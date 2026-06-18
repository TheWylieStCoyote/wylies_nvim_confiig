# Gitsigns

> Git decorations and hunk operations inline in the buffer

## Quick Reference

| Component | Tool |
|-----------|------|
| Plugin | lewis6991/gitsigns.nvim |

## Keybindings

| Key | Description |
|-----|-------------|
| `<leader>gb` | Blame current line (shows commit, author, date) |
| `<leader>gB` | Toggle inline blame virtual text on all lines |
| `<leader>gd` | Diff this file |
| `<leader>ghp` | Preview hunk inline |
| `<leader>ghs` | Stage hunk |
| `<leader>ghr` | Reset hunk |
| `<leader>ghS` | Stage entire buffer |
| `<leader>ghR` | Reset entire buffer |
| `]h` | Jump to next hunk |
| `[h` | Jump to previous hunk |

## Signs

Gitsigns shows change indicators in the sign column:

| Sign | Meaning |
|------|---------|
| `▎` | Added line |
| `▎` | Changed line |
| `` | Deleted line (below) |
| `` | Deleted line (above) |

## Configuration

Located in `lua/plugins/gitsigns.lua`

- Inline blame is off by default — toggle with `<leader>gB`
- Blame virtual text appears at end of line with 500ms delay
