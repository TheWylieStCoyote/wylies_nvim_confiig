-- vim-visual-multi - Multiple cursors like VS Code/Sublime
-- Select and edit multiple locations simultaneously

return {
  "mg979/vim-visual-multi",
  branch = "master",
  keys = {
    { "<C-n>", mode = { "n", "v" }, desc = "Multi-cursor: Select word" },
    { "<C-Down>", desc = "Multi-cursor: Add cursor down" },
    { "<C-Up>", desc = "Multi-cursor: Add cursor above" },
    { "<C-S-n>", desc = "Multi-cursor: Select all" },
  },
  init = function()
    -- Configuration must be set before plugin loads
    vim.g.VM_default_mappings = 1
    vim.g.VM_mouse_mappings = 0
    vim.g.VM_theme = "iceblue"
    vim.g.VM_highlight_matches = "underline"

    vim.g.VM_maps = {
      ["Find Under"] = "<C-n>",         -- Select word under cursor
      ["Find Subword Under"] = "<C-n>", -- Select partial word
      ["Select All"] = "<C-S-n>",       -- Select all occurrences
      ["Add Cursor Down"] = "<C-Down>", -- Add cursor below
      ["Add Cursor Up"] = "<C-Up>",     -- Add cursor above
      ["Skip Region"] = "q",            -- Skip current match
      ["Remove Region"] = "Q",          -- Remove current cursor
      ["Undo"] = "u",
      ["Redo"] = "<C-r>",
    }

    -- Leader mappings
    vim.g.VM_leader = "\\"
  end,
}
