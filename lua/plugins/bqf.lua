-- BQF - Better Quickfix
-- Enhances the quickfix window with preview and fuzzy filtering

return {
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {
      auto_enable = true,
      auto_resize_height = true,
      preview = {
        auto_preview = true,
        win_height = 15,
        winblend = 0,
      },
      filter = {
        fzf = {
          action_for = { ["ctrl-s"] = "split", ["ctrl-v"] = "vsplit" },
          extra_opts = { "--bind", "ctrl-o:toggle-all" },
        },
      },
    },
    dependencies = {
      "junegunn/fzf",
    },
  },
}
