-- Yazi.nvim Configuration
-- Yazi terminal file manager integration

-- Skip if yazi is not installed
if vim.fn.executable("yazi") ~= 1 then
  return {}
end

return {
  {
    "mikavilpas/yazi.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
        open_file_in_vertical_split = "<c-v>",
        open_file_in_horizontal_split = "<c-x>",
        open_file_in_tab = "<c-t>",
        grep_in_directory = "<c-s>",
        replace_in_directory = "<c-g>",
        cycle_open_buffers = "<tab>",
        copy_relative_path_to_selected_files = "<c-y>",
        send_to_quickfix_list = "<c-q>",
      },
      floating_window_scaling_factor = 0.9,
      yazi_floating_window_border = "rounded",
      log_level = vim.log.levels.OFF,
      open_multiple_tabs = false,
      highlight_groups = {
        hovered_buffer = nil,
      },
    },
    keys = {
      { "<leader>y", "<cmd>Yazi<cr>", desc = "Yazi (current file)" },
      { "<leader>Y", "<cmd>Yazi cwd<cr>", desc = "Yazi (cwd)" },
      { "<leader>fy", "<cmd>Yazi<cr>", desc = "Yazi File Manager" },
    },
  },
}
