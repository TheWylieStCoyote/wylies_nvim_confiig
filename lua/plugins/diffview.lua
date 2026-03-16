-- Diffview Configuration
-- Git diff viewer and file history

return {
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    config = function()
      local actions = require("diffview.actions")

      require("diffview").setup({
        diff_binaries = false,
        enhanced_diff_hl = true,
        git_cmd = { "git" },
        hg_cmd = { "hg" },
        use_icons = true,
        show_help_hints = true,
        watch_index = true,

        icons = {
          folder_closed = "",
          folder_open = "",
        },

        signs = {
          fold_closed = "",
          fold_open = "",
          done = "✓",
        },

        view = {
          default = {
            layout = "diff2_horizontal",
            winbar_info = false,
          },
          merge_tool = {
            layout = "diff3_horizontal",
            disable_diagnostics = true,
            winbar_info = true,
          },
          file_history = {
            layout = "diff2_horizontal",
            winbar_info = false,
          },
        },

        file_panel = {
          listing_style = "tree",
          tree_options = {
            flatten_dirs = true,
            folder_statuses = "only_folded",
          },
          win_config = {
            position = "left",
            width = 35,
            win_opts = {},
          },
        },

        file_history_panel = {
          log_options = {
            git = {
              single_file = {
                diff_merges = "combined",
              },
              multi_file = {
                diff_merges = "first-parent",
              },
            },
          },
          win_config = {
            position = "bottom",
            height = 16,
            win_opts = {},
          },
        },

        commit_log_panel = {
          win_config = {
            win_opts = {},
          },
        },

        default_args = {
          DiffviewOpen = {},
          DiffviewFileHistory = {},
        },

        hooks = {
          view_opened = function(_view)
            -- Disable certain features in diff view
            vim.opt_local.spell = false
            vim.opt_local.wrap = false
          end,
        },

        keymaps = {
          disable_defaults = false,
          view = {
            { "n", "<tab>", actions.select_next_entry, { desc = "Next file" } },
            { "n", "<s-tab>", actions.select_prev_entry, { desc = "Previous file" } },
            { "n", "gf", actions.goto_file_edit, { desc = "Open file" } },
            { "n", "<C-w><C-f>", actions.goto_file_split, { desc = "Open file (split)" } },
            { "n", "<C-w>gf", actions.goto_file_tab, { desc = "Open file (tab)" } },
            { "n", "<leader>e", actions.focus_files, { desc = "Focus file panel" } },
            { "n", "<leader>b", actions.toggle_files, { desc = "Toggle file panel" } },
            { "n", "g<C-x>", actions.cycle_layout, { desc = "Cycle layout" } },
            { "n", "[x", actions.prev_conflict, { desc = "Previous conflict" } },
            { "n", "]x", actions.next_conflict, { desc = "Next conflict" } },
            { "n", "<leader>co", actions.conflict_choose("ours"), { desc = "Choose OURS" } },
            { "n", "<leader>ct", actions.conflict_choose("theirs"), { desc = "Choose THEIRS" } },
            { "n", "<leader>cb", actions.conflict_choose("base"), { desc = "Choose BASE" } },
            { "n", "<leader>ca", actions.conflict_choose("all"), { desc = "Choose ALL" } },
            { "n", "dx", actions.conflict_choose("none"), { desc = "Delete conflict" } },
            { "n", "<leader>cO", actions.conflict_choose_all("ours"), { desc = "Choose OURS (all)" } },
            { "n", "<leader>cT", actions.conflict_choose_all("theirs"), { desc = "Choose THEIRS (all)" } },
            { "n", "<leader>cB", actions.conflict_choose_all("base"), { desc = "Choose BASE (all)" } },
            { "n", "<leader>cA", actions.conflict_choose_all("all"), { desc = "Choose ALL (all)" } },
            { "n", "dX", actions.conflict_choose_all("none"), { desc = "Delete all conflicts" } },
          },
          diff1 = {},
          diff2 = {},
          diff3 = {
            { { "n", "x" }, "2do", actions.diffget("ours"), { desc = "Get OURS" } },
            { { "n", "x" }, "3do", actions.diffget("theirs"), { desc = "Get THEIRS" } },
          },
          diff4 = {
            { { "n", "x" }, "1do", actions.diffget("base"), { desc = "Get BASE" } },
            { { "n", "x" }, "2do", actions.diffget("ours"), { desc = "Get OURS" } },
            { { "n", "x" }, "3do", actions.diffget("theirs"), { desc = "Get THEIRS" } },
          },
          file_panel = {
            { "n", "j", actions.next_entry, { desc = "Next entry" } },
            { "n", "<down>", actions.next_entry, { desc = "Next entry" } },
            { "n", "k", actions.prev_entry, { desc = "Previous entry" } },
            { "n", "<up>", actions.prev_entry, { desc = "Previous entry" } },
            { "n", "<cr>", actions.select_entry, { desc = "Open diff" } },
            { "n", "o", actions.select_entry, { desc = "Open diff" } },
            { "n", "l", actions.select_entry, { desc = "Open diff" } },
            { "n", "<2-LeftMouse>", actions.select_entry, { desc = "Open diff" } },
            { "n", "-", actions.toggle_stage_entry, { desc = "Stage/unstage" } },
            { "n", "s", actions.toggle_stage_entry, { desc = "Stage/unstage" } },
            { "n", "S", actions.stage_all, { desc = "Stage all" } },
            { "n", "U", actions.unstage_all, { desc = "Unstage all" } },
            { "n", "X", actions.restore_entry, { desc = "Restore entry" } },
            { "n", "L", actions.open_commit_log, { desc = "Open commit log" } },
            { "n", "zo", actions.open_fold, { desc = "Open fold" } },
            { "n", "h", actions.close_fold, { desc = "Close fold" } },
            { "n", "zc", actions.close_fold, { desc = "Close fold" } },
            { "n", "za", actions.toggle_fold, { desc = "Toggle fold" } },
            { "n", "zR", actions.open_all_folds, { desc = "Open all folds" } },
            { "n", "zM", actions.close_all_folds, { desc = "Close all folds" } },
            { "n", "<c-b>", actions.scroll_view(-0.25), { desc = "Scroll up" } },
            { "n", "<c-f>", actions.scroll_view(0.25), { desc = "Scroll down" } },
            { "n", "<tab>", actions.select_next_entry, { desc = "Next entry" } },
            { "n", "<s-tab>", actions.select_prev_entry, { desc = "Previous entry" } },
            { "n", "gf", actions.goto_file_edit, { desc = "Open file" } },
            { "n", "<C-w><C-f>", actions.goto_file_split, { desc = "Open file (split)" } },
            { "n", "<C-w>gf", actions.goto_file_tab, { desc = "Open file (tab)" } },
            { "n", "i", actions.listing_style, { desc = "Toggle listing style" } },
            { "n", "f", actions.toggle_flatten_dirs, { desc = "Toggle flatten dirs" } },
            { "n", "R", actions.refresh_files, { desc = "Refresh" } },
            { "n", "<leader>e", actions.focus_files, { desc = "Focus file panel" } },
            { "n", "<leader>b", actions.toggle_files, { desc = "Toggle file panel" } },
            { "n", "g<C-x>", actions.cycle_layout, { desc = "Cycle layout" } },
            { "n", "[x", actions.prev_conflict, { desc = "Previous conflict" } },
            { "n", "]x", actions.next_conflict, { desc = "Next conflict" } },
            { "n", "g?", actions.help("file_panel"), { desc = "Help" } },
          },
          file_history_panel = {
            { "n", "g!", actions.options, { desc = "Options" } },
            { "n", "<C-A-d>", actions.open_in_diffview, { desc = "Open in diffview" } },
            { "n", "y", actions.copy_hash, { desc = "Copy commit hash" } },
            { "n", "L", actions.open_commit_log, { desc = "Open commit log" } },
            { "n", "zR", actions.open_all_folds, { desc = "Open all folds" } },
            { "n", "zM", actions.close_all_folds, { desc = "Close all folds" } },
            { "n", "j", actions.next_entry, { desc = "Next entry" } },
            { "n", "<down>", actions.next_entry, { desc = "Next entry" } },
            { "n", "k", actions.prev_entry, { desc = "Previous entry" } },
            { "n", "<up>", actions.prev_entry, { desc = "Previous entry" } },
            { "n", "<cr>", actions.select_entry, { desc = "Open diff" } },
            { "n", "o", actions.select_entry, { desc = "Open diff" } },
            { "n", "l", actions.select_entry, { desc = "Open diff" } },
            { "n", "<2-LeftMouse>", actions.select_entry, { desc = "Open diff" } },
            { "n", "<c-b>", actions.scroll_view(-0.25), { desc = "Scroll up" } },
            { "n", "<c-f>", actions.scroll_view(0.25), { desc = "Scroll down" } },
            { "n", "<tab>", actions.select_next_entry, { desc = "Next entry" } },
            { "n", "<s-tab>", actions.select_prev_entry, { desc = "Previous entry" } },
            { "n", "gf", actions.goto_file_edit, { desc = "Open file" } },
            { "n", "<C-w><C-f>", actions.goto_file_split, { desc = "Open file (split)" } },
            { "n", "<C-w>gf", actions.goto_file_tab, { desc = "Open file (tab)" } },
            { "n", "<leader>e", actions.focus_files, { desc = "Focus file panel" } },
            { "n", "<leader>b", actions.toggle_files, { desc = "Toggle file panel" } },
            { "n", "g<C-x>", actions.cycle_layout, { desc = "Cycle layout" } },
            { "n", "g?", actions.help("file_history_panel"), { desc = "Help" } },
          },
          option_panel = {
            { "n", "<tab>", actions.select_entry, { desc = "Select" } },
            { "n", "q", actions.close, { desc = "Close" } },
            { "n", "g?", actions.help("option_panel"), { desc = "Help" } },
          },
          help_panel = {
            { "n", "q", actions.close, { desc = "Close" } },
            { "n", "<esc>", actions.close, { desc = "Close" } },
          },
        },
      })
    end,

    keys = {
      -- Open diffview
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview: Open" },
      { "<leader>gD", "<cmd>DiffviewOpen HEAD~1<cr>", desc = "Diffview: Last Commit" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Diffview: Close" },

      -- File history
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: File History" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview: Branch History" },

      -- Visual mode - history for selection
      { "<leader>gh", "<cmd>'<,'>DiffviewFileHistory<cr>", mode = "v", desc = "Diffview: Selection History" },

      -- Compare branches
      {
        "<leader>gB",
        function()
          local branch = vim.fn.input("Compare with branch: ", "main")
          if branch ~= "" then
            vim.cmd("DiffviewOpen " .. branch)
          end
        end,
        desc = "Diffview: Compare Branch",
      },

      -- Compare with specific commit
      {
        "<leader>gC",
        function()
          local commit = vim.fn.input("Compare with commit: ")
          if commit ~= "" then
            vim.cmd("DiffviewOpen " .. commit)
          end
        end,
        desc = "Diffview: Compare Commit",
      },

      -- Toggle file panel
      { "<leader>gf", "<cmd>DiffviewToggleFiles<cr>", desc = "Diffview: Toggle Files" },

      -- Refresh
      { "<leader>gR", "<cmd>DiffviewRefresh<cr>", desc = "Diffview: Refresh" },
    },
  },
}
