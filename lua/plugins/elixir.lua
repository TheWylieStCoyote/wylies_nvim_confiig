-- Elixir Development Configuration
-- LSP (elixir-ls), formatting (mix format), and Phoenix/Mix support

-- Skip entire Elixir config if Elixir is not installed
if vim.fn.executable("elixir") ~= 1 then
  return {}
end

return {
  -- TreeSitter parsers for Elixir
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "elixir",
        "heex",
        "eex",
        "erlang",
      })
    end,
  },

  -- Mason: ensure Elixir tools are installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "elixir-ls",
      })
    end,
  },

  -- elixir-ls configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        elixirls = {
          cmd = { "elixir-ls" },
          filetypes = { "elixir", "eelixir", "heex", "surface" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.fn.getcwd()
          end,
          settings = {
            elixirLS = {
              dialyzerEnabled = true,
              dialyzerFormat = "dialyxir_long",
              fetchDeps = false,
              enableTestLenses = true,
              suggestSpecs = true,
            },
          },
        },
      },
    },
  },

  -- Code formatting with mix format
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        elixir = { "mix" },
        heex = { "mix" },
        eelixir = { "mix" },
      },
      formatters = {
        mix = {
          command = "mix",
          args = { "format", "-" },
          stdin = true,
        },
      },
    },
  },

  -- Elixir debugging (elixir-ls has built-in DAP support)
  {
    "mfussenegger/nvim-dap",
    optional = true,
    ft = { "elixir", "eelixir", "heex", "surface" },
    opts = function()
      local dap = require("dap")

      -- elixir-ls DAP adapter
      dap.adapters.mix_task = {
        type = "executable",
        command = "elixir-ls-debugger",
        args = {},
      }

      dap.configurations.elixir = {
        {
          type = "mix_task",
          name = "mix test",
          task = "test",
          taskArgs = { "--trace" },
          request = "launch",
          startApps = true,
          projectDir = "${workspaceFolder}",
          requireFiles = {
            "test/**/test_helper.exs",
            "test/**/*_test.exs",
          },
        },
        {
          type = "mix_task",
          name = "mix test (current file)",
          task = "test",
          taskArgs = { "${file}", "--trace" },
          request = "launch",
          startApps = true,
          projectDir = "${workspaceFolder}",
          requireFiles = {
            "test/**/test_helper.exs",
            "test/**/*_test.exs",
          },
        },
        {
          type = "mix_task",
          name = "phx.server",
          task = "phx.server",
          request = "launch",
          startApps = true,
          projectDir = "${workspaceFolder}",
        },
      }
    end,
  },

  -- Elixir-specific keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "elixir", "eelixir", "heex", "surface" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "Elixir: " .. desc })
          end

          -- Run Elixir
          map("<leader>xr", function()
            vim.cmd("split | terminal elixir " .. vim.fn.expand("%"))
          end, "Run File")

          map("<leader>xc", function()
            vim.cmd("split | terminal iex")
          end, "IEx Console")

          map("<leader>xC", function()
            vim.cmd("split | terminal iex -S mix")
          end, "IEx with Mix")

          -- Mix commands
          map("<leader>xm", function()
            vim.cmd("split | terminal mix compile")
          end, "Mix Compile")

          map("<leader>xM", function()
            vim.cmd("split | terminal mix compile --force")
          end, "Mix Compile (force)")

          map("<leader>xd", function()
            vim.cmd("split | terminal mix deps.get")
          end, "Mix Deps Get")

          map("<leader>xD", function()
            vim.cmd("split | terminal mix deps.update --all")
          end, "Mix Deps Update")

          -- Testing
          map("<leader>xt", function()
            vim.cmd("split | terminal mix test")
          end, "Mix Test (all)")

          map("<leader>xT", function()
            vim.cmd("split | terminal mix test " .. vim.fn.expand("%"))
          end, "Mix Test (file)")

          map("<leader>xl", function()
            vim.cmd("split | terminal mix test " .. vim.fn.expand("%") .. ":" .. vim.fn.line("."))
          end, "Mix Test (line)")

          map("<leader>xF", function()
            vim.cmd("split | terminal mix test --failed")
          end, "Mix Test (failed)")

          map("<leader>xw", function()
            vim.cmd("split | terminal mix test --stale")
          end, "Mix Test (stale)")

          -- Phoenix commands
          map("<leader>xp", function()
            vim.cmd("split | terminal mix phx.server")
          end, "Phoenix Server")

          map("<leader>xP", function()
            vim.cmd("split | terminal iex -S mix phx.server")
          end, "Phoenix Server (IEx)")

          map("<leader>xR", function()
            vim.cmd("split | terminal mix phx.routes")
          end, "Phoenix Routes")

          map("<leader>xg", function()
            local type = vim.fn.input("Generate (schema/context/live/controller/etc.): ")
            local args = vim.fn.input("Arguments: ")
            if type ~= "" then
              vim.cmd("split | terminal mix phx.gen." .. type .. " " .. args)
            end
          end, "Phoenix Generate")

          -- Database
          map("<leader>xe", function()
            vim.cmd("split | terminal mix ecto.migrate")
          end, "Ecto Migrate")

          map("<leader>xE", function()
            vim.cmd("split | terminal mix ecto.rollback")
          end, "Ecto Rollback")

          map("<leader>xs", function()
            vim.cmd("split | terminal mix ecto.reset")
          end, "Ecto Reset")

          map("<leader>xS", function()
            vim.cmd("split | terminal mix ecto.setup")
          end, "Ecto Setup")

          -- Format
          map("<leader>xf", function()
            vim.cmd("split | terminal mix format")
          end, "Mix Format (all)")

          -- Credo
          map("<leader>xo", function()
            vim.cmd("split | terminal mix credo")
          end, "Credo")

          map("<leader>xO", function()
            vim.cmd("split | terminal mix credo --strict")
          end, "Credo (strict)")

          -- Dialyzer
          map("<leader>xy", function()
            vim.cmd("split | terminal mix dialyzer")
          end, "Dialyzer")

          -- New project
          map("<leader>xn", function()
            local name = vim.fn.input("Project name: ")
            local opts_str = vim.fn.input("Options (--sup, --umbrella, etc.): ")
            if name ~= "" then
              vim.cmd("split | terminal mix new " .. name .. " " .. opts_str)
            end
          end, "Mix New")

          -- New Phoenix project
          map("<leader>xN", function()
            local name = vim.fn.input("Phoenix project name: ")
            local opts_str = vim.fn.input("Options (--live, --no-ecto, etc.): ")
            if name ~= "" then
              vim.cmd("split | terminal mix phx.new " .. name .. " " .. opts_str)
            end
          end, "Phoenix New")
        end,
      })
    end,
  },
}
