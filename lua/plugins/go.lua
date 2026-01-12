-- Go Development Configuration
-- LSP (gopls), debugging (delve), formatting, and go.nvim

-- Skip entire Go config if Go is not installed
if vim.fn.executable("go") ~= 1 then
  return {}
end

return {
  -- TreeSitter parsers for Go
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "go",
        "gomod",
        "gosum",
        "gowork",
      })
    end,
  },

  -- Mason: ensure Go tools are installed (only if Go is available)
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      if vim.fn.executable("go") == 1 then
        vim.list_extend(opts.ensure_installed or {}, {
          "gopls",
          "goimports",
          "golangci-lint",
          "delve",
        })
      end
    end,
  },

  -- gopls LSP configuration (only if Go is available)
  -- Completely skip this config if Go is not installed to prevent mason-lspconfig auto-install
  vim.fn.executable("go") == 1 and {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          },
        },
      },
    },
  } or nil,

  -- go.nvim: Enhanced Go development
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      disable_defaults = false,
      go = "go",
      goimports = "gopls",
      fillstruct = "gopls",
      gofmt = "gofumpt",
      tag_transform = false,
      tag_options = "json=omitempty",
      gotests_template = "",
      gotests_template_dir = "",
      comment_placeholder = "",
      icons = { breakpoint = "🔴", currentpos = "👉" },
      verbose = false,
      lsp_cfg = false, -- We configure LSP separately
      lsp_gofumpt = true,
      lsp_on_attach = nil,
      lsp_keymaps = false, -- We define our own keymaps
      lsp_codelens = true,
      diagnostic = {
        hdlr = false,
        underline = true,
        virtual_text = { space = 0, prefix = "■" },
        signs = true,
        update_in_insert = false,
      },
      lsp_inlay_hints = { enable = true },
      lsp_diag_update_in_insert = false,
      test_runner = "go",
      run_in_floaterm = false,
      trouble = true,
      luasnip = true,
      dap_debug = true,
      dap_debug_keymap = false, -- We define our own DAP keymaps
      dap_debug_gui = true,
      dap_debug_vt = true,
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    keys = {
      -- Run
      { "<leader>gr", "<cmd>GoRun<cr>", desc = "Go Run" },
      { "<leader>gR", "<cmd>GoRun %<cr>", desc = "Go Run File" },
      -- Test
      { "<leader>gt", "<cmd>GoTest<cr>", desc = "Go Test" },
      { "<leader>gT", "<cmd>GoTestFile<cr>", desc = "Go Test File" },
      { "<leader>gtt", "<cmd>GoTestFunc<cr>", desc = "Go Test Function" },
      -- Coverage (using <leader>G to avoid conflict with git)
      { "<leader>Gc", "<cmd>GoCoverage<cr>", desc = "Go Coverage" },
      { "<leader>GC", "<cmd>GoCoverage -t<cr>", desc = "Go Coverage Toggle" },
      -- Code generation
      { "<leader>gi", "<cmd>GoImpl<cr>", desc = "Go Implement Interface" },
      { "<leader>gf", "<cmd>GoFillStruct<cr>", desc = "Go Fill Struct" },
      { "<leader>ga", "<cmd>GoAddTag<cr>", desc = "Go Add Tags" },
      { "<leader>gA", "<cmd>GoRmTag<cr>", desc = "Go Remove Tags" },
      -- Mod
      { "<leader>gm", "<cmd>GoMod tidy<cr>", desc = "Go Mod Tidy" },
      { "<leader>gM", "<cmd>GoModInit<cr>", desc = "Go Mod Init" },
      -- Debug
      { "<leader>GD", "<cmd>GoDebug<cr>", desc = "Go Debug" },
      { "<leader>gD", "<cmd>GoDebug -t<cr>", desc = "Go Debug Test" },
      { "<leader>gb", "<cmd>GoBreakToggle<cr>", desc = "Go Toggle Breakpoint" },
      -- Other
      { "<leader>ge", "<cmd>GoIfErr<cr>", desc = "Go If Err" },
      { "<leader>gw", "<cmd>GoFillSwitch<cr>", desc = "Go Fill Switch" },
      { "<leader>gl", "<cmd>GoLint<cr>", desc = "Go Lint" },
      { "<leader>gv", "<cmd>GoVet<cr>", desc = "Go Vet" },
      { "<leader>gp", "<cmd>GoFixPlurals<cr>", desc = "Go Fix Plurals" },
    },
  },

  -- Code formatting with goimports
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofmt" },
      },
    },
  },

  -- Linting with golangci-lint
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        go = { "golangcilint" },
      },
    },
  },

  -- Go debugging with delve
  {
    "leoluz/nvim-dap-go",
    ft = { "go", "gomod" },
    opts = {
      dap_configurations = {
        {
          type = "go",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
        {
          type = "go",
          name = "Debug Package",
          request = "launch",
          program = "${fileDirname}",
        },
        {
          type = "go",
          name = "Debug Test",
          request = "launch",
          mode = "test",
          program = "${file}",
        },
        {
          type = "go",
          name = "Debug Test (Package)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}",
        },
        {
          type = "go",
          name = "Attach",
          mode = "local",
          request = "attach",
          processId = function() return require("dap.utils").pick_process() end,
        },
      },
      delve = {
        path = vim.fn.stdpath("data") .. "/mason/bin/dlv",
        initialize_timeout_sec = 20,
        port = "${port}",
        args = {},
        build_flags = "",
      },
    },
    keys = {
      { "<leader>dgt", function() require("dap-go").debug_test() end, desc = "Debug Go Test", ft = "go" },
      { "<leader>dgl", function() require("dap-go").debug_last_test() end, desc = "Debug Last Go Test", ft = "go" },
    },
  },
}
