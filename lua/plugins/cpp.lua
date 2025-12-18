-- C/C++ Development Configuration
-- LSP, debugging, formatting, and build system support

return {
  -- TreeSitter parsers for C/C++ and build systems
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "c",
        "cpp",
        "cmake",
        "make",
        "meson",
      })
    end,
  },

  -- Mason: ensure C++ tools are installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "clangd",
        "clang-format",
        "codelldb",
      })
    end,
  },

  -- clangd LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
          keys = {
            { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
          },
        },
      },
    },
  },

  -- clangd extensions for enhanced features
  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    opts = {
      inlay_hints = {
        inline = false,
      },
      ast = {
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    },
    keys = {
      { "<leader>ci", "<cmd>ClangdSymbolInfo<cr>", desc = "Symbol Info" },
      { "<leader>ct", "<cmd>ClangdTypeHierarchy<cr>", desc = "Type Hierarchy" },
      { "<leader>cm", "<cmd>ClangdMemoryUsage<cr>", desc = "Memory Usage" },
      { "<leader>ca", "<cmd>ClangdAST<cr>", desc = "View AST" },
    },
  },

  -- Code formatting with clang-format
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
    },
  },

  -- CMake tools
  {
    "Civitasv/cmake-tools.nvim",
    lazy = true,
    ft = { "cmake" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      cmake_build_directory = "build/${variant:buildType}",
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" },
      cmake_soft_link_compile_commands = true,
      cmake_regenerate_on_save = true,
      cmake_build_options = { "-j8" },
      cmake_console_size = 15,
      cmake_show_console = "only_on_error",
    },
    keys = {
      { "<leader>cg", "<cmd>CMakeGenerate<cr>", desc = "CMake Generate" },
      { "<leader>cb", "<cmd>CMakeBuild<cr>", desc = "CMake Build" },
      { "<leader>cr", "<cmd>CMakeRun<cr>", desc = "CMake Run" },
      { "<leader>cd", "<cmd>CMakeDebug<cr>", desc = "CMake Debug" },
      { "<leader>cs", "<cmd>CMakeSelectBuildType<cr>", desc = "CMake Select Build Type" },
      { "<leader>cq", "<cmd>CMakeClose<cr>", desc = "CMake Close" },
      { "<leader>cC", "<cmd>CMakeClean<cr>", desc = "CMake Clean" },
      { "<leader>ct", "<cmd>CMakeSelectBuildTarget<cr>", desc = "CMake Select Target" },
      { "<leader>cT", "<cmd>CMakeSelectLaunchTarget<cr>", desc = "CMake Select Launch Target" },
      { "<leader>cS", "<cmd>CMakeSettings<cr>", desc = "CMake Settings" },
    },
  },

  -- C/C++ debug configuration (extends centralized DAP)
  {
    "mfussenegger/nvim-dap",
    optional = true,
    ft = { "c", "cpp" },
    config = function()
      local dap = require("dap")

      -- codelldb adapter configuration
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      }

      -- C/C++ debug configurations
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp
    end,
  },
}
