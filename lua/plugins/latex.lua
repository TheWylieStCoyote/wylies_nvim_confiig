-- LaTeX Development Configuration
-- LSP (texlab), compilation (latexmk), and PDF viewing

return {
  -- TreeSitter parsers for LaTeX
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "latex",
        "bibtex",
      })
    end,
  },

  -- Mason: ensure LaTeX tools are installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "texlab",
        "latexindent",
      })
    end,
  },

  -- texlab LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        texlab = {
          cmd = { "texlab" },
          filetypes = { "tex", "plaintex", "bib" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.root_pattern(
              ".latexmkrc",
              ".texlabroot",
              "texlabroot",
              "Tectonic.toml",
              ".git",
              "*.tex"
            )(fname) or vim.fn.getcwd()
          end,
          settings = {
            texlab = {
              build = {
                executable = "latexmk",
                args = {
                  "-pdf",
                  "-interaction=nonstopmode",
                  "-synctex=1",
                  "-outdir=build",
                  "%f",
                },
                onSave = false,
                forwardSearchAfter = true,
              },
              forwardSearch = {
                -- Configure for your PDF viewer
                -- Zathura
                executable = "zathura",
                args = { "--synctex-forward", "%l:1:%f", "%p" },
                -- Okular
                -- executable = "okular",
                -- args = { "--unique", "file:%p#src:%l%f" },
                -- Evince
                -- executable = "evince-synctex",
                -- args = { "-f", "%l", "%p", "\"code -g %f:%l\"" },
              },
              chktex = {
                onOpenAndSave = true,
                onEdit = false,
              },
              diagnosticsDelay = 300,
              latexFormatter = "latexindent",
              latexindent = {
                modifyLineBreaks = true,
              },
              bibtexFormatter = "texlab",
              formatterLineLength = 80,
            },
          },
        },
      },
    },
  },

  -- Code formatting with latexindent
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        tex = { "latexindent" },
        bib = { "bibtex-tidy" },
      },
      formatters = {
        latexindent = {
          command = "latexindent",
          args = { "-m", "-" },
          stdin = true,
        },
      },
    },
  },

  -- Linting with chktex
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        tex = { "chktex" },
      },
    },
  },

  -- VimTeX for enhanced LaTeX support
  {
    "lervag/vimtex",
    ft = { "tex", "plaintex", "bib" },
    init = function()
      -- VimTeX configuration
      vim.g.vimtex_view_method = "zathura"
      -- vim.g.vimtex_view_method = "okular"
      -- vim.g.vimtex_view_method = "evince"

      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        build_dir = "build",
        callback = 1,
        continuous = 1,
        executable = "latexmk",
        options = {
          "-pdf",
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }

      -- Don't open quickfix on warnings
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_quickfix_open_on_warning = 0

      -- TOC settings
      vim.g.vimtex_toc_config = {
        split_width = 40,
        show_help = 0,
      }

      -- Disable insert mode mappings
      vim.g.vimtex_imaps_enabled = 0

      -- Folding
      vim.g.vimtex_fold_enabled = 1

      -- Syntax highlighting
      vim.g.vimtex_syntax_enabled = 1
      vim.g.vimtex_syntax_conceal_disable = 0
    end,
  },

  -- LaTeX-specific keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "tex", "plaintex", "bib" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LaTeX: " .. desc })
          end

          -- Compilation (VimTeX)
          map("<leader>Lb", function()
            vim.cmd("VimtexCompile")
          end, "Compile (continuous)")

          map("<leader>LB", function()
            vim.cmd("VimtexCompileSS")
          end, "Compile (single shot)")

          map("<leader>Lc", function()
            vim.cmd("VimtexClean")
          end, "Clean Aux Files")

          map("<leader>LC", function()
            vim.cmd("VimtexClean!")
          end, "Clean All Output")

          map("<leader>Ls", function()
            vim.cmd("VimtexStop")
          end, "Stop Compilation")

          map("<leader>LS", function()
            vim.cmd("VimtexStopAll")
          end, "Stop All")

          -- Viewing
          map("<leader>Lv", function()
            vim.cmd("VimtexView")
          end, "View PDF")

          map("<leader>Lf", function()
            vim.cmd("VimtexForward")
          end, "Forward Search")

          -- Info and logs
          map("<leader>Li", function()
            vim.cmd("VimtexInfo")
          end, "Info")

          map("<leader>LI", function()
            vim.cmd("VimtexInfo!")
          end, "Full Info")

          map("<leader>Ll", function()
            vim.cmd("VimtexLog")
          end, "View Log")

          map("<leader>Le", function()
            vim.cmd("VimtexErrors")
          end, "Show Errors")

          -- Table of contents
          map("<leader>Lt", function()
            vim.cmd("VimtexTocToggle")
          end, "Toggle TOC")

          map("<leader>LT", function()
            vim.cmd("VimtexTocOpen")
          end, "Open TOC")

          -- Word count
          map("<leader>Lw", function()
            vim.cmd("VimtexCountWords")
          end, "Word Count")

          map("<leader>LW", function()
            vim.cmd("VimtexCountLetters")
          end, "Letter Count")

          -- Environment/Command handling
          map("<leader>La", function()
            vim.cmd("VimtexContextMenu")
          end, "Context Menu")

          -- texlab build (alternative to VimTeX)
          map("<leader>Lxb", function()
            vim.cmd("TexlabBuild")
          end, "Texlab Build")

          map("<leader>Lxf", function()
            vim.cmd("TexlabForward")
          end, "Texlab Forward")

          -- Direct latexmk commands
          map("<leader>Lm", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal latexmk -pdf -outdir=build " .. file)
          end, "latexmk (PDF)")

          map("<leader>LM", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal latexmk -xelatex -outdir=build " .. file)
          end, "latexmk (XeLaTeX)")

          map("<leader>Lp", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal latexmk -pdflatex=lualatex -pdf -outdir=build " .. file)
          end, "latexmk (LuaLaTeX)")

          -- BibTeX
          map("<leader>Lbb", function()
            vim.cmd("split | terminal bibtex build/" .. vim.fn.expand("%:r"))
          end, "BibTeX")

          map("<leader>Lbr", function()
            vim.cmd("split | terminal biber build/" .. vim.fn.expand("%:r"))
          end, "Biber")

          -- Document templates
          map("<leader>Ln", function()
            local template = [[
\documentclass[11pt,a4paper]{article}

% Packages
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{amsmath,amssymb,amsthm}
\usepackage{graphicx}
\usepackage{hyperref}
\usepackage{geometry}
\usepackage{booktabs}

% Page geometry
\geometry{margin=1in}

% Metadata
\title{Document Title}
\author{Author Name}
\date{\today}

\begin{document}

\maketitle

\begin{abstract}
Your abstract here.
\end{abstract}

\tableofcontents

\section{Introduction}

Your content here.

\section{Methods}

\section{Results}

\section{Conclusion}

\bibliographystyle{plain}
\bibliography{references}

\end{document}
]]
            local lines = vim.split(template, "\n")
            vim.api.nvim_buf_set_lines(event.buf, 0, -1, false, lines)
            vim.notify("Inserted article template", vim.log.levels.INFO)
          end, "Insert Article Template")

          map("<leader>LN", function()
            local template = [[
\documentclass{beamer}

\usetheme{Madrid}
\usecolortheme{default}

\title{Presentation Title}
\author{Author Name}
\institute{Institution}
\date{\today}

\begin{document}

\begin{frame}
  \titlepage
\end{frame}

\begin{frame}{Outline}
  \tableofcontents
\end{frame}

\section{Introduction}

\begin{frame}{Introduction}
  \begin{itemize}
    \item First point
    \item Second point
    \item Third point
  \end{itemize}
\end{frame}

\section{Main Content}

\begin{frame}{Main Content}
  Your content here.
\end{frame}

\section{Conclusion}

\begin{frame}{Conclusion}
  \begin{itemize}
    \item Summary point 1
    \item Summary point 2
  \end{itemize}
\end{frame}

\begin{frame}
  \centering
  \Large Thank you!
\end{frame}

\end{document}
]]
            local lines = vim.split(template, "\n")
            vim.api.nvim_buf_set_lines(event.buf, 0, -1, false, lines)
            vim.notify("Inserted beamer template", vim.log.levels.INFO)
          end, "Insert Beamer Template")

          -- Code actions
          map("<leader>Lh", function()
            vim.lsp.buf.hover()
          end, "Hover Info")

          map("<leader>LAa", function()
            vim.lsp.buf.code_action()
          end, "Code Actions")
        end,
      })
    end,
  },
}
