# NeoComposer - Macro Manager

> Macro management with browse, edit, and replay

## Quick Reference

| Component | Tool |
|-----------|------|
| Plugin | ecthelionvi/NeoComposer.nvim |
| Persistence | sqlite |
| Integration | Telescope |

## Keybindings

| Key | Action |
|-----|--------|
| `q` | Toggle macro recording |
| `Q` | Play macro |
| `yq` | Yank macro |
| `cq` | Stop macro |
| `<C-n>` | Cycle to next macro |
| `<C-p>` | Cycle to previous macro |
| `<M-q>` | Toggle macro menu |

## Features

- Record, play, and manage macros
- Browse macro history in a floating menu
- Edit recorded macros as text
- Cycle through macro queue
- SQLite-backed persistence across sessions
- Yank macros to clipboard
- Telescope picker for macro selection

## Macro Menu

Press `<M-q>` (Alt-q) to open the floating menu:

```
+--------------------------------------------+
| Macro 1: iHello World<Esc>                 |
| Macro 2: dd3jp                             |
| Macro 3: ciw"<C-r>""<Esc>                  |
+--------------------------------------------+
```

- Menu window: 60 wide, 10 tall, rounded border

## Usage

```
1. q           -- Start recording a macro
2. (perform actions)
3. q           -- Stop recording
4. Q           -- Replay the macro
5. <C-n>/<C-p> -- Cycle between saved macros
6. <M-q>       -- Browse all macros
```

## Configuration

Located in `lua/plugins/neocomposer.lua`

- Notifications enabled
- Delay timer: 150ms
- Most recent macro not auto-queued
