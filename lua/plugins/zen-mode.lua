-- Zen Mode - Distraction-free writing
-- Press <leader>uz to toggle zen mode

return {
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
    opts = {
      window = {
        width = 90,
        options = {
          number = false,
          relativenumber = false,
          signcolumn = "no",
          cursorline = false,
        },
      },
      plugins = {
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux = { enabled = true },
      },
    },
    dependencies = {
      {
        "folke/twilight.nvim",
        opts = {
          dimming = { alpha = 0.4 },
          context = 15,
        },
      },
    },
  },
}
