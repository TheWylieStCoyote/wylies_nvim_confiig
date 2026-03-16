-- Enable bytecode caching for faster startup (Neovim 0.9+)
if vim.loader then
  vim.loader.enable()
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
