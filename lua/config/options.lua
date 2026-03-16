-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = true -- Shows relative numbers
vim.opt.number = true -- Shows absolute number on the cursor line
vim.opt.signcolumn = "number" -- Keeps space for signs/numbers consistent

-- Disable unused providers for faster startup
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- Set Python provider path explicitly (avoids slow search)
-- Uncomment and set to your Python path if you use Python plugins
-- vim.g.python3_host_prog = "/usr/bin/python3"

-- Disable Python provider if not needed (uncomment to disable)
-- vim.g.loaded_python3_provider = 0

-- Project-specific configuration
-- Allows .nvim.lua, .nvimrc, or .exrc files in project directories
-- secure = true disables dangerous commands (autocmd, shell, write) in local configs
vim.opt.exrc = true
vim.opt.secure = true

-- Folding with Treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99 -- Start with all folds open
vim.opt.foldlevelstart = 99 -- Start with all folds open
vim.opt.foldenable = true

-- Persistent undo (survives closing and reopening Neovim)
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.opt.undolevels = 10000

-- Custom filetype detection
vim.filetype.add({
  extension = {
    jsonl = "jsonl",
  },
})
