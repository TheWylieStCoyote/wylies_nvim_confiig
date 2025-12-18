# Todo Comments

> Highlight and search TODO, FIXME, HACK, NOTE, etc. in your code

## Quick Reference

| Component | Tool |
|-----------|------|
| Plugin | folke/todo-comments.nvim |
| Dependencies | plenary.nvim |

## Keybindings

| Key | Mode | Description |
|-----|------|-------------|
| `]t` | n | Next TODO comment |
| `[t` | n | Previous TODO comment |
| `<leader>xt` | n | Todo list (Trouble) |
| `<leader>xT` | n | Todo/Fix/Fixme (Trouble) |
| `<leader>st` | n | Search TODOs (Telescope) |
| `<leader>sT` | n | Search TODO/FIX/FIXME |

## Recognized Keywords

| Keyword | Aliases | Color | Description |
|---------|---------|-------|-------------|
| `TODO` | - | Blue | Tasks to do |
| `FIX` | FIXME, BUG, FIXIT, ISSUE | Red | Bugs to fix |
| `HACK` | - | Orange | Hacky workarounds |
| `WARN` | WARNING, XXX | Yellow | Warnings |
| `PERF` | OPTIM, PERFORMANCE, OPTIMIZE | Purple | Performance improvements |
| `NOTE` | INFO | Green | Notes and information |
| `TEST` | TESTING, PASSED, FAILED | Pink | Test-related |

## Usage Examples

```lua
-- TODO: Implement this feature
-- FIXME: This is broken
-- HACK: Temporary workaround
-- WARN: Deprecated API
-- PERF: Optimize this loop
-- NOTE: Important information
-- TEST: Add test coverage
```

## Commands

| Command | Description |
|---------|-------------|
| `:TodoTelescope` | Search all TODOs |
| `:TodoTrouble` | Show in Trouble |
| `:TodoQuickFix` | Add to quickfix |
| `:TodoLocList` | Add to location list |

## Configuration

Located in `lua/plugins/todo-comments.lua`

Features:
- Sign column indicators
- Highlighted keywords
- Multiline support
- Telescope/Trouble integration
