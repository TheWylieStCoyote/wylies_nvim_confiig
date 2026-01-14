-- Ruby Development Configuration
-- LSP (ruby_lsp), linting/formatting (rubocop), and Rails/RSpec support

-- Skip entire Ruby config if Ruby is not installed
if vim.fn.executable("ruby") ~= 1 then
  return {}
end

return {
  -- TreeSitter parsers for Ruby
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "ruby",
      })
    end,
  },

  -- Mason: ensure Ruby tools are installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "ruby-lsp",
        "rubocop",
      })
    end,
  },

  -- ruby_lsp configuration (Shopify's Ruby LSP)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          cmd = { "ruby-lsp" },
          filetypes = { "ruby", "eruby" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.root_pattern("Gemfile", ".git", ".ruby-version", "Rakefile")(fname)
          end,
          init_options = {
            formatter = "auto",
            linters = { "rubocop" },
          },
          settings = {
            rubyLsp = {
              enabledFeatures = {
                codeActions = true,
                codeLens = true,
                completion = true,
                definition = true,
                diagnostics = true,
                documentHighlights = true,
                documentLink = true,
                documentSymbols = true,
                foldingRanges = true,
                formatting = true,
                hover = true,
                inlayHint = true,
                onTypeFormatting = true,
                references = true,
                rename = true,
                selectionRanges = true,
                semanticHighlighting = true,
                signatureHelp = true,
                typeHierarchy = true,
                workspaceSymbol = true,
              },
            },
          },
        },
      },
    },
  },

  -- Code formatting with RuboCop
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ruby = { "rubocop" },
        eruby = { "erb_format" },
      },
      formatters = {
        rubocop = {
          command = "rubocop",
          args = {
            "--auto-correct-all",
            "--stderr",
            "--force-exclusion",
            "--stdin",
            "$FILENAME",
          },
          stdin = true,
        },
      },
    },
  },

  -- Linting with RuboCop
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        ruby = { "rubocop" },
      },
    },
  },

  -- Ruby debugging with rdbg (debug gem)
  {
    "mfussenegger/nvim-dap",
    optional = true,
    ft = { "ruby", "eruby" },
    opts = function()
      local dap = require("dap")

      -- Ruby debug adapter (using debug gem's rdbg)
      dap.adapters.ruby = function(callback, config)
        callback({
          type = "server",
          host = "127.0.0.1",
          port = "${port}",
          executable = {
            command = "rdbg",
            args = {
              "-n",
              "--open",
              "--port",
              "${port}",
              "-c",
              "--",
              "ruby",
              config.program,
            },
          },
        })
      end

      dap.configurations.ruby = {
        {
          type = "ruby",
          name = "Debug current file",
          request = "launch",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "ruby",
          name = "Debug RSpec (current file)",
          request = "launch",
          program = "rspec",
          args = { "${file}" },
          cwd = "${workspaceFolder}",
        },
        {
          type = "ruby",
          name = "Attach to process",
          request = "attach",
          remoteHost = "127.0.0.1",
          remotePort = 1234,
          localfs = true,
        },
      }
    end,
  },

  -- Ruby-specific keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "ruby", "eruby" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "Ruby: " .. desc })
          end

          -- Run Ruby
          map("<leader>Rr", function()
            vim.cmd("split | terminal ruby " .. vim.fn.expand("%"))
          end, "Run File")

          map("<leader>Ri", function()
            vim.cmd("split | terminal irb")
          end, "IRB Console")

          -- RSpec
          map("<leader>Rt", function()
            vim.cmd("split | terminal bundle exec rspec")
          end, "RSpec (all)")

          map("<leader>RT", function()
            vim.cmd("split | terminal bundle exec rspec " .. vim.fn.expand("%"))
          end, "RSpec (file)")

          map("<leader>Rl", function()
            vim.cmd("split | terminal bundle exec rspec " .. vim.fn.expand("%") .. ":" .. vim.fn.line("."))
          end, "RSpec (line)")

          map("<leader>RF", function()
            vim.cmd("split | terminal bundle exec rspec --only-failures")
          end, "RSpec (failures)")

          -- Bundler
          map("<leader>Rb", function()
            vim.cmd("split | terminal bundle install")
          end, "Bundle Install")

          map("<leader>RB", function()
            vim.cmd("split | terminal bundle update")
          end, "Bundle Update")

          map("<leader>Re", function()
            vim.cmd("split | terminal bundle exec " .. vim.fn.input("Command: "))
          end, "Bundle Exec")

          -- Rails commands (if Rails project)
          map("<leader>Rc", function()
            vim.cmd("split | terminal bundle exec rails console")
          end, "Rails Console")

          map("<leader>Rs", function()
            vim.cmd("split | terminal bundle exec rails server")
          end, "Rails Server")

          map("<leader>Rm", function()
            vim.cmd("split | terminal bundle exec rails db:migrate")
          end, "Rails Migrate")

          map("<leader>RM", function()
            vim.cmd("split | terminal bundle exec rails db:migrate:status")
          end, "Rails Migrate Status")

          map("<leader>Rd", function()
            vim.cmd("split | terminal bundle exec rails db:seed")
          end, "Rails Seed")

          map("<leader>Rg", function()
            local type = vim.fn.input("Generate (model/controller/migration/etc.): ")
            local name = vim.fn.input("Name: ")
            if type ~= "" and name ~= "" then
              vim.cmd("split | terminal bundle exec rails generate " .. type .. " " .. name)
            end
          end, "Rails Generate")

          map("<leader>RR", function()
            vim.cmd("split | terminal bundle exec rails routes")
          end, "Rails Routes")

          -- Rake
          map("<leader>Rk", function()
            local task = vim.fn.input("Rake task: ", "", "file")
            if task ~= "" then
              vim.cmd("split | terminal bundle exec rake " .. task)
            end
          end, "Rake Task")

          -- RuboCop
          map("<leader>Ro", function()
            vim.cmd("split | terminal bundle exec rubocop " .. vim.fn.expand("%"))
          end, "RuboCop (file)")

          map("<leader>RO", function()
            vim.cmd("split | terminal bundle exec rubocop --auto-correct " .. vim.fn.expand("%"))
          end, "RuboCop Auto-correct")
        end,
      })
    end,
  },
}
