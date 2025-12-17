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
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {},
  },

  -- nvim-nio (required by dap-ui) - lazy loaded
  {
    "nvim-neotest/nvim-nio",
    lazy = true,
  },
}
