-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
-- NOTE: The following are provided by LazyVim and removed from this file:
--   - highlight_yank (lazyvim_highlight_yank)
--   - restore_cursor (lazyvim_last_loc)
--   - close_with_q (lazyvim_close_with_q)
--   - checktime (lazyvim_checktime)
--   - resize_splits (lazyvim_resize_splits)

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Auto-create parent directories when saving a file
autocmd("BufWritePre", {
  group = augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return -- Skip URLs
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
  desc = "Auto-create directories on save",
})

-- Remove trailing whitespace on save (except for specific filetypes)
autocmd("BufWritePre", {
  group = augroup("trim_whitespace", { clear = true }),
  callback = function()
    local ft = vim.bo.filetype
    -- Skip filetypes where trailing whitespace matters
    if ft == "markdown" or ft == "diff" then
      return
    end
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, cursor)
  end,
  desc = "Remove trailing whitespace on save",
})

-- Disable line numbers in terminal
autocmd("TermOpen", {
  group = augroup("terminal_settings", { clear = true }),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
  desc = "Disable line numbers in terminal",
})
