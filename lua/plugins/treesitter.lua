-- TreeSitter Configuration
-- Disable auto-install to prevent CPU spikes on startup

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- Disable auto-install of parsers
      -- Use :TSInstall <parser> to install manually
      auto_install = false,
      sync_install = false,
    },
  },
}
