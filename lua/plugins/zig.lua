-- Zig Development Configuration
-- LSP (zls), debugging (codelldb), and formatting (zig fmt)

return {
  -- TreeSitter parsers for Zig
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "zig",
      })
    end,
  },

  -- Mason: ensure Zig tools are installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "zls",
        "codelldb",
      })
    end,
  },

  -- zls LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        zls = {
          settings = {
            zls = {
              enable_snippets = true,
              enable_argument_placeholders = true,
              enable_ast_check_diagnostics = true,
              enable_autofix = true,
              enable_import_embedfile_argument_completions = true,
              warn_style = true,
              enable_semantic_tokens = true,
              enable_inlay_hints = true,
              inlay_hints_exclude_single_argument = true,
              inlay_hints_show_builtin = true,
              inlay_hints_show_parameter_name = true,
              inlay_hints_show_variable_type_hints = true,
              operator_completions = true,
              include_at_in_builtins = true,
              highlight_global_at_types = true,
            },
          },
        },
      },
    },
  },

  -- Code formatting with zig fmt
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        zig = { "zigfmt" },
      },
    },
  },

  -- Zig debugging with codelldb (Zig uses LLVM)
  {
    "mfussenegger/nvim-dap",
    optional = true,
    ft = { "zig" },
    opts = function()
      local dap = require("dap")

      -- Zig debug configurations using codelldb
      dap.configurations.zig = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = function()
            -- Try to find the executable in zig-out/bin/
            local cwd = vim.fn.getcwd()
            local zig_out = cwd .. "/zig-out/bin/"
            if vim.fn.isdirectory(zig_out) == 1 then
              local files = vim.fn.readdir(zig_out)
              if #files > 0 then
                return vim.fn.input("Path to executable: ", zig_out .. files[1], "file")
              end
            end
            return vim.fn.input("Path to executable: ", cwd .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
        {
          name = "Launch (with args)",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/zig-out/bin/", "file")
          end,
          args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " ")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
        {
          name = "Attach to process",
          type = "codelldb",
          request = "attach",
          pid = function() return require("dap.utils").pick_process() end,
          cwd = "${workspaceFolder}",
        },
      }
    end,
  },

  -- Zig-specific keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "zig",
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "Zig: " .. desc })
          end

          -- Build commands
          map("<leader>zb", function()
            vim.cmd("split | terminal zig build")
          end, "Build")

          map("<leader>zB", function()
            vim.cmd("split | terminal zig build -Doptimize=ReleaseFast")
          end, "Build (Release)")

          map("<leader>zr", function()
            vim.cmd("split | terminal zig build run")
          end, "Build & Run")

          map("<leader>zt", function()
            vim.cmd("split | terminal zig build test")
          end, "Build & Test")

          -- Direct zig commands on current file
          map("<leader>zR", function()
            vim.cmd("split | terminal zig run " .. vim.fn.expand("%"))
          end, "Run File")

          map("<leader>zT", function()
            vim.cmd("split | terminal zig test " .. vim.fn.expand("%"))
          end, "Test File")

          -- Fetch dependencies
          map("<leader>zf", function()
            vim.cmd("split | terminal zig fetch")
          end, "Fetch Dependencies")

          -- Format (usually handled by conform, but manual option)
          map("<leader>zF", function()
            vim.cmd("!zig fmt " .. vim.fn.expand("%"))
            vim.cmd("edit")
          end, "Format File")

          -- Check syntax
          map("<leader>zc", function()
            vim.cmd("split | terminal zig ast-check " .. vim.fn.expand("%"))
          end, "AST Check")

          -- Open build.zig
          map("<leader>zo", function()
            local build_zig = vim.fn.getcwd() .. "/build.zig"
            if vim.fn.filereadable(build_zig) == 1 then
              vim.cmd("edit " .. build_zig)
            else
              vim.notify("build.zig not found", vim.log.levels.WARN)
            end
          end, "Open build.zig")
        end,
      })
    end,
  },
}
