# DAP - Debug Adapter Protocol

Centralized debug adapter configuration with persistent breakpoints and inline variable display.

## Quick Reference

| Component | Value |
|-----------|-------|
| Core | mfussenegger/nvim-dap |
| UI | rcarriga/nvim-dap-ui |
| Virtual Text | theHamsta/nvim-dap-virtual-text |
| Breakpoints | Weissle/persistent-breakpoints.nvim |
| Storage | `stdpath("data")/breakpoints` |

## Keybindings

### Breakpoints (Persistent)

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle Breakpoint |
| `<leader>dB` | Conditional Breakpoint |
| `<leader>dL` | Log Point |
| `<leader>dc` | Clear All Breakpoints |
| `<F9>` | Toggle Breakpoint |

### Debug Control (LazyVim Defaults)

| Key | Action |
|-----|--------|
| `<F5>` | Continue |
| `<F10>` | Step Over |
| `<F11>` | Step Into |
| `<S-F11>` | Step Out |

## Features

- **DAP UI** auto-opens on debug start and auto-closes on terminate/exit
- **Virtual text** shows variable values inline at end of line
- **Persistent breakpoints** saved across sessions to `stdpath("data")/breakpoints`
- **Language-specific configs** live in individual language files (cpp.lua, python.lua, etc.)

## Configuration

### Sign Icons

| Sign | Icon |
|------|------|
| Stopped | 󰁕 |
| Breakpoint |  |
| BreakpointCondition |  |
| BreakpointRejected |  |
| LogPoint | .> |

### Virtual Text Settings

- Highlight changed variables: enabled
- Show stop reason: enabled
- Display position: end of line
- Only first definition: enabled
