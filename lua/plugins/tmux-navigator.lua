-- vim-tmux-navigator - Seamless C-h/j/k/l navigation between Neovim splits and tmux panes
-- Pairs with the tmux side of the plugin in ~/.config/tmux/tmux.conf

return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate left (tmux-aware)" },
    { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate down (tmux-aware)" },
    { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate up (tmux-aware)" },
    { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate right (tmux-aware)" },
  },
}
