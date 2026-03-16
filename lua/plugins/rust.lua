-- Rust Development Configuration
-- LSP (rust-analyzer), debugging, formatting, and crates.nvim

-- Skip entire Rust config if Rust is not installed
if vim.fn.executable("rustc") ~= 1 and vim.fn.executable("cargo") ~= 1 then
  return {}
end

return {
  -- TreeSitter parsers for Rust
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "rust",
        "toml",
      })
    end,
  },

  -- Mason: ensure Rust tools are installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "rust-analyzer",
        "codelldb",
      })
    end,
  },

  -- rustaceanvim: Modern Rust plugin (replaces rust-tools.nvim)
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    opts = {
      server = {
        on_attach = function(_, bufnr)
          -- Rust-specific keymaps
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "Rust: " .. desc })
          end

          map("<leader>rr", function()
            vim.cmd.RustLsp("runnables")
          end, "Runnables")
          map("<leader>rt", function()
            vim.cmd.RustLsp("testables")
          end, "Testables")
          map("<leader>rd", function()
            vim.cmd.RustLsp("openDocs")
          end, "Open docs.rs")
          map("<leader>rc", function()
            vim.cmd.RustLsp("openCargo")
          end, "Open Cargo.toml")
          map("<leader>rm", function()
            vim.cmd.RustLsp("expandMacro")
          end, "Expand Macro")
          map("<leader>rp", function()
            vim.cmd.RustLsp("parentModule")
          end, "Parent Module")
          map("<leader>rj", function()
            vim.cmd.RustLsp("joinLines")
          end, "Join Lines")
          map("<leader>ra", function()
            vim.cmd.RustLsp("codeAction")
          end, "Code Action")
          map("<leader>re", function()
            vim.cmd.RustLsp("explainError")
          end, "Explain Error")
          map("<leader>rh", function()
            vim.cmd.RustLsp("hover", "actions")
          end, "Hover Actions")
          map("<leader>rD", function()
            vim.cmd.RustLsp("debuggables")
          end, "Debuggables")
        end,
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            checkOnSave = {
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
            inlayHints = {
              bindingModeHints = { enable = true },
              chainingHints = { enable = true },
              closingBraceHints = { enable = true, minLines = 25 },
              closureReturnTypeHints = { enable = "always" },
              lifetimeElisionHints = { enable = "always", useParameterNames = true },
              maxLength = 25,
              parameterHints = { enable = true },
              reborrowHints = { enable = "always" },
              renderColons = true,
              typeHints = { enable = true, hideClosureInitialization = false, hideNamedConstructor = false },
            },
          },
        },
      },
      dap = {
        adapter = {
          type = "server",
          port = "${port}",
          executable = {
            command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
            args = { "--port", "${port}" },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = opts
    end,
  },

  -- crates.nvim: Cargo.toml dependency management
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      -- Use LSP-based completion (cmp source is deprecated)
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
    keys = {
      {
        "<leader>cu",
        function()
          require("crates").upgrade_all_crates()
        end,
        desc = "Update All Crates",
        ft = "toml",
      },
      {
        "<leader>cU",
        function()
          require("crates").upgrade_crate()
        end,
        desc = "Update Crate",
        ft = "toml",
      },
      {
        "<leader>cf",
        function()
          require("crates").show_features_popup()
        end,
        desc = "Show Crate Features",
        ft = "toml",
      },
      {
        "<leader>cv",
        function()
          require("crates").show_versions_popup()
        end,
        desc = "Show Crate Versions",
        ft = "toml",
      },
      {
        "<leader>cD",
        function()
          require("crates").show_dependencies_popup()
        end,
        desc = "Show Dependencies",
        ft = "toml",
      },
      {
        "<leader>cH",
        function()
          require("crates").open_homepage()
        end,
        desc = "Open Homepage",
        ft = "toml",
      },
      {
        "<leader>cR",
        function()
          require("crates").open_repository()
        end,
        desc = "Open Repository",
        ft = "toml",
      },
      {
        "<leader>cd",
        function()
          require("crates").open_documentation()
        end,
        desc = "Open Documentation",
        ft = "toml",
      },
      {
        "<leader>cC",
        function()
          require("crates").open_crates_io()
        end,
        desc = "Open crates.io",
        ft = "toml",
      },
    },
  },

  -- Code formatting with rustfmt
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        rust = { "rustfmt" },
      },
    },
  },

  -- Bacon: Background Rust code checker
  {
    "Canop/nvim-bacon",
    ft = { "rust" },
    cmd = { "BaconLoad", "BaconShow", "BaconList", "BaconPrevious", "BaconNext" },
    opts = {
      quickfix = {
        enabled = true,
        event_trigger = true,
      },
    },
    keys = {
      { "<leader>rb", "<cmd>BaconLoad<cr><cmd>BaconNext<cr>", desc = "Bacon: Load & Jump", ft = "rust" },
      { "<leader>rB", "<cmd>BaconShow<cr>", desc = "Bacon: Show Window", ft = "rust" },
      { "<leader>rl", "<cmd>BaconList<cr>", desc = "Bacon: List Locations", ft = "rust" },
      { "<leader>rn", "<cmd>BaconNext<cr>", desc = "Bacon: Next Location", ft = "rust" },
      { "<leader>rN", "<cmd>BaconPrevious<cr>", desc = "Bacon: Previous Location", ft = "rust" },
    },
  },

  -- Note: rustaceanvim handles the DAP configuration internally
}
