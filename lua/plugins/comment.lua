-- Comment.nvim - Smart commenting
-- Toggle comments with gcc/gc

return {
  -- Disable mini.comment to avoid conflict with Comment.nvim
  { "nvim-mini/mini.comment", enabled = false },

  {
    "numToStr/Comment.nvim",
    dependencies = {
      -- For JSX/TSX comment support
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      return {
        -- Add a space between comment and line
        padding = true,
        -- Whether cursor should stay at its position
        sticky = true,
        -- Lines to be ignored while commenting
        ignore = "^$", -- Ignore empty lines
        -- LHS of toggle mappings in NORMAL mode
        toggler = {
          line = "gcc", -- Line-comment toggle
          block = "gbc", -- Block-comment toggle
        },
        -- LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
          line = "gc", -- Line-comment operator
          block = "gb", -- Block-comment operator
        },
        -- Extra mappings
        extra = {
          above = "gcO", -- Add comment on line above
          below = "gco", -- Add comment on line below
          eol = "gcA", -- Add comment at end of line
        },
        -- Enable keybindings
        mappings = {
          basic = true,
          extra = true,
        },
        -- Pre-hook for JSX/TSX support
        pre_hook = function(ctx)
          local ok, ts_context = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
          if ok then
            return ts_context.create_pre_hook()(ctx)
          end
        end,
      }
    end,
  },
}
