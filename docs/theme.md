# Theme Configuration

Monokai Pro (ristretto) with hot-reload support and 13 alternate themes.

## Quick Reference

| Action                  | How                                              |
|-------------------------|--------------------------------------------------|
| View active theme       | monokai-pro with `ristretto` filter              |
| Change theme            | Edit `theme.lua`, then `:Lazy reload`            |
| List available themes   | See table below or check `all-themes.lua`        |

## Sources

- `lua/plugins/theme.lua` — active theme and highlight overrides
- `lua/plugins/all-themes.lua` — lazy-loaded alternate themes
- `lua/plugins/omarchy-theme-hotreload.lua` — hot-reload system

## Active Theme

**monokai-pro** with the `ristretto` filter, configured via
`gthelding/monokai-pro.nvim`.

### Custom Highlight Overrides

| Highlight Group    | Color     |
|--------------------|-----------|
| `NonText`          | `#948a8b` |
| `MiniIconsGrey`    | `#948a8b` |
| `MiniIconsRed`     | `#fd6883` |
| `MiniIconsBlue`    | `#85dacc` |
| `MiniIconsGreen`   | `#adda78` |
| `MiniIconsYellow`  | `#f9cc6c` |
| `MiniIconsOrange`  | `#f38d70` |
| `MiniIconsPurple`  | `#a8a9eb` |
| `MiniIconsAzure`   | `#a8a9eb` |
| `MiniIconsCyan`    | `#85dacc` |

## Available Themes

All alternate themes are lazy-loaded with `priority = 1000`:

bamboo, aether, ethereal, hackerman, catppuccin, everforest,
flexoki, gruvbox, kanagawa, matteblack, nord, rose-pine, tokyonight

## Hot-Reload System

The `theme-hotreload` plugin listens for the `LazyReload` user
event and performs the following steps:

1. Unloads `plugins.theme` from `package.loaded`
2. Re-requires `plugins.theme` to pick up edits
3. Clears all highlight groups and resets `background` to `dark`
4. Unloads the theme plugin's Lua modules from `package.loaded`
5. Loads and applies the new colorscheme
6. Re-sources `plugin/after/transparency.lua`
7. Fires `ColorScheme` and `VimEnter` autocmds for plugin updates

### Changing the Theme

1. Edit `lua/plugins/theme.lua` — change the plugin spec and
   `colorscheme` value in the LazyVim opts block.
2. Run `:Lazy reload` to trigger the `LazyReload` event.
