-- YAML/JSON Development Configuration
-- LSP (yaml-language-server, jsonls), schema validation, and formatting

return {
  -- TreeSitter parsers for YAML/JSON
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "yaml",
        "json",
        "json5",
        "jsonc",
        "toml",
      })
      -- jsonl has no dedicated parser; reuse json
      vim.treesitter.language.register("json", "jsonl")
    end,
  },

  -- Mason: ensure tools are installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "yaml-language-server",
        "json-lsp",
        "prettier",
        "yamllint",
        "jsonlint",
        "taplo",
      })
    end,
  },

  -- yaml-language-server configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          cmd = { "yaml-language-server", "--stdio" },
          filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.root_pattern(".git")(fname) or vim.fn.getcwd()
          end,
          settings = {
            yaml = {
              schemaStore = {
                enable = true,
                url = "https://www.schemastore.org/api/json/catalog.json",
              },
              schemas = {
                -- Auto-detect common schemas
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://json.schemastore.org/github-action.json"] = "/action.{yml,yaml}",
                ["https://json.schemastore.org/ansible-stable-2.9.json"] = "/roles/*/tasks/*.{yml,yaml}",
                ["https://json.schemastore.org/prettierrc.json"] = "/.prettierrc.{yml,yaml}",
                ["https://json.schemastore.org/kustomization.json"] = "/kustomization.{yml,yaml}",
                ["https://json.schemastore.org/chart.json"] = "/Chart.{yml,yaml}",
                ["https://json.schemastore.org/circleciconfig.json"] = "/.circleci/config.{yml,yaml}",
                ["https://json.schemastore.org/gitlab-ci.json"] = "/.gitlab-ci.{yml,yaml}",
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/docker-compose*.{yml,yaml}",
                ["https://json.schemastore.org/pre-commit-config.json"] = "/.pre-commit-config.{yml,yaml}",
                ["https://json.schemastore.org/dependabot-2.0.json"] = "/.github/dependabot.{yml,yaml}",
                ["https://json.schemastore.org/traefik-v2.json"] = "/traefik.{yml,yaml}",
                ["https://raw.githubusercontent.com/kubernetes/kubernetes/master/api/openapi-spec/swagger.json"] = "/*.k8s.{yml,yaml}",
              },
              validate = true,
              completion = true,
              hover = true,
              format = {
                enable = true,
                singleQuote = false,
                bracketSpacing = true,
              },
              customTags = {
                "!include scalar",
                "!reference sequence",
                "!Ref scalar",
                "!Sub scalar",
                "!GetAtt scalar",
                "!ImportValue scalar",
              },
            },
          },
        },

        -- JSON language server
        jsonls = {
          cmd = { "vscode-json-language-server", "--stdio" },
          filetypes = { "json", "jsonc" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.root_pattern(".git")(fname) or vim.fn.getcwd()
          end,
          init_options = {
            provideFormatter = true,
          },
          -- Use before_init to defer schemastore loading
          before_init = function(_, config)
            local ok, schemastore = pcall(require, "schemastore")
            if ok then
              config.settings = {
                json = {
                  schemas = schemastore.json.schemas(),
                  validate = { enable = true },
                  format = { enable = true },
                },
              }
            else
              config.settings = {
                json = {
                  validate = { enable = true },
                  format = { enable = true },
                },
              }
            end
          end,
        },

        -- TOML language server (taplo)
        taplo = {
          cmd = { "taplo", "lsp", "stdio" },
          filetypes = { "toml" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.root_pattern("*.toml", ".git")(fname) or vim.fn.getcwd()
          end,
          settings = {
            taplo = {
              formatter = {
                alignEntries = false,
                arrayTrailingComma = true,
                arrayAutoExpand = true,
                inlineTableExpand = true,
                compactArrays = true,
              },
            },
          },
        },
      },
    },
  },

  -- SchemaStore for JSON schemas
  {
    "b0o/schemastore.nvim",
    lazy = true, -- Loaded by jsonls when needed
  },

  -- Code formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        jq_lines = {
          command = "jq",
          args = { "." },
          stdin = true,
        },
      },
      formatters_by_ft = {
        yaml = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        json5 = { "prettier" },
        jsonl = { "jq_lines" },
        toml = { "taplo" },
      },
    },
  },

  -- Linting
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        yaml = { "yamllint" },
        json = { "jsonlint" },
      },
    },
  },

  -- YAML/JSON-specific keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- YAML keybindings
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "YAML: " .. desc })
          end

          -- Validation
          map("<leader>yv", function()
            vim.diagnostic.setloclist()
          end, "Show Diagnostics")

          map("<leader>yl", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal yamllint " .. file)
          end, "Lint (yamllint)")

          -- Schema selection
          map("<leader>ys", function()
            vim.ui.input({ prompt = "Schema URL: " }, function(schema)
              if schema then
                vim.lsp.buf_notify(0, "yaml/setSchema", { uri = schema })
                vim.notify("Schema set: " .. schema, vim.log.levels.INFO)
              end
            end)
          end, "Set Schema")

          -- Convert
          map("<leader>yj", function()
            local file = vim.fn.expand("%")
            local out = vim.fn.expand("%:r") .. ".json"
            vim.cmd("split | terminal yq '.' " .. file .. " > " .. out)
          end, "Convert to JSON (yq)")

          -- Docker Compose
          map("<leader>ydc", function()
            vim.cmd("split | terminal docker-compose config")
          end, "Docker Compose Config")

          map("<leader>ydu", function()
            vim.cmd("split | terminal docker-compose up -d")
          end, "Docker Compose Up")

          map("<leader>ydd", function()
            vim.cmd("split | terminal docker-compose down")
          end, "Docker Compose Down")

          -- Kubernetes
          map("<leader>yka", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal kubectl apply -f " .. file)
          end, "kubectl Apply")

          map("<leader>ykd", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal kubectl delete -f " .. file)
          end, "kubectl Delete")

          map("<leader>ykv", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal kubectl apply --dry-run=client -f " .. file)
          end, "kubectl Validate")

          -- Format
          map("<leader>yf", function()
            vim.lsp.buf.format()
          end, "Format")

          -- Folding
          map("<leader>yz", function()
            vim.cmd("set foldmethod=indent")
            vim.cmd("normal! zM")
          end, "Fold All")

          map("<leader>yZ", function()
            vim.cmd("normal! zR")
          end, "Unfold All")

          -- Code actions
          map("<leader>ya", function()
            vim.lsp.buf.code_action()
          end, "Code Actions")

          map("<leader>yh", function()
            vim.lsp.buf.hover()
          end, "Hover Info")
        end,
      })

      -- JSON keybindings (all JSON types)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "json", "jsonc", "json5" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "JSON: " .. desc })
          end

          -- Validation
          map("<leader>jv", function()
            vim.diagnostic.setloclist()
          end, "Show Diagnostics")

          map("<leader>jl", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal jsonlint " .. file)
          end, "Lint (jsonlint)")

          -- Format
          map("<leader>jf", function()
            vim.lsp.buf.format()
          end, "Format (pretty)")

          -- Code actions
          map("<leader>ja", function()
            vim.lsp.buf.code_action()
          end, "Code Actions")

          map("<leader>jh", function()
            vim.lsp.buf.hover()
          end, "Hover Info")
        end,
      })

      -- jq keybindings (plain JSON only — jq does not support comments)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "json", "json5" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "JSON: " .. desc })
          end

          -- Minify/Format via jq
          map("<leader>jm", function()
            vim.cmd("%!jq -c .")
          end, "Minify (jq)")

          map("<leader>jF", function()
            vim.cmd("%!jq '.'")
          end, "Format (jq)")

          -- jq queries
          map("<leader>jq", function()
            local query = vim.fn.input("jq query: ", ".")
            if query ~= "" then
              vim.cmd("%!jq '" .. query .. "'")
            end
          end, "jq Query")

          map("<leader>jQ", function()
            local query = vim.fn.input("jq query: ", ".")
            local file = vim.fn.expand("%")
            if query ~= "" then
              vim.cmd("split | terminal jq '" .. query .. "' " .. file)
            end
          end, "jq Query (preview)")

          -- Convert
          map("<leader>jy", function()
            local file = vim.fn.expand("%")
            local out = vim.fn.expand("%:r") .. ".yaml"
            vim.cmd("split | terminal yq -y '.' " .. file .. " > " .. out)
          end, "Convert to YAML (yq)")

          map("<leader>jt", function()
            local file = vim.fn.expand("%")
            local out = vim.fn.expand("%:r") .. ".toml"
            vim.cmd(
              "split | terminal python3 -c \"import json,toml,sys; print(toml.dumps(json.load(open('"
                .. file
                .. "'))))\" > "
                .. out
            )
          end, "Convert to TOML (python)")

          -- Extract paths
          map("<leader>jp", function()
            vim.cmd("split | terminal jq 'paths | join(\".\")'")
          end, "List All Paths")

          map("<leader>jk", function()
            vim.cmd("split | terminal jq 'keys'")
          end, "List Keys")

          -- Sort keys
          map("<leader>js", function()
            vim.cmd("%!jq -S '.'")
          end, "Sort Keys")
        end,
      })

      -- TOML keybindings
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "toml" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "TOML: " .. desc })
          end

          -- Format
          map("<leader>tf", function()
            vim.lsp.buf.format()
          end, "Format")

          map("<leader>tF", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal taplo format " .. file)
            vim.cmd("e!")
          end, "Format (taplo)")

          -- Validate
          map("<leader>tv", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal taplo lint " .. file)
          end, "Validate (taplo)")

          -- Convert
          map("<leader>tj", function()
            local file = vim.fn.expand("%")
            local out = vim.fn.expand("%:r") .. ".json"
            vim.cmd("split | terminal yq '.' " .. file .. " > " .. out)
          end, "Convert to JSON")

          map("<leader>ty", function()
            local file = vim.fn.expand("%")
            local out = vim.fn.expand("%:r") .. ".yaml"
            vim.cmd("split | terminal yq -y '.' " .. file .. " > " .. out)
          end, "Convert to YAML")

          -- Code actions
          map("<leader>ta", function()
            vim.lsp.buf.code_action()
          end, "Code Actions")

          map("<leader>th", function()
            vim.lsp.buf.hover()
          end, "Hover Info")
        end,
      })

      -- JSONL keybindings (jq-based; no LSP or prettier — they don't support multi-value files)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "jsonl" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "JSONL: " .. desc })
          end

          -- Format each line via jq
          map("<leader>jf", function()
            vim.cmd("%!jq '.'")
          end, "Format lines (jq)")

          -- Minify each line
          map("<leader>jm", function()
            vim.cmd("%!jq -c '.'")
          end, "Minify lines (jq)")

          -- jq query across all lines
          map("<leader>jq", function()
            local query = vim.fn.input("jq query: ", ".")
            if query ~= "" then
              vim.cmd("%!jq '" .. query .. "'")
            end
          end, "jq Query")

          map("<leader>jQ", function()
            local query = vim.fn.input("jq query: ", ".")
            local file = vim.fn.expand("%")
            if query ~= "" then
              vim.cmd("split | terminal jq '" .. query .. "' " .. file)
            end
          end, "jq Query (preview)")

          -- Sort keys on each line
          map("<leader>js", function()
            vim.cmd("%!jq -c -S '.'")
          end, "Sort Keys")

          -- Show diagnostics
          map("<leader>jv", function()
            vim.diagnostic.setloclist()
          end, "Show Diagnostics")
        end,
      })
    end,
  },
}
