-- Centralized DAP (Debug Adapter Protocol) Configuration
-- This file ensures nvim-dap only loads when needed for debugging
-- DAP is loaded by language-specific configs via their `ft` triggers

return {
  -- Core nvim-dap - lazy loaded by language configs
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    config = function()
      -- Set up icons
      local icons = {
        Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
        Breakpoint = " ",
        BreakpointCondition = " ",
        BreakpointRejected = { " ", "DiagnosticError" },
        LogPoint = ".>",
      }
      for name, sign in pairs(icons) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define("Dap" .. name, {
          text = sign[1],
          texthl = sign[2] or "DiagnosticInfo",
          linehl = sign[3],
          numhl = sign[3],
        })
      end
    end,
  },

  -- DAP UI - lazy loaded, only when nvim-dap is used
  {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    opts = {},
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },

  -- Virtual text for debugging - lazy loaded
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = true,
    dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
    opts = {
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      all_references = false,
      virt_text_pos = "eol",
      all_frames = false,
      virt_lines = false,
      virt_text_win_col = nil,
    },
  },

  -- nvim-nio (required by dap-ui) - lazy loaded
  {
    "nvim-neotest/nvim-nio",
    lazy = true,
  },

  -- Persistent breakpoints - save breakpoints across sessions
  {
    "Weissle/persistent-breakpoints.nvim",
    event = "BufReadPost",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {
      save_dir = vim.fn.stdpath("data") .. "/breakpoints",
      load_breakpoints_event = { "BufReadPost" },
      perf_record = false,
    },
    keys = {
      {
        "<leader>db",
        function()
          require("persistent-breakpoints.api").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dB",
        function()
          require("persistent-breakpoints.api").set_conditional_breakpoint()
        end,
        desc = "Conditional Breakpoint",
      },
      {
        "<leader>dL",
        function()
          require("persistent-breakpoints.api").set_log_point()
        end,
        desc = "Log Point",
      },
      {
        "<leader>dc",
        function()
          require("persistent-breakpoints.api").clear_all_breakpoints()
        end,
        desc = "Clear All Breakpoints",
      },
      {
        "<F9>",
        function()
          require("persistent-breakpoints.api").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
    },
  },
}
