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
          if vim.fn.executable("go") ~= 1 then
            return
          end
          require("lspconfig").gopls.setup({})
        end,
        -- Skip servers that need ghcup
        ["hls"] = function()
          if vim.fn.executable("ghcup") ~= 1 then
            return
          end
          require("lspconfig").hls.setup({})
        end,
        -- Skip servers that need opam
        ["ocamllsp"] = function()
          if vim.fn.executable("opam") ~= 1 then
            return
          end
          require("lspconfig").ocamllsp.setup({})
        end,
        -- Skip servers that need R
        ["r_language_server"] = function()
          if vim.fn.executable("R") ~= 1 then
            return
          end
          require("lspconfig").r_language_server.setup({})
        end,
      },
    },
  },

  -- Mason base configuration
  -- Language files can add to ensure_installed via opts extension
  {
    "mason-org/mason.nvim",
    opts = {
      -- Allow language files to specify tools via ensure_installed
    },
  },
}
