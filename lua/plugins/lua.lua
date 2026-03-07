-- Lua Development Configuration
-- LSP (lua_ls), lazydev.nvim for Neovim API, and formatting (stylua)

return {
  -- TreeSitter parsers for Lua
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "lua",
        "luadoc",
        "luap",
      })
    end,
  },

  -- Mason: ensure Lua tools are installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "lua-language-server",
        "stylua",
      })
    end,
  },

  -- lazydev.nvim: Neovim Lua development (replaces neodev.nvim)
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        -- Load LazyVim library
        { path = "LazyVim", words = { "LazyVim" } },
        -- Load lazy.nvim
        { path = "lazy.nvim", words = { "LazySpec" } },
      },
    },
  },

  -- Optional: luvit types for vim.uv
  { "Bilal2453/luvit-meta", lazy = true },

  -- lua_ls LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              diagnostics = {
                globals = { "vim" },
                disable = { "missing-fields" },
              },
              format = {
                enable = false, -- Using stylua instead
              },
            },
          },
        },
      },
    },
  },

  -- Code formatting with stylua
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },

  -- Lua-specific keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "lua",
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "Lua: " .. desc })
          end
          local vmap = function(keys, func, desc)
            vim.keymap.set("v", keys, func, { buffer = event.buf, desc = "Lua: " .. desc })
          end

          -- Run current file
          map("<leader>lr", function()
            vim.cmd("luafile %")
            vim.notify("Executed: " .. vim.fn.expand("%:t"), vim.log.levels.INFO)
          end, "Run File")

          -- Source current file (for Neovim config)
          map("<leader>ls", function()
            vim.cmd("source %")
            vim.notify("Sourced: " .. vim.fn.expand("%:t"), vim.log.levels.INFO)
          end, "Source File")

          -- Execute selected Lua code (requires Neovim 0.10+)
          vmap("<leader>le", function()
            if not vim.fn.getregion then
              vim.notify("Execute Selection requires Neovim 0.10+", vim.log.levels.WARN)
              return
            end
            local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
            local code = table.concat(lines, "\n")
            local func, err = load(code)
            if func then
              local ok, result = pcall(func)
              if ok then
                if result ~= nil then
                  vim.notify(vim.inspect(result), vim.log.levels.INFO)
                else
                  vim.notify("Executed successfully", vim.log.levels.INFO)
                end
              else
                vim.notify("Runtime error: " .. tostring(result), vim.log.levels.ERROR)
              end
            else
              vim.notify("Syntax error: " .. tostring(err), vim.log.levels.ERROR)
            end
          end, "Execute Selection")

          -- Print inspect of word under cursor
          map("<leader>lp", function()
            local word = vim.fn.expand("<cword>")
            local ok, result = pcall(function()
              return load("return " .. word)()
            end)
            if ok then
              vim.notify(vim.inspect(result), vim.log.levels.INFO)
            else
              vim.notify("Cannot inspect: " .. word, vim.log.levels.WARN)
            end
          end, "Print Inspect")

          -- Open scratch buffer for Lua
          map("<leader>lS", function()
            vim.cmd("enew")
            vim.bo.filetype = "lua"
            vim.bo.buftype = "nofile"
            vim.bo.bufhidden = "wipe"
            vim.notify("Lua scratch buffer", vim.log.levels.INFO)
          end, "Scratch Buffer")

          -- Check Neovim config health
          map("<leader>lh", "<cmd>checkhealth<cr>", "Check Health")
        end,
      })
    end,
  },
}
