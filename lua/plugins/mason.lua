-- Mason Configuration
-- Disable ALL auto-installation to prevent startup delays
-- Use :Mason to install packages manually when needed

return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_installation = false,
    },
  },

  -- Override Mason's config to skip ensure_installed entirely
  {
    "mason-org/mason.nvim",
    config = function(_, opts)
      -- Remove ensure_installed before setup to prevent auto-install
      opts.ensure_installed = nil
      require("mason").setup(opts)
    end,
  },
}
