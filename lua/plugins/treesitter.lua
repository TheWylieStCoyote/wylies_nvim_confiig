-- TreeSitter Configuration
-- nvim-treesitter's `main` branch has no auto_install/sync_install options;
-- LazyVim installs whatever is in `ensure_installed` at startup. config/deps.lua
-- empties that list on machines without a C compiler, tar and curl, so parsers
-- are only built where they can be. Use :TSInstall <parser> to install manually.

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {},
  },
}
