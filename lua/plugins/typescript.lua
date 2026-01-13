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
        },
      },
    },
  },

  -- TypeScript-specific keymaps (merged into single autocmd)
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "TS: " .. desc })
          end

          -- Import management
          map("<leader>jI", function()
            vim.lsp.buf.code_action({
              apply = true,
              context = { only = { "source.organizeImports" }, diagnostics = {} },
            })
          end, "Organize Imports")

          map("<leader>ju", function()
            vim.lsp.buf.code_action({
              apply = true,
              context = { only = { "source.removeUnused" }, diagnostics = {} },
            })
          end, "Remove Unused Imports")

          map("<leader>ji", function()
            vim.lsp.buf.code_action({
              apply = true,
              context = { only = { "source.addMissingImports" }, diagnostics = {} },
            })
          end, "Add Missing Imports")

          -- Fix all issues
          map("<leader>jf", function()
            vim.lsp.buf.code_action({
              apply = true,
              context = { only = { "source.fixAll" }, diagnostics = {} },
            })
          end, "Fix All")

          -- ESLint fix
          map("<leader>jl", function()
            vim.lsp.buf.code_action({
              apply = true,
              context = { only = { "source.fixAll.eslint" }, diagnostics = {} },
            })
          end, "ESLint Fix All")

          -- Navigation
          map("<leader>jD", function()
            local params = vim.lsp.util.make_position_params()
            vim.lsp.buf.execute_command({
              command = "typescript.goToSourceDefinition",
              arguments = { params.textDocument.uri, params.position },
            })
          end, "Go to Source Definition")

          map("<leader>jR", function()
            vim.lsp.buf.execute_command({
              command = "typescript.findAllFileReferences",
              arguments = { vim.uri_from_bufnr(0) },
            })
          end, "File References")

          -- File rename with import updates
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

          -- Type checking
          map("<leader>jc", "<cmd>split | terminal npx tsc --noEmit<cr>", "Type Check (tsc)")
          map("<leader>jC", "<cmd>split | terminal npx tsc --noEmit --watch<cr>", "Type Check Watch")

          -- Run file
          map("<leader>jx", function()
            local file = vim.fn.expand("%")
            local ext = vim.fn.expand("%:e")
            local cmd = ext == "ts" or ext == "tsx" and "npx tsx" or "node"
            vim.cmd("split | terminal " .. cmd .. " " .. file)
          end, "Run File")

          -- Package management
          map("<leader>jn", "<cmd>split | terminal npm run<cr>", "npm run")
          map("<leader>jt", "<cmd>split | terminal npm test<cr>", "npm test")
          map("<leader>jb", "<cmd>split | terminal npm run build<cr>", "npm build")
          map("<leader>jd", "<cmd>split | terminal npm run dev<cr>", "npm dev")
        end,
      })
    end,
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
    config = function()
      local dap = require("dap")

      -- Only configure once
      if dap.adapters["pwa-node"] then
        return
      end

      -- Node.js debug adapter
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

      -- Chrome debug adapter (for browser debugging)
      dap.adapters["pwa-chrome"] = {
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

      -- Debug configurations for all JS/TS filetypes
      local js_based_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

      for _, language in ipairs(js_based_languages) do
        dap.configurations[language] = {
          -- Launch current file
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch File",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
          },
          -- Attach to running process
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to Process",
            processId = function()
              return require("dap.utils").pick_process()
            end,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
          },
          -- Debug Jest tests
          {
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
            sourceMaps = true,
          },
          -- Debug Vitest tests
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Vitest Tests",
            runtimeExecutable = "node",
            runtimeArgs = {
              "./node_modules/vitest/vitest.mjs",
              "--run",
              "--no-file-parallelism",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
            sourceMaps = true,
          },
          -- Debug Mocha tests
          {
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
            sourceMaps = true,
          },
          -- Debug in Chrome
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch Chrome",
            url = function()
              local co = coroutine.running()
              return coroutine.create(function()
                vim.ui.input({ prompt = "URL: ", default = "http://localhost:3000" }, function(url)
                  if url then
                    coroutine.resume(co, url)
                  else
                    coroutine.resume(co, "http://localhost:3000")
                  end
                end)
              end)
            end,
            webRoot = "${workspaceFolder}",
            sourceMaps = true,
          },
          -- Attach to Chrome
          {
            type = "pwa-chrome",
            request = "attach",
            name = "Attach to Chrome",
            port = 9222,
            webRoot = "${workspaceFolder}",
            sourceMaps = true,
          },
        }
      end
    end,
  },
}
