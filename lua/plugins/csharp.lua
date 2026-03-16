-- C# Development Configuration
-- LSP (OmniSharp), debugging (netcoredbg), and formatting (csharpier)

-- Skip entire C# config if .NET is not installed
if vim.fn.executable("dotnet") ~= 1 then
  return {}
end

return {
  -- TreeSitter parsers for C#
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "c_sharp",
      })
    end,
  },

  -- Mason: ensure C# tools are installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "omnisharp",
        "netcoredbg",
        "csharpier",
      })
    end,
  },

  -- OmniSharp extended for better go-to-definition
  {
    "Hoffs/omnisharp-extended-lsp.nvim",
    lazy = true,
  },

  -- OmniSharp LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = {
          cmd = { "omnisharp" },
          enable_roslyn_analyzers = true,
          enable_import_completion = true,
          organize_imports_on_format = true,
          enable_decompilation_support = true,
          filetypes = { "cs", "vb" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            local primary = lspconfig.util.root_pattern("*.sln")(fname)
            local fallback = lspconfig.util.root_pattern("*.csproj", ".git")(fname)
            return primary or fallback
          end,
          settings = {
            FormattingOptions = {
              EnableEditorConfigSupport = true,
              OrganizeImports = true,
            },
            MsBuild = {
              LoadProjectsOnDemand = false,
            },
            RoslynExtensionsOptions = {
              EnableAnalyzersSupport = true,
              EnableImportCompletion = true,
              AnalyzeOpenDocumentsOnly = true,
            },
            Sdk = {
              IncludePrereleases = true,
            },
          },
          handlers = {
            ["textDocument/definition"] = function(...)
              return require("omnisharp_extended").handler(...)
            end,
          },
          keys = {
            {
              "gd",
              function()
                require("omnisharp_extended").telescope_lsp_definitions()
              end,
              desc = "Go to Definition (OmniSharp)",
            },
            {
              "<leader>nD",
              function()
                require("omnisharp_extended").telescope_lsp_type_definitions()
              end,
              desc = "Go to Type Definition",
            },
            {
              "<leader>ni",
              function()
                require("omnisharp_extended").telescope_lsp_implementations()
              end,
              desc = "Go to Implementations",
            },
            {
              "<leader>nr",
              function()
                require("omnisharp_extended").telescope_lsp_references()
              end,
              desc = "Find References",
            },
          },
        },
      },
    },
  },

  -- Code formatting with csharpier
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
      },
      formatters = {
        csharpier = {
          command = "dotnet-csharpier",
          args = { "--write-stdout" },
        },
      },
    },
  },

  -- C# debugging with netcoredbg
  {
    "mfussenegger/nvim-dap",
    optional = true,
    ft = { "cs" },
    opts = function()
      local dap = require("dap")

      -- netcoredbg adapter
      dap.adapters.coreclr = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
        args = { "--interpreter=vscode" },
      }

      -- C# debug configurations
      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "Launch",
          request = "launch",
          program = function()
            -- Try to find the dll in common locations
            local cwd = vim.fn.getcwd()
            local dll_pattern = cwd .. "/bin/Debug/net*/**.dll"
            local dlls = vim.fn.glob(dll_pattern, false, true)

            if #dlls > 0 then
              -- Filter out test and ref dlls
              for _, dll in ipairs(dlls) do
                if not dll:match("%.Tests%.dll$") and not dll:match("/ref/") then
                  return vim.fn.input("Path to dll: ", dll, "file")
                end
              end
            end

            return vim.fn.input("Path to dll: ", cwd .. "/bin/Debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
        {
          type = "coreclr",
          name = "Launch (with args)",
          request = "launch",
          program = function()
            return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
          end,
          args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " ")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
        {
          type = "coreclr",
          name = "Attach",
          request = "attach",
          processId = function()
            return require("dap.utils").pick_process()
          end,
        },
      }
    end,
  },

  -- C#-specific keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "cs",
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "C#: " .. desc })
          end

          -- dotnet commands
          map("<leader>nb", function()
            vim.cmd("split | terminal dotnet build")
          end, "Build")

          map("<leader>nB", function()
            vim.cmd("split | terminal dotnet build --configuration Release")
          end, "Build (Release)")

          map("<leader>nR", function()
            vim.cmd("split | terminal dotnet run")
          end, "Run")

          map("<leader>nt", function()
            vim.cmd("split | terminal dotnet test")
          end, "Test")

          map("<leader>nT", function()
            vim.cmd("split | terminal dotnet test --filter " .. vim.fn.input("Filter: "))
          end, "Test (filtered)")

          map("<leader>nc", function()
            vim.cmd("split | terminal dotnet clean")
          end, "Clean")

          map("<leader>ne", function()
            vim.cmd("split | terminal dotnet restore")
          end, "Restore")

          map("<leader>nw", function()
            vim.cmd("split | terminal dotnet watch run")
          end, "Watch Run")

          map("<leader>nW", function()
            vim.cmd("split | terminal dotnet watch test")
          end, "Watch Test")

          -- Code actions
          map("<leader>no", function()
            vim.lsp.buf.code_action({
              context = { only = { "source.organizeImports" } },
              apply = true,
            })
          end, "Organize Usings")

          map("<leader>ng", function()
            vim.lsp.buf.code_action({
              context = { only = { "source.generate" } },
            })
          end, "Generate...")

          -- New project/file
          map("<leader>nn", function()
            local template = vim.fn.input("Template (console, classlib, webapi, etc.): ", "console")
            local name = vim.fn.input("Project name: ")
            if name ~= "" then
              vim.cmd("split | terminal dotnet new " .. template .. " -n " .. name)
            end
          end, "New Project")

          -- Add package
          map("<leader>np", function()
            local package = vim.fn.input("Package name: ")
            if package ~= "" then
              vim.cmd("split | terminal dotnet add package " .. package)
            end
          end, "Add Package")
        end,
      })
    end,
  },
}
