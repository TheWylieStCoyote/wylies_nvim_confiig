-- Spell Checking Configuration
-- Enables spell checking in comments and strings for code files
--
-- Keybindings:
--   z=  - Show spelling suggestions
--   ]s  - Next misspelling
--   [s  - Previous misspelling
--   zg  - Add word to dictionary
--   zw  - Mark word as wrong

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, _opts)
      -- Enable spell checking with treesitter support
      vim.opt.spell = true
      vim.opt.spelllang = { "en_us" }
      vim.opt.spelloptions = "camel" -- Treat CamelCase as separate words

      vim.api.nvim_create_augroup("SpellCheck", { clear = true })

      -- Enable spell checking for code files (treesitter limits to comments/strings)
      vim.api.nvim_create_autocmd("FileType", {
        group = "SpellCheck",
        pattern = {
          "lua",
          "python",
          "javascript",
          "typescript",
          "typescriptreact",
          "javascriptreact",
          "rust",
          "go",
          "c",
          "cpp",
          "java",
          "kotlin",
          "ruby",
          "elixir",
          "haskell",
          "markdown",
          "text",
          "gitcommit",
        },
        callback = function()
          vim.opt_local.spell = true
        end,
      })

      -- Disable spell in certain filetypes
      vim.api.nvim_create_autocmd("FileType", {
        group = "SpellCheck",
        pattern = { "help", "terminal", "lazy", "mason", "notify", "qf", "oil", "NvimTree", "neo-tree" },
        callback = function()
          vim.opt_local.spell = false
        end,
      })
    end,
  },
}
