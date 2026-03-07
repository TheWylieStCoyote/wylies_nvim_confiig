# Overseer - Task Runner

> Task runner and build system with VS Code tasks.json support

## Quick Reference

| Component | Tool |
|-----------|------|
| Plugin | stevearc/overseer.nvim |
| Strategy | terminal |
| Panel | Bottom, height 15-25 |

## Keybindings

### Global (`<leader>v...`)

| Key | Action |
|-----|--------|
| `<leader>vr` | Run Task |
| `<leader>vt` | Toggle Panel |
| `<leader>va` | Task Action |
| `<leader>vl` | Run Last |
| `<leader>vb` | Build |
| `<leader>vi` | Info |
| `<leader>vs` | Save Bundle |
| `<leader>vo` | Load Bundle |

### Task List Panel

| Key | Action |
|-----|--------|
| `?` / `g?` | Show help |
| `<CR>` | Run action |
| `<C-e>` | Edit task |
| `o` | Open task |
| `<C-v>` | Open in vsplit |
| `<C-s>` | Open in split |
| `<C-f>` | Open in float |
| `<C-q>` | Send to quickfix |
| `p` | Toggle preview |
| `<C-l>` / `<C-h>` | Increase/decrease detail |
| `L` / `H` | Increase/decrease all detail |
| `]` / `[` | Increase/decrease width |
| `}` / `{` | Next/previous task |
| `<C-k>` / `<C-j>` | Scroll output up/down |
| `q` | Close |

## Features

- Run arbitrary tasks from a picker menu
- VS Code `tasks.json` compatibility
- Task bundling (save/load sets of tasks)
- Multiple output strategies (terminal, quickfix, float)
- Built-in task templates

## Commands

| Command | Description |
|---------|-------------|
| `:OverseerRun` | Pick and run a task |
| `:OverseerToggle` | Toggle task list panel |
| `:OverseerBuild` | Build task |
| `:OverseerTaskAction` | Pick action for a task |
| `:OverseerInfo` | Show Overseer info |
| `:OverseerSaveBundle` | Save current tasks |
| `:OverseerLoadBundle` | Load saved tasks |

## Configuration

Located in `lua/plugins/overseer.lua`

- Rounded borders on all windows
- Default detail level 1 in task list
- Built-in templates enabled
