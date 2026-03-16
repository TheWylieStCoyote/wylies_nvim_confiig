-- Treesitter Context Configuration
-- Shows sticky function/class context at top of screen

return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    opts = {
      enable = true,
      max_lines = 3, -- Max lines of context to show
      min_window_height = 20, -- Min editor height to enable
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = "outer",
      mode = "cursor", -- "cursor" or "topline"
      separator = nil, -- Set to "─" for a separator line
      zindex = 20,
      on_attach = nil,
    },
    keys = {
      {
        "[C",
        function()
          require("treesitter-context").go_to_context(vim.v.count1)
        end,
        desc = "Go to Context",
      },
      {
        "<leader>uc",
        function()
          require("treesitter-context").toggle()
        end,
        desc = "Toggle Treesitter Context",
      },
    },
  },
}
