-- Utilities Configuration
-- Undotree, profiling, and misc utilities

return {
  -- Undotree - Visual undo history
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>U", "<cmd>UndotreeToggle<cr>", desc = "Undotree: Toggle" },
    },
    config = function()
      -- Undotree settings
      vim.g.undotree_WindowLayout = 2 -- Tree on left, diff below
      vim.g.undotree_SplitWidth = 30
      vim.g.undotree_DiffpanelHeight = 10
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_ShortIndicators = 1
    end,
  },

  -- Lazy.nvim profiling keybinding
  {
    "folke/lazy.nvim",
    keys = {
      { "<leader>up", "<cmd>Lazy profile<cr>", desc = "Lazy: Profile Startup" },
      { "<leader>ul", "<cmd>Lazy<cr>", desc = "Lazy: Open" },
      { "<leader>us", "<cmd>Lazy sync<cr>", desc = "Lazy: Sync" },
      { "<leader>uc", "<cmd>Lazy check<cr>", desc = "Lazy: Check Updates" },
    },
  },
}
