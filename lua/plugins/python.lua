-- Python Development Configuration
-- LSP (pyright + ruff), debugging, formatting, and venv support

-- Skip entire Python config if Python is not installed
if vim.fn.executable("python3") ~= 1 and vim.fn.executable("python") ~= 1 then
  return {}
end

return {
  -- TreeSitter parsers for Python
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "python",
        "toml",
        "requirements",
        "rst", -- reStructuredText for docstrings
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

  -- pyright + ruff LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          -- Supports both pyrightconfig.json and .pyrightconfig.json (hidden)
          on_new_config = function(config, root_dir)
            local hidden = root_dir .. "/.pyrightconfig.json"
            if vim.fn.filereadable(hidden) == 1 then
              local ok, data = pcall(function()
                return vim.json.decode(table.concat(vim.fn.readfile(hidden), "\n"))
              end)
              if ok and type(data) == "table" then
                local s = config.settings or {}
                local py = s.python or {}
                local analysis = py.analysis or {}
                if data.extraPaths then
                  analysis.extraPaths = data.extraPaths
                end
                if data.pythonPath then
                  py.pythonPath = data.pythonPath
                end
                if data.venvPath then
                  py.venvPath = data.venvPath
                end
                if data.venv then
                  py.venv = data.venv
                end
                if data.pythonVersion then
                  py.pythonVersion = data.pythonVersion
                end
                py.analysis = analysis
                s.python = py
                config.settings = s
              end
            end
          end,
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
        },
      },
    },
  },

  -- Python-specific keymaps (merged into single autocmd)
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "Python: " .. desc })
          end

          -- Import management (via ruff)
          map("<leader>po", function()
            vim.lsp.buf.code_action({
              apply = true,
              context = { only = { "source.organizeImports" }, diagnostics = {} },
            })
          end, "Organize Imports")

          -- Ruff fixes
          map("<leader>pf", function()
            vim.lsp.buf.code_action({
              apply = true,
              context = { only = { "source.fixAll.ruff" }, diagnostics = {} },
            })
          end, "Ruff Fix All")

          -- Type checking
          map("<leader>pc", "<cmd>split | terminal pyright .<cr>", "Type Check (pyright)")
          map("<leader>pC", "<cmd>split | terminal mypy .<cr>", "Type Check (mypy)")

          -- Run file
          map("<leader>pr", function()
            vim.cmd("split | terminal python " .. vim.fn.expand("%"))
          end, "Run File")

          map("<leader>pR", function()
            vim.ui.input({ prompt = "Arguments: " }, function(args)
              if args then
                vim.cmd("split | terminal python " .. vim.fn.expand("%") .. " " .. args)
              end
            end)
          end, "Run with Arguments")

          map("<leader>pm", function()
            vim.ui.input({ prompt = "Module: ", default = vim.fn.expand("%:r"):gsub("/", ".") }, function(module)
              if module then
                vim.cmd("split | terminal python -m " .. module)
              end
            end)
          end, "Run as Module")

          -- Interactive/REPL
          map("<leader>pi", function()
            vim.cmd("split | terminal python -i " .. vim.fn.expand("%"))
          end, "Run Interactive")

          map("<leader>pp", "<cmd>split | terminal python<cr>", "Python REPL")
          map("<leader>pI", "<cmd>split | terminal ipython<cr>", "IPython REPL")

          -- Testing (direct pytest without debugger)
          map("<leader>ptt", "<cmd>split | terminal pytest<cr>", "Run All Tests")
          map("<leader>ptf", function()
            vim.cmd("split | terminal pytest " .. vim.fn.expand("%"))
          end, "Test Current File")
          map("<leader>ptv", "<cmd>split | terminal pytest -v<cr>", "Run Tests (verbose)")
          map("<leader>ptl", "<cmd>split | terminal pytest --lf<cr>", "Run Last Failed")
          map("<leader>ptw", "<cmd>split | terminal pytest-watch<cr>", "Watch Tests")

          -- Package management
          map("<leader>pii", "<cmd>split | terminal pip install<cr>", "pip install")
          map("<leader>pir", "<cmd>split | terminal pip install -r requirements.txt<cr>", "pip install requirements")
          map("<leader>pie", "<cmd>split | terminal pip install -e .<cr>", "pip install editable")
          map("<leader>piu", function()
            vim.ui.input({ prompt = "Package: " }, function(pkg)
              if pkg then
                vim.cmd("split | terminal pip install " .. pkg)
              end
            end)
          end, "pip install package")

          -- uv (fast Python package manager)
          map("<leader>puv", "<cmd>split | terminal uv pip install<cr>", "uv pip install")
          map("<leader>pur", "<cmd>split | terminal uv pip install -r requirements.txt<cr>", "uv install requirements")
          map("<leader>pus", "<cmd>split | terminal uv pip sync requirements.txt<cr>", "uv pip sync")

          -- Poetry
          map("<leader>poa", "<cmd>split | terminal poetry add<cr>", "poetry add")
          map("<leader>poi", "<cmd>split | terminal poetry install<cr>", "poetry install")
          map("<leader>por", "<cmd>split | terminal poetry run python %<cr>", "poetry run")
        end,
      })
    end,
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
    ft = "python",
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

  -- Python debugging with debugpy
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    keys = {
      {
        "<leader>pd",
        function()
          require("dap-python").debug_selection()
        end,
        desc = "Debug Selection",
        mode = "v",
        ft = "python",
      },
      {
        "<leader>pdt",
        function()
          require("dap-python").test_method()
        end,
        desc = "Debug Test Method",
        ft = "python",
      },
      {
        "<leader>pdT",
        function()
          require("dap-python").test_class()
        end,
        desc = "Debug Test Class",
        ft = "python",
      },
    },
    config = function()
      -- Try Mason's debugpy first, fall back to system python
      local mason_debugpy = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      local debugpy_path
      if vim.fn.executable(mason_debugpy) == 1 then
        debugpy_path = mason_debugpy
      elseif vim.fn.executable("python3") == 1 then
        debugpy_path = "python3"
      elseif vim.fn.executable("python") == 1 then
        debugpy_path = "python"
      else
        vim.notify("No Python interpreter found for debugpy", vim.log.levels.WARN)
        return
      end
      require("dap-python").setup(debugpy_path)
      require("dap-python").test_runner = "pytest"

      -- Add Django and Flask debug configurations
      local dap = require("dap")

      table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "Django: runserver",
        program = "${workspaceFolder}/manage.py",
        args = { "runserver", "--noreload" },
        django = true,
        justMyCode = false,
      })

      table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "Flask: Run App",
        module = "flask",
        args = { "run", "--no-debugger", "--no-reload" },
        env = {
          FLASK_APP = "${workspaceFolder}/app.py",
          FLASK_ENV = "development",
        },
        jinja = true,
        justMyCode = false,
      })

      table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "FastAPI: uvicorn",
        module = "uvicorn",
        args = { "main:app", "--reload" },
        jinja = true,
        justMyCode = false,
      })

      table.insert(dap.configurations.python, {
        type = "python",
        request = "attach",
        name = "Attach to Remote",
        connect = {
          host = "localhost",
          port = 5678,
        },
        pathMappings = {
          {
            localRoot = "${workspaceFolder}",
            remoteRoot = ".",
          },
        },
        justMyCode = false,
      })
    end,
  },
}
