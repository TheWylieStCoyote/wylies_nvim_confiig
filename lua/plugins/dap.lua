-- Centralized DAP (Debug Adapter Protocol) Configuration
-- This file ensures nvim-dap only loads when needed for debugging
-- DAP is loaded by language-specific configs via their `ft` triggers

return {
  -- Core nvim-dap - lazy loaded by language configs
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    -- Session control. Function keys mirror the VS Code layout that java.lua
    -- already uses buffer-locally; the <leader>d variants are for keyboards
    -- without easy F-keys. Breakpoint keys live on persistent-breakpoints below.
    keys = {
      -- stylua: ignore start
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Continue/Start" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
      { "<S-F11>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
      { "<leader>dC", function() require("dap").continue() end, desc = "Continue/Start" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dR", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      -- stylua: ignore end
    },
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
    keys = {
      -- stylua: ignore start
      { "<leader>du", function() require("dapui").toggle({}) end, desc = "Toggle Debug UI" },
      { "<leader>de", function() require("dapui").eval() end, mode = { "n", "v" }, desc = "Eval Expression" },
      -- stylua: ignore end
    },
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
