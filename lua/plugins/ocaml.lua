-- OCaml Development Configuration
-- LSP (ocamllsp), formatting (ocamlformat), and dune/opam support

-- Skip entire OCaml config if opam is not installed
if vim.fn.executable("opam") ~= 1 then
  return {}
end

return {
  -- TreeSitter parsers for OCaml
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "ocaml",
        "ocaml_interface",
        "dune",
      })
    end,
  },

  -- Mason: ensure OCaml tools are installed
  -- Note: Requires opam. Install manually: opam install ocaml-lsp-server ocamlformat

  -- ocamllsp configuration (only if opam is available)
  -- Completely skip this config if opam is not installed to prevent mason-lspconfig auto-install
  vim.fn.executable("opam") == 1 and {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ocamllsp = {
          cmd = { "ocamllsp" },
          filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.root_pattern(
              "*.opam",
              "esy.json",
              "package.json",
              ".git",
              "dune-project",
              "dune-workspace"
            )(fname)
          end,
          settings = {
            ocaml = {
              codelens = { enable = true },
              inlayHints = { enable = true },
              syntaxDocumentation = { enable = true },
            },
          },
          capabilities = {
            textDocument = {
              completion = {
                completionItem = {
                  snippetSupport = true,
                },
              },
            },
          },
        },
      },
    },
  } or nil,

  -- Code formatting with ocamlformat
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ocaml = { "ocamlformat" },
        ["ocaml.interface"] = { "ocamlformat" },
        reason = { "refmt" },
        dune = { "dune_fmt" },
      },
      formatters = {
        ocamlformat = {
          command = "ocamlformat",
          args = {
            "--name",
            "$FILENAME",
            "-",
          },
          stdin = true,
        },
        dune_fmt = {
          command = "dune",
          args = { "format-dune-file" },
          stdin = true,
        },
      },
    },
  },

  -- OCaml debugging with earlybird
  {
    "mfussenegger/nvim-dap",
    optional = true,
    ft = { "ocaml", "ocaml.interface", "ocaml.menhir", "ocaml.ocamllex" },
    opts = function()
      local dap = require("dap")

      -- OCaml debug adapter (earlybird)
      dap.adapters.ocaml = {
        type = "executable",
        command = "ocamlearlybird",
        args = { "debug" },
      }

      dap.configurations.ocaml = {
        {
          type = "ocaml",
          request = "launch",
          name = "Launch OCaml Program",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/_build/default/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
        {
          type = "ocaml",
          request = "attach",
          name = "Attach to Process",
          port = 4711,
        },
      }
    end,
  },

  -- OCaml-specific keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "ocaml", "ocaml.interface", "ocaml.menhir", "ocaml.ocamllex", "reason", "dune" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "OCaml: " .. desc })
          end

          -- Run OCaml
          map("<leader>or", function()
            vim.cmd("split | terminal ocaml " .. vim.fn.expand("%"))
          end, "Run File")

          map("<leader>oi", function()
            vim.cmd("split | terminal utop")
          end, "Utop REPL")

          map("<leader>oI", function()
            vim.cmd("split | terminal utop -init " .. vim.fn.expand("%"))
          end, "Utop with File")

          -- Dune commands
          map("<leader>ob", function()
            vim.cmd("split | terminal dune build")
          end, "Dune Build")

          map("<leader>oB", function()
            vim.cmd("split | terminal dune build @all")
          end, "Dune Build All")

          map("<leader>ot", function()
            vim.cmd("split | terminal dune test")
          end, "Dune Test")

          map("<leader>oT", function()
            vim.cmd("split | terminal dune test --force")
          end, "Dune Test (force)")

          map("<leader>ox", function()
            vim.cmd("split | terminal dune exec " .. vim.fn.input("Executable: "))
          end, "Dune Exec")

          map("<leader>oX", function()
            -- Try to find main executable from dune file
            local project = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            vim.cmd("split | terminal dune exec " .. project)
          end, "Dune Exec (project)")

          map("<leader>oc", function()
            vim.cmd("split | terminal dune clean")
          end, "Dune Clean")

          map("<leader>ow", function()
            vim.cmd("split | terminal dune build --watch")
          end, "Dune Watch")

          -- Opam commands
          map("<leader>op", function()
            local pkg = vim.fn.input("Package name: ")
            if pkg ~= "" then
              vim.cmd("split | terminal opam install " .. pkg)
            end
          end, "Opam Install")

          map("<leader>oP", function()
            vim.cmd("split | terminal opam update && opam upgrade")
          end, "Opam Update/Upgrade")

          map("<leader>os", function()
            vim.cmd("split | terminal opam switch")
          end, "Opam Switch List")

          map("<leader>oS", function()
            local switch = vim.fn.input("Switch name/compiler: ")
            if switch ~= "" then
              vim.cmd("split | terminal opam switch create " .. switch)
            end
          end, "Opam Switch Create")

          map("<leader>ol", function()
            vim.cmd("split | terminal opam list --installed")
          end, "Opam List Installed")

          -- Documentation
          map("<leader>od", function()
            local module = vim.fn.input("Module: ", vim.fn.expand("<cword>"))
            if module ~= "" then
              vim.cmd("split | terminal odig doc " .. module)
            end
          end, "Odig Documentation")

          map("<leader>oD", function()
            vim.cmd("split | terminal dune build @doc")
          end, "Dune Build Docs")

          -- New project
          map("<leader>on", function()
            local name = vim.fn.input("Project name: ")
            if name ~= "" then
              vim.cmd("split | terminal dune init project " .. name)
            end
          end, "Dune Init Project")

          map("<leader>oN", function()
            local name = vim.fn.input("Library name: ")
            if name ~= "" then
              vim.cmd("split | terminal dune init library " .. name)
            end
          end, "Dune Init Library")

          -- Format
          map("<leader>of", function()
            vim.cmd("split | terminal dune fmt")
          end, "Dune Format All")

          -- Merlin (if using merlin directly)
          map("<leader>om", function()
            vim.lsp.buf.hover()
          end, "Show Type")

          -- Code actions
          map("<leader>oa", function()
            vim.lsp.buf.code_action()
          end, "Code Actions")

          -- Type enclosing (select larger type)
          map("<leader>oE", function()
            vim.lsp.buf.signature_help()
          end, "Signature Help")

          -- Promote to interface
          map("<leader>oq", function()
            -- Generate .mli from .ml
            local file = vim.fn.expand("%")
            if file:match("%.ml$") then
              vim.cmd("split | terminal ocamlc -i " .. file .. " > " .. file .. "i")
            end
          end, "Generate .mli")
        end,
      })
    end,
  },
}
