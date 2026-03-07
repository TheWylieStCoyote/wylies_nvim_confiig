-- Octo.nvim Configuration
-- GitHub issues, pull requests, and reviews inside Neovim

return {
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Octo",
    keys = {
      { "<leader>goi", "<cmd>Octo issue list<cr>", desc = "Octo: List Issues" },
      { "<leader>gop", "<cmd>Octo pr list<cr>", desc = "Octo: List PRs" },
      { "<leader>goc", "<cmd>Octo pr create<cr>", desc = "Octo: Create PR" },
      { "<leader>gor", "<cmd>Octo review start<cr>", desc = "Octo: Start Review" },
      { "<leader>gos", "<cmd>Octo search<cr>", desc = "Octo: Search" },
    },
    opts = {
      use_local_fs = false,
      enable_builtin = true,
      default_remote = { "upstream", "origin" },
      default_merge_method = "squash",
      ssh_aliases = {},
      picker = "telescope",
      suppress_missing_scope = {
        projects_v2 = true,
      },
    },
  },
}
