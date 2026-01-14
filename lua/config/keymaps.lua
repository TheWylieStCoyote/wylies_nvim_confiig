-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Better window resizing with arrows
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move lines up/down in visual mode (keeps selection)
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down", silent = true })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selection up", silent = true })

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })

-- Keep cursor centered when searching
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Better paste (don't overwrite register with replaced text)
map("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" })

-- Delete to void register (don't overwrite clipboard)
-- Using <leader>D to avoid conflict with Debug group
map({ "n", "v" }, "<leader>D", [["_d]], { desc = "Delete to void register" })

-- Quick save
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Select all
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- Better indenting (stay in visual mode)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Quick escape from insert mode
map("i", "jk", "<esc>", { desc = "Exit insert mode" })
map("i", "kj", "<esc>", { desc = "Exit insert mode" })

-- Clear search highlighting
map("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear search highlight" })

-- Quick access to command mode
map("n", ";", ":", { desc = "Command mode" })

-- Join lines without moving cursor
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })

-- Git: stage current file
map("n", "<leader>ga", function()
  local file = vim.fn.expand("%")
  if file == "" then
    vim.notify("No file to stage", vim.log.levels.WARN)
    return
  end
  vim.fn.system({ "git", "add", file })
  if vim.v.shell_error == 0 then
    vim.notify("Staged: " .. vim.fn.fnamemodify(file, ":t"), vim.log.levels.INFO)
  else
    vim.notify("Failed to stage file", vim.log.levels.ERROR)
  end
end, { desc = "Git add (stage) current file" })

-- Terminal in new tab
map("n", "<leader>tN", "<cmd>tabnew | terminal<cr>", { desc = "Terminal in new tab" })
