-- Bash/Shell Script Development Configuration
-- LSP (bashls), linting (shellcheck), formatting (shfmt), and debugging

return {
  -- TreeSitter parsers for shell scripts
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "bash",
      })
    end,
  },

  -- Mason: ensure Bash tools are installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "bash-language-server",
        "shellcheck",
        "shfmt",
        "bash-debug-adapter",
      })
    end,
  },

  -- bashls LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {
          filetypes = { "sh", "bash", "zsh" },
          settings = {
            bashIde = {
              globPattern = "*@(.sh|.inc|.bash|.command)",
              includeAllWorkspaceSymbols = true,
              shellcheckPath = "shellcheck",
              shellcheckArguments = {},
            },
          },
        },
      },
    },
  },

  -- Code formatting with shfmt
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-ci", "-bn" },
          -- -i 2: indent with 2 spaces
          -- -ci: indent switch cases
          -- -bn: binary ops may start a line
        },
      },
    },
  },

  -- Linting with shellcheck
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        sh = { "shellcheck" },
        bash = { "shellcheck" },
      },
    },
  },

  -- Bash debugging with bash-debug-adapter
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")

      -- bash-debug-adapter configuration
      dap.adapters.bashdb = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
        name = "bashdb",
      }

      dap.configurations.sh = {
        {
          type = "bashdb",
          request = "launch",
          name = "Launch file",
          showDebugOutput = true,
          pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
          pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
          trace = true,
          file = "${file}",
          program = "${file}",
          cwd = "${workspaceFolder}",
          pathCat = "cat",
          pathBash = "/bin/bash",
          pathMkfifo = "mkfifo",
          pathPkill = "pkill",
          args = {},
          env = {},
          terminalKind = "integrated",
        },
        {
          type = "bashdb",
          request = "launch",
          name = "Launch with arguments",
          showDebugOutput = true,
          pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
          pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
          trace = true,
          file = "${file}",
          program = "${file}",
          cwd = "${workspaceFolder}",
          pathCat = "cat",
          pathBash = "/bin/bash",
          pathMkfifo = "mkfifo",
          pathPkill = "pkill",
          args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " ")
          end,
          env = {},
          terminalKind = "integrated",
        },
      }

      -- Use same config for bash filetype
      dap.configurations.bash = dap.configurations.sh
    end,
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Start/Continue" },
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
      { "<S-F11>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
    },
  },

  -- Bash-specific keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sh", "bash", "zsh" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "Bash: " .. desc })
          end

          -- Run current script
          map("<leader>br", function()
            vim.cmd("split | terminal bash " .. vim.fn.expand("%"))
          end, "Run Script")

          -- Make executable and run
          map("<leader>bx", function()
            local file = vim.fn.expand("%")
            vim.cmd("!chmod +x " .. file)
            vim.cmd("split | terminal ./" .. file)
          end, "Make Executable & Run")

          -- Run with bash -x (debug mode)
          map("<leader>bX", function()
            vim.cmd("split | terminal bash -x " .. vim.fn.expand("%"))
          end, "Run with Trace")

          -- Check syntax with bash -n
          map("<leader>bn", function()
            local file = vim.fn.expand("%")
            local result = vim.fn.system("bash -n " .. file .. " 2>&1")
            if result == "" then
              vim.notify("Syntax OK: " .. file, vim.log.levels.INFO)
            else
              vim.notify(result, vim.log.levels.ERROR)
            end
          end, "Check Syntax")

          -- Run shellcheck manually
          map("<leader>bc", function()
            vim.cmd("split | terminal shellcheck " .. vim.fn.expand("%"))
          end, "Shellcheck")

          -- Source script (for functions/aliases)
          map("<leader>bs", function()
            local file = vim.fn.expand("%:p")
            vim.cmd("!source " .. file)
            vim.notify("Sourced: " .. file, vim.log.levels.INFO)
          end, "Source Script")

          -- Insert shebang
          map("<leader>bi", function()
            local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
            if not first_line:match("^#!") then
              vim.api.nvim_buf_set_lines(0, 0, 0, false, { "#!/usr/bin/env bash", "" })
              vim.notify("Added shebang", vim.log.levels.INFO)
            else
              vim.notify("Shebang already exists", vim.log.levels.WARN)
            end
          end, "Insert Shebang")

          -- Set executable permission
          map("<leader>be", function()
            local file = vim.fn.expand("%")
            vim.cmd("!chmod +x " .. file)
            vim.notify("Made executable: " .. file, vim.log.levels.INFO)
          end, "Make Executable")
        end,
      })
    end,
  },
}
