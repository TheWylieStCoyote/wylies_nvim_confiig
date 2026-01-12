-- Neogit Configuration
-- Magit-like git interface for Neovim

return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    opts = {
      disable_hint = false,
      disable_context_highlighting = false,
      disable_signs = false,
      graph_style = "ascii",
      git_services = {
        ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
        ["gitlab.com"] = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
      },
      remember_settings = true,
      use_per_project_settings = true,
      ignored_settings = {},
      integrations = {
        diffview = true,
        telescope = true,
      },
      sections = {
        untracked = {
          folded = false,
          hidden = false,
        },
        unstaged = {
          folded = false,
          hidden = false,
        },
        staged = {
          folded = false,
          hidden = false,
        },
        stashes = {
          folded = true,
          hidden = false,
        },
        unpulled_upstream = {
          folded = true,
          hidden = false,
        },
        unmerged_upstream = {
          folded = false,
          hidden = false,
        },
        unpulled_pushRemote = {
          folded = true,
          hidden = false,
        },
        unmerged_pushRemote = {
          folded = false,
          hidden = false,
        },
        recent = {
          folded = true,
          hidden = false,
        },
        rebase = {
          folded = true,
          hidden = false,
        },
      },
      status = {
        recent_commit_count = 10,
      },
      commit_editor = {
        kind = "auto",
      },
      commit_select_view = {
        kind = "tab",
      },
      commit_view = {
        kind = "vsplit",
      },
      log_view = {
        kind = "tab",
      },
      rebase_editor = {
        kind = "auto",
      },
      reflog_view = {
        kind = "tab",
      },
      merge_editor = {
        kind = "auto",
      },
      preview_buffer = {
        kind = "split",
      },
      popup = {
        kind = "split",
      },
      signs = {
        hunk = { "", "" },
        item = { ">", "v" },
        section = { ">", "v" },
      },
      mappings = {
        status = {
          ["q"] = "Close",
          ["<esc>"] = "Close",
          ["<tab>"] = "Toggle",
          ["1"] = "Depth1",
          ["2"] = "Depth2",
          ["3"] = "Depth3",
          ["4"] = "Depth4",
        },
      },
    },
    keys = {
      { "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit" },
      { "<leader>gN", "<cmd>Neogit kind=split<cr>", desc = "Neogit (split)" },
      { "<leader>gl", "<cmd>Neogit log<cr>", desc = "Neogit Log" },
      { "<leader>gp", "<cmd>Neogit push<cr>", desc = "Neogit Push" },
      { "<leader>gP", "<cmd>Neogit pull<cr>", desc = "Neogit Pull" },
      { "<leader>gnc", "<cmd>Neogit commit<cr>", desc = "Neogit Commit" },
      { "<leader>gnb", "<cmd>Neogit branch<cr>", desc = "Neogit Branch" },
    },
  },
}
