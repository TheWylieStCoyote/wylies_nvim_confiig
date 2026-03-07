-- Session Management Configuration
-- Auto-save and restore sessions per project directory

return {
  {
    "rmagatti/auto-session",
    event = "VeryLazy",
    opts = {
      auto_restore = false, -- Don't auto-restore, use keybinding
      auto_save = true, -- Auto-save session on exit
      auto_create = true, -- Auto-create session when opening Neovim
      suppressed_dirs = { "~/", "~/Downloads", "~/Documents", "/" },
      allowed_dirs = nil, -- Allow all dirs except suppressed
      bypass_save_filetypes = { "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
      session_lens = {
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = false,
      },
    },
    keys = {
      { "<leader>qS", "<cmd>SessionSave<cr>", desc = "Save Session" },
      { "<leader>qR", "<cmd>SessionRestore<cr>", desc = "Restore Session" },
      { "<leader>qD", "<cmd>SessionDelete<cr>", desc = "Delete Session" },
      { "<leader>qs", "<cmd>SessionSearch<cr>", desc = "Search Sessions" },
      { "<leader>q.", "<cmd>SessionRestoreFromFile<cr>", desc = "Restore Session from File" },
    },
  },
}
