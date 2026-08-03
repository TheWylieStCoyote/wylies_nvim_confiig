-- tuicr: code review TUI, opened in a snacks float like lazygit.
-- Requires the `tuicr` binary on PATH (tested against tuicr 0.19.1).
-- Keymaps live under <leader>gr (see which-key.lua for the group label).

local function tuicr(args, opts)
  if vim.fn.executable("tuicr") == 0 then
    vim.notify("tuicr is not on PATH", vim.log.levels.ERROR)
    return
  end

  local cmd = { "tuicr" }
  vim.list_extend(cmd, args or {})

  local term_opts = {
    cwd = LazyVim.root.git(),
    interactive = true, -- start insert, auto-close the float when tuicr exits
    win = {
      position = "float",
      width = 0.9,
      height = 0.9,
      border = "rounded",
      title = " tuicr ",
      title_pos = "center",
      backdrop = 60,
      wo = { winbar = "" },
      keys = {
        -- tuicr is a vim-keybinding TUI: keep <esc> for it instead of
        -- letting snacks' double-<esc>-to-normal-mode handler eat it.
        term_normal = false,
      },
      on_close = function()
        -- pick up anything tuicr touched on disk (annotations, review state)
        vim.cmd("checktime")
      end,
    },
  }

  Snacks.terminal.open(cmd, vim.tbl_deep_extend("force", term_opts, opts or {}))
end

return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>grr",
      function()
        tuicr({})
      end,
      desc = "Tuicr: Review (commit selector)",
    },
    {
      "<leader>grw",
      function()
        tuicr({ "-w" })
      end,
      desc = "Tuicr: Review Working Tree",
    },
    {
      "<leader>grf",
      function()
        local file = vim.fn.expand("%:p")
        if file == "" then
          vim.notify("No file in the current buffer", vim.log.levels.WARN)
          return
        end
        tuicr({ "-w", "-p", file })
      end,
      desc = "Tuicr: Review Current File",
    },
    {
      "<leader>gra",
      function()
        tuicr({ "-A" })
      end,
      desc = "Tuicr: Review All Tracked Files",
    },
    {
      "<leader>grp",
      function()
        vim.ui.input({ prompt = "PR/MR (number, owner/repo#N, or URL): " }, function(target)
          if target and target ~= "" then
            tuicr({ "pr", target })
          end
        end)
      end,
      desc = "Tuicr: Review PR/MR",
    },
  },
}
