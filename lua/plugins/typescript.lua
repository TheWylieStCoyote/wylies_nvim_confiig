-- TypeScript/JavaScript Development Configuration
-- LSP (vtsls), debugging, formatting (prettier), and linting (eslint)

return {
  -- TreeSitter parsers for TypeScript/JavaScript
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "javascript",
        "typescript",
        "tsx",
        "jsdoc",
        "json",
        "jsonc",
      })
    end,
  },

  -- Mason: ensure TypeScript tools are installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "vtsls",
        "prettier",
        "eslint_d",
        "js-debug-adapter",
      })
    end,
  },

  -- vtsls LSP configuration (faster than tsserver)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
            javascript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
          keys = {
            {
              "<leader>jI",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.organizeImports" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Organize Imports",
            },
            {
              "<leader>ju",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.removeUnused" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Remove Unused Imports",
            },
            {
              "<leader>ji",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.addMissingImports" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Add Missing Imports",
            },
            {
              "<leader>jf",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.fixAll" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Fix All",
            },
            {
              "<leader>jD",
              function()
                local params = vim.lsp.util.make_position_params()
                vim.lsp.buf.execute_command({
                  command = "typescript.goToSourceDefinition",
                  arguments = { params.textDocument.uri, params.position },
                })
              end,
              desc = "Go to Source Definition",
            },
            {
              "<leader>jR",
              function()
                vim.lsp.buf.execute_command({
                  command = "typescript.findAllFileReferences",
                  arguments = { vim.uri_from_bufnr(0) },
                })
              end,
              desc = "File References",
            },
          },
        },
      },
    },
  },

  -- Code formatting with prettier
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
      },
    },
  },

  -- Linting with ESLint
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      },
    },
  },

  -- TypeScript/JavaScript debugging with js-debug
  {
    "mfussenegger/nvim-dap",
    optional = true,
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      local dap = require("dap")

      -- js-debug-adapter configuration
      if not dap.adapters["pwa-node"] then
        dap.adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = {
              vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
              "${port}",
            },
          },
        }
      end

      -- Node.js debug configurations
      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        dap.configurations[language] = dap.configurations[language] or {}
        table.insert(dap.configurations[language], {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        })
        table.insert(dap.configurations[language], {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = function() return require("dap.utils").pick_process() end,
          cwd = "${workspaceFolder}",
        })
        table.insert(dap.configurations[language], {
          type = "pwa-node",
          request = "launch",
          name = "Debug Jest Tests",
          runtimeExecutable = "node",
          runtimeArgs = {
            "./node_modules/jest/bin/jest.js",
            "--runInBand",
          },
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
        })
        table.insert(dap.configurations[language], {
          type = "pwa-node",
          request = "launch",
          name = "Debug Mocha Tests",
          runtimeExecutable = "node",
          runtimeArgs = {
            "./node_modules/mocha/bin/mocha.js",
          },
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
        })
      end
    end,
  },

  -- Additional TypeScript keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Set up TypeScript-specific keymaps when entering TS/JS files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "TS: " .. desc })
          end

          map("<leader>jr", function()
            local old_name = vim.fn.expand("%")
            vim.ui.input({ prompt = "New filename: ", default = old_name }, function(new_name)
              if new_name and new_name ~= "" and new_name ~= old_name then
                vim.lsp.buf.execute_command({
                  command = "typescript.renameFile",
                  arguments = {
                    { sourceUri = vim.uri_from_fname(old_name), targetUri = vim.uri_from_fname(new_name) },
                  },
                })
              end
            end)
          end, "Rename File")

          map("<leader>jn", "<cmd>split | terminal npm run<cr>", "npm run")
          map("<leader>jt", "<cmd>split | terminal npm test<cr>", "npm test")
        end,
      })
    end,
  },
}
