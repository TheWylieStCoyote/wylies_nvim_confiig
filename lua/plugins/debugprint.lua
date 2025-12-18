-- debugprint.nvim Configuration
-- Quick debug print statement insertion

return {
  {
    "andrewferrier/debugprint.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    version = "*",
    opts = {
      keymaps = {
        normal = {
          plain_below = "g?p",
          plain_above = "g?P",
          variable_below = "g?v",
          variable_above = "g?V",
          variable_below_alwaysprompt = nil,
          variable_above_alwaysprompt = nil,
          textobj_below = "g?o",
          textobj_above = "g?O",
          toggle_comment_debug_prints = nil,
          delete_debug_prints = nil,
        },
        insert = {
          plain = "<C-G>p",
          variable = "<C-G>v",
        },
        visual = {
          variable_below = "g?v",
          variable_above = "g?V",
        },
      },
      commands = {
        toggle_comment_debug_prints = "ToggleCommentDebugPrints",
        delete_debug_prints = "DeleteDebugPrints",
      },
      display_counter = true,
      display_snippet = true,
      move_to_debugline = false,
      print_tag = "DEBUG",
    },
    keys = {
      { "g?p", mode = "n", desc = "Debug print below" },
      { "g?P", mode = "n", desc = "Debug print above" },
      { "g?v", mode = { "n", "v" }, desc = "Debug print variable below" },
      { "g?V", mode = { "n", "v" }, desc = "Debug print variable above" },
      { "g?o", mode = "n", desc = "Debug print text object below" },
      { "g?O", mode = "n", desc = "Debug print text object above" },
      { "<leader>dP", "<cmd>ToggleCommentDebugPrints<cr>", desc = "Toggle Debug Prints" },
      { "<leader>dX", "<cmd>DeleteDebugPrints<cr>", desc = "Delete Debug Prints" },
    },
  },
}
