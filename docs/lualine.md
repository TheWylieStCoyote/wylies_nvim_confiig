# Lualine Statusline Enhancements

Two custom components added to LazyVim's default lualine configuration.

## Quick Reference

| Component         | Section    | Color                    | Visible When          |
|-------------------|------------|--------------------------|-----------------------|
| Macro recording   | `lualine_x`| `#ff6188` (pink, bold)  | Recording a macro     |
| Search count      | `lualine_x`| `#a9dc76` (green)       | hlsearch is active    |

## Source

`lua/plugins/lualine.lua`

## Components

### Macro Recording Indicator

Displays **Recording @{register}** while a macro is being recorded.
Uses `vim.fn.reg_recording()` to detect the active register. The
component is conditionally shown — it only renders when a recording
is in progress.

- Color: `#ff6188` (Monokai pink) with bold
- Position: first item in `lualine_x`

### Search Count Indicator

Displays **[current/total]** during an active search with
`hlsearch` enabled. Uses `vim.fn.searchcount()` with a max count
of 999 and a 500ms timeout. Hidden when hlsearch is off.

- Color: `#a9dc76` (Monokai green)
- Position: second item in `lualine_x`

## Integration

The plugin is marked `optional = true` and loads on `VeryLazy`.
It extends the existing `opts` table rather than replacing it,
so all of LazyVim's default lualine sections remain intact.
