-- Python Development Configuration
-- LSP (pyright + ruff), debugging, formatting, and venv support

return {
  -- TreeSitter parsers for Python
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "python",
        "toml",
        "requirements",
      })
    end,
  },

  -- Mason: ensure Python tools are installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "pyright",
        "ruff",
        "debugpy",
      })
    end,
  },

  -- pyright LSP configuration (type checking + IntelliSense)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            pyright = {
              disableOrganizeImports = true, -- Using ruff for this
            },
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "basic",
              },
            },
          },
        },
        ruff = {
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = {
            settings = {
              logLevel = "error",
            },
          },
          keys = {
            {
              "<leader>po",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.organizeImports" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Organize Imports (ruff)",
            },
          },
        },
      },
    },
  },

  -- Code formatting with ruff
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = {
          "ruff_format",
          "ruff_organize_imports",
        },
      },
    },
  },

  -- Virtual environment selector
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    ft = "python",  -- Only load for Python files
    opts = {
      options = {
        notify_user_on_venv_activation = true,
      },
    },
    keys = {
      { "<leader>pv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
      { "<leader>pV", "<cmd>VenvSelectCached<cr>", desc = "Select Cached VirtualEnv" },
    },
  },

  -- Python debugging with debugpy (extends centralized DAP)
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    keys = {
      { "<leader>pd", function() require("dap-python").debug_selection() end, desc = "Debug Selection", mode = "v", ft = "python" },
      { "<leader>pt", function() require("dap-python").test_method() end, desc = "Debug Test Method", ft = "python" },
      { "<leader>pT", function() require("dap-python").test_class() end, desc = "Debug Test Class", ft = "python" },
    },
    config = function()
      local debugpy_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(debugpy_path)
      require("dap-python").test_runner = "pytest"
    end,
  },

  -- Python-specific keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Set up Python-specific keymaps when entering Python files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "Python: " .. desc })
          end

          map("<leader>pr", function()
            vim.cmd("split | terminal python " .. vim.fn.expand("%"))
          end, "Run File")

          map("<leader>pi", function()
            vim.cmd("split | terminal python -i " .. vim.fn.expand("%"))
          end, "Run Interactive")

          map("<leader>pp", function()
            vim.cmd("split | terminal python")
          end, "Python REPL")
        end,
      })
    end,
  },
}
