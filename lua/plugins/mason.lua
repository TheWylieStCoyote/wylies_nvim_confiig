-- Mason Configuration
-- Disable ALL auto-installation to prevent startup delays
-- Use :Mason to install packages manually when needed

return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_installation = false,
      -- Prevent auto-install of LSPs that require missing system dependencies
      handlers = {
        -- Skip servers that need Go
        ["gopls"] = function()
          if vim.fn.executable("go") ~= 1 then return end
          require("lspconfig").gopls.setup({})
        end,
        -- Skip servers that need ghcup
        ["hls"] = function()
          if vim.fn.executable("ghcup") ~= 1 then return end
          require("lspconfig").hls.setup({})
        end,
        -- Skip servers that need opam
        ["ocamllsp"] = function()
          if vim.fn.executable("opam") ~= 1 then return end
          require("lspconfig").ocamllsp.setup({})
        end,
        -- Skip servers that need R
        ["r_language_server"] = function()
          if vim.fn.executable("R") ~= 1 then return end
          require("lspconfig").r_language_server.setup({})
        end,
      },
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
