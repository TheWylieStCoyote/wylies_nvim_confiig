-- Haskell Development Configuration
-- LSP (haskell-language-server), formatting (ormolu), linting (hlint)

-- Skip entire Haskell config if ghcup is not installed
if vim.fn.executable("ghcup") ~= 1 then
  return {}
end

return {
  -- TreeSitter parsers for Haskell
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "haskell",
      })
    end,
  },

  -- Mason: ensure Haskell tools are installed (only if ghcup is available)
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      if vim.fn.executable("ghcup") == 1 then
        vim.list_extend(opts.ensure_installed or {}, {
          "haskell-language-server",
          "ormolu",
          "hlint",
        })
      end
    end,
  },

  -- haskell-language-server configuration (only if ghcup is available)
  -- Completely skip this config if ghcup is not installed to prevent mason-lspconfig auto-install
  vim.fn.executable("ghcup") == 1 and {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        hls = {
          filetypes = { "haskell", "lhaskell", "cabal" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.root_pattern(
              "hie.yaml",
              "stack.yaml",
              "cabal.project",
              "*.cabal",
              "package.yaml",
              ".git"
            )(fname)
          end,
          settings = {
            haskell = {
              cabalFormattingProvider = "cabalfmt",
              formattingProvider = "ormolu",
              checkProject = true,
              plugin = {
                alternateNumberFormat = { globalOn = true },
                callHierarchy = { globalOn = true },
                changeTypeSignature = { globalOn = true },
                class = { globalOn = true },
                eval = { globalOn = true },
                explicitFixity = { globalOn = true },
                gadt = { globalOn = true },
                ["ghcide-code-actions-bindings"] = { globalOn = true },
                ["ghcide-code-actions-fill-holes"] = { globalOn = true },
                ["ghcide-code-actions-imports-exports"] = { globalOn = true },
                ["ghcide-code-actions-type-signatures"] = { globalOn = true },
                ["ghcide-completions"] = {
                  globalOn = true,
                  config = {
                    autoExtendOn = true,
                    snippetsOn = true,
                  },
                },
                ["ghcide-hover-and-symbols"] = { globalOn = true },
                ["ghcide-type-lenses"] = {
                  globalOn = true,
                  config = { mode = "always" },
                },
                haddockComments = { globalOn = true },
                hlint = {
                  globalOn = true,
                  config = { flags = {} },
                },
                importLens = { globalOn = true },
                moduleName = { globalOn = true },
                pragmas = { globalOn = true },
                qualifyImportedNames = { globalOn = true },
                refineImports = { globalOn = true },
                rename = { globalOn = true },
                retrie = { globalOn = true },
                splice = { globalOn = true },
                tactics = {
                  globalOn = true,
                  config = {
                    auto_gas = 4,
                    hole_severity = nil,
                    max_use_ctor_actions = 5,
                    timeout_duration = 2,
                  },
                },
              },
            },
          },
        },
      },
    },
  } or nil,

  -- Code formatting with ormolu
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        haskell = { "ormolu" },
        lhaskell = { "ormolu" },
        cabal = { "cabal_fmt" },
      },
    },
  },

  -- Linting with hlint
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        haskell = { "hlint" },
        lhaskell = { "hlint" },
      },
    },
  },

  -- Haskell-specific keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "haskell", "lhaskell", "cabal" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "Haskell: " .. desc })
          end

          -- Run Haskell
          map("<leader>Hr", function()
            vim.cmd("split | terminal runhaskell " .. vim.fn.expand("%"))
          end, "Run File")

          map("<leader>HR", function()
            vim.cmd("split | terminal runghc " .. vim.fn.expand("%"))
          end, "Run with runghc")

          -- GHCi
          map("<leader>Hi", function()
            vim.cmd("split | terminal ghci")
          end, "GHCi REPL")

          map("<leader>HI", function()
            vim.cmd("split | terminal ghci " .. vim.fn.expand("%"))
          end, "GHCi with File")

          map("<leader>HL", function()
            vim.cmd("split | terminal ghci -e ':load " .. vim.fn.expand("%") .. "'")
          end, "GHCi Load File")

          -- Cabal commands
          map("<leader>Hb", function()
            vim.cmd("split | terminal cabal build")
          end, "Cabal Build")

          map("<leader>HB", function()
            vim.cmd("split | terminal cabal build all")
          end, "Cabal Build All")

          map("<leader>Ht", function()
            vim.cmd("split | terminal cabal test")
          end, "Cabal Test")

          map("<leader>HT", function()
            vim.cmd("split | terminal cabal test --test-show-details=always")
          end, "Cabal Test (verbose)")

          map("<leader>Hx", function()
            vim.cmd("split | terminal cabal run")
          end, "Cabal Run")

          map("<leader>Hc", function()
            vim.cmd("split | terminal cabal clean")
          end, "Cabal Clean")

          map("<leader>Hu", function()
            vim.cmd("split | terminal cabal update")
          end, "Cabal Update")

          map("<leader>Hd", function()
            local pkg = vim.fn.input("Package name: ")
            if pkg ~= "" then
              vim.cmd("split | terminal cabal install " .. pkg)
            end
          end, "Cabal Install")

          -- Stack commands (alternative)
          map("<leader>HSb", function()
            vim.cmd("split | terminal stack build")
          end, "Stack Build")

          map("<leader>HSt", function()
            vim.cmd("split | terminal stack test")
          end, "Stack Test")

          map("<leader>HSr", function()
            vim.cmd("split | terminal stack run")
          end, "Stack Run")

          map("<leader>HSg", function()
            vim.cmd("split | terminal stack ghci")
          end, "Stack GHCi")

          -- Hoogle
          map("<leader>Hh", function()
            local query = vim.fn.input("Hoogle search: ")
            if query ~= "" then
              vim.cmd("split | terminal hoogle search '" .. query .. "'")
            end
          end, "Hoogle Search")

          map("<leader>HH", function()
            local word = vim.fn.expand("<cword>")
            vim.cmd("split | terminal hoogle search '" .. word .. "'")
          end, "Hoogle Word")

          -- HLint
          map("<leader>Hl", function()
            vim.cmd("split | terminal hlint " .. vim.fn.expand("%"))
          end, "HLint File")

          map("<leader>HlP", function()
            vim.cmd("split | terminal hlint .")
          end, "HLint Project")

          -- Type info (using LSP)
          map("<leader>Hs", function()
            vim.lsp.buf.hover()
          end, "Show Type")

          -- Code actions
          map("<leader>Ha", function()
            vim.lsp.buf.code_action()
          end, "Code Actions")

          -- New project
          map("<leader>Hn", function()
            local name = vim.fn.input("Project name: ")
            if name ~= "" then
              vim.cmd("split | terminal cabal init --interactive --package-name=" .. name)
            end
          end, "Cabal Init")

          map("<leader>HN", function()
            local name = vim.fn.input("Project name: ")
            if name ~= "" then
              vim.cmd("split | terminal stack new " .. name)
            end
          end, "Stack New")

          -- GHC compile
          map("<leader>Hg", function()
            vim.cmd("split | terminal ghc " .. vim.fn.expand("%"))
          end, "GHC Compile")

          map("<leader>HG", function()
            vim.cmd("split | terminal ghc -O2 " .. vim.fn.expand("%"))
          end, "GHC Compile (optimized)")

          -- Documentation
          map("<leader>HD", function()
            vim.cmd("split | terminal cabal haddock")
          end, "Generate Haddock")
        end,
      })
    end,
  },
}
