# Minor Configuration Tweaks

Small overrides that disable default LazyVim or plugin behaviors.

## Quick Reference

| Tweak                     | Plugin Target       | Setting                |
|---------------------------|---------------------|------------------------|
| Disable news popups       | `LazyVim/LazyVim`   | `news.lazyvim = false` |
| Disable scroll animations | `folke/snacks.nvim` | `scroll.enabled = false` |

## Sources

- `lua/plugins/disable-news-alert.lua`
- `lua/plugins/snacks-animated-scrolling-off.lua`

## Disable News Alerts

Sets `news.lazyvim` and `news.neovim` to `false` in the LazyVim
opts table. This prevents the news popup that appears on startup
when LazyVim or Neovim has release notes to show.

```lua
-- disable-news-alert.lua
return {
  "LazyVim/LazyVim",
  opts = {
    news = {
      lazyvim = false,
      neovim = false,
    },
  },
}
```

## Disable Animated Scrolling

Sets `scroll.enabled` to `false` on `folke/snacks.nvim`. This
turns off the smooth scroll animations that snacks.nvim adds by
default, restoring instant jump behavior.

```lua
-- snacks-animated-scrolling-off.lua
return {
  "folke/snacks.nvim",
  opts = {
    scroll = {
      enabled = false,
    },
  },
}
```
