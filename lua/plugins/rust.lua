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
        -- Prefer the toolchain's own rust-analyzer (installed via
        -- `rustup component add rust-analyzer`): its version and proc-macro
        -- server ABI match rustc exactly, and the rustup proxy follows each
        -- project's rust-toolchain.toml. Fall back to Mason's standalone build
        -- when the active toolchain has no rust-analyzer component.
        cmd = function()
          local proxy = vim.fn.expand("~/.cargo/bin/rust-analyzer")
          if vim.fn.executable("rustup") == 1 and vim.fn.executable(proxy) == 1 then
            vim.fn.system({ "rustup", "which", "rust-analyzer" })
            if vim.v.shell_error == 0 then
              return { proxy }
            end
          end
          local mason = vim.fn.stdpath("data") .. "/mason/bin/rust-analyzer"
          if vim.fn.executable(mason) == 1 then
            return { mason }
          end
          return { "rust-analyzer" }
        end,
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
              -- Default features only. "all" breaks crates with mutually exclusive
              -- features (embedded HALs, defmt vs log, ...) and multiplies indexing work.
              features = {},
              buildScripts = {
                enable = true,
              },
              -- Use target/rust-analyzer so editor checks never contend for the
              -- build-directory lock with cargo running in a terminal.
              targetDir = true,
            },
            -- checkOnSave is a boolean; the command lives under `check`.
            checkOnSave = true,
            check = {
              command = "clippy",
              extraArgs = { "--no-deps" },
              -- Don't check test/bench/example targets on every save; they can't
              -- even build for no_std cross targets.
              allTargets = false,
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

  -- RustOwl: visualize ownership, borrows, and lifetimes under the cursor
  -- Needs the `rustowl` binary on PATH; install it yourself with one of:
  --   cargo binstall rustowl                          (prebuilt, fastest)
  --   cargo install rustowl                           (builds from source)
  --   curl -L https://raw.githubusercontent.com/cordx56/rustowl/refs/heads/main/scripts/installer | sh
  {
    "cordx56/rustowl",
    version = "*",
    ft = { "rust" }, -- the plugin attaches from its own ftplugin/rust.lua
    -- Don't load the plugin at all unless the binary made it onto PATH
    cond = function()
      return vim.fn.executable("rustowl") == 1
    end,
    opts = {
      auto_attach = true,
      -- Opt in per buffer with <leader>ro instead of highlighting everywhere
      auto_enable = false,
      idle_time = 500,
    },
    keys = {
      {
        "<leader>ro",
        function()
          require("rustowl").toggle()
        end,
        desc = "RustOwl: Toggle Ownership Hints",
        ft = "rust",
      },
      { "<leader>rO", "<cmd>Rustowl restart_client<cr>", desc = "RustOwl: Restart Client", ft = "rust" },
    },
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
