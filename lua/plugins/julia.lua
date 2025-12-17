-- Julia Development Configuration
-- LSP (julia-lsp), formatting, and REPL support

return {
  -- TreeSitter parsers for Julia
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "julia",
      })
    end,
  },

  -- Mason: ensure Julia tools are installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "julia-lsp",
      })
    end,
  },

  -- Julia language server configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        julials = {
          cmd = {
            "julia",
            "--startup-file=no",
            "--history-file=no",
            "-e",
            [[
              using LanguageServer
              using SymbolServer
              using StaticLint
              env_path = dirname(dirname(Sys.BINDIR))
              server = LanguageServer.LanguageServerInstance(stdin, stdout, env_path)
              server.runlinter = true
              run(server)
            ]],
          },
          filetypes = { "julia" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.root_pattern(
              "Project.toml",
              "JuliaProject.toml",
              ".git"
            )(fname) or vim.fn.getcwd()
          end,
          settings = {
            julia = {
              lint = {
                missingrefs = "all",
                iter = true,
                lazy = true,
                modname = true,
                call = true,
                constif = true,
                datadecl = true,
                nothingcomp = true,
                pirates = true,
                typeparam = true,
                usealiases = true,
              },
              format = {
                indent = 4,
                indents = true,
                ops = true,
                tuples = true,
                curly = true,
                calls = true,
                iterOps = true,
                comments = true,
                docs = true,
                kw = true,
              },
            },
          },
          single_file_support = true,
        },
      },
    },
  },

  -- Code formatting with JuliaFormatter
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        julia = { "julia_formatter" },
      },
      formatters = {
        julia_formatter = {
          command = "julia",
          args = {
            "-e",
            [[
              using JuliaFormatter
              print(format_text(read(stdin, String)))
            ]],
          },
          stdin = true,
        },
      },
    },
  },

  -- Julia-specific keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "julia" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "Julia: " .. desc })
          end
          local vmap = function(keys, func, desc)
            vim.keymap.set("v", keys, func, { buffer = event.buf, desc = "Julia: " .. desc })
          end

          -- Run Julia
          map("<leader>jr", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal julia " .. file)
          end, "Run File")

          map("<leader>ji", function()
            vim.cmd("split | terminal julia")
          end, "Julia REPL")

          map("<leader>jI", function()
            vim.cmd("split | terminal julia --project")
          end, "Julia REPL (project)")

          -- Send to REPL (using terminal)
          map("<leader>jl", function()
            local line = vim.api.nvim_get_current_line()
            vim.cmd("split | terminal julia -e '" .. line:gsub("'", "'\\''") .. "'")
          end, "Run Line")

          vmap("<leader>js", function()
            local lines = vim.fn.getline("'<", "'>")
            local code = table.concat(lines, "\n")
            local tmpfile = os.tmpname() .. ".jl"
            local f = io.open(tmpfile, "w")
            if f then
              f:write(code)
              f:close()
              vim.cmd("split | terminal julia " .. tmpfile)
            end
          end, "Run Selection")

          -- Package management
          map("<leader>jp", function()
            vim.cmd("split | terminal julia -e 'using Pkg; Pkg.status()'")
          end, "Package Status")

          map("<leader>jP", function()
            local pkg = vim.fn.input("Package: ")
            if pkg ~= "" then
              vim.cmd("split | terminal julia -e 'using Pkg; Pkg.add(\"" .. pkg .. "\")'")
            end
          end, "Add Package")

          map("<leader>ju", function()
            vim.cmd("split | terminal julia -e 'using Pkg; Pkg.update()'")
          end, "Update Packages")

          map("<leader>jU", function()
            local pkg = vim.fn.input("Package: ")
            if pkg ~= "" then
              vim.cmd("split | terminal julia -e 'using Pkg; Pkg.rm(\"" .. pkg .. "\")'")
            end
          end, "Remove Package")

          map("<leader>jb", function()
            vim.cmd("split | terminal julia -e 'using Pkg; Pkg.build()'")
          end, "Build Packages")

          -- Project
          map("<leader>jn", function()
            local name = vim.fn.input("Project name: ")
            if name ~= "" then
              vim.cmd("split | terminal julia -e 'using Pkg; Pkg.generate(\"" .. name .. "\")'")
            end
          end, "New Project")

          map("<leader>ja", function()
            vim.cmd("split | terminal julia -e 'using Pkg; Pkg.activate(\".\")'")
          end, "Activate Project")

          map("<leader>jA", function()
            vim.cmd("split | terminal julia -e 'using Pkg; Pkg.instantiate()'")
          end, "Instantiate Project")

          -- Testing
          map("<leader>jt", function()
            vim.cmd("split | terminal julia -e 'using Pkg; Pkg.test()'")
          end, "Run Tests")

          map("<leader>jT", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal julia " .. file)
          end, "Run Test File")

          -- Documentation
          map("<leader>jd", function()
            local word = vim.fn.expand("<cword>")
            vim.cmd("split | terminal julia -e '@doc " .. word .. "'")
          end, "Documentation")

          map("<leader>jD", function()
            local word = vim.fn.expand("<cword>")
            vim.cmd("split | terminal julia -e 'methods(" .. word .. ")'")
          end, "Show Methods")

          map("<leader>jw", function()
            local word = vim.fn.expand("<cword>")
            vim.cmd("split | terminal julia -e '@which " .. word .. "'")
          end, "Which Method")

          -- Benchmarking
          map("<leader>jB", function()
            local word = vim.fn.expand("<cword>")
            vim.cmd("split | terminal julia -e 'using BenchmarkTools; @benchmark " .. word .. "()'")
          end, "Benchmark")

          -- Profiling
          map("<leader>jf", function()
            vim.cmd("split | terminal julia -e 'using Profile; @profile include(\"" .. vim.fn.expand("%") .. "\")'")
          end, "Profile File")

          -- Revise (hot reloading)
          map("<leader>jR", function()
            vim.cmd("split | terminal julia -e 'using Revise; includet(\"" .. vim.fn.expand("%") .. "\")'")
          end, "Revise Include")

          -- Plotting
          map("<leader>jpp", function()
            vim.cmd("split | terminal julia -e 'using Plots; include(\"" .. vim.fn.expand("%") .. "\"); gui()'")
          end, "Run with Plots")

          -- Compilation
          map("<leader>jc", function()
            vim.cmd("split | terminal julia -e 'using PackageCompiler; create_sysimage()'")
          end, "Create Sysimage")

          map("<leader>jC", function()
            local name = vim.fn.input("App name: ")
            if name ~= "" then
              vim.cmd("split | terminal julia -e 'using PackageCompiler; create_app(\".\", \"" .. name .. "\")'")
            end
          end, "Create App")

          -- Code actions
          map("<leader>jh", function()
            vim.lsp.buf.hover()
          end, "Hover Info")

          map("<leader>jaa", function()
            vim.lsp.buf.code_action()
          end, "Code Actions")

          -- Type inspection
          map("<leader>jy", function()
            local word = vim.fn.expand("<cword>")
            vim.cmd("split | terminal julia -e 'typeof(" .. word .. ")'")
          end, "Type Of")

          map("<leader>jY", function()
            local word = vim.fn.expand("<cword>")
            vim.cmd("split | terminal julia -e '@code_warntype " .. word .. "()'")
          end, "Code Warntype")
        end,
      })
    end,
  },
}
