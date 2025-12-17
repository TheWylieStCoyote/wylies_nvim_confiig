# LaTeX Development

> LSP: texlab | Formatter: latexindent | Compiler: latexmk | Viewer: zathura

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | texlab |
| Formatter | latexindent |
| Linter | chktex |
| Compiler | latexmk |
| PDF Viewer | zathura (configurable) |
| Plugin | VimTeX |
| TreeSitter | latex, bibtex |

## Features

- texlab language server
- VimTeX integration
- Continuous compilation
- Forward/inverse search
- PDF viewer sync (SyncTeX)
- BibTeX/Biber support
- Document templates
- Word/letter count

## Keybindings

### Compilation (`<leader>L...`)

| Key | Action |
|-----|--------|
| `<leader>Lb` | Compile (continuous) |
| `<leader>LB` | Compile (single shot) |
| `<leader>Lc` | Clean Aux Files |
| `<leader>LC` | Clean All Output |
| `<leader>Ls` | Stop Compilation |
| `<leader>LS` | Stop All |

### Viewing

| Key | Action |
|-----|--------|
| `<leader>Lv` | View PDF |
| `<leader>Lf` | Forward Search |

### Info & Logs

| Key | Action |
|-----|--------|
| `<leader>Li` | Info |
| `<leader>LI` | Full Info |
| `<leader>Ll` | View Log |
| `<leader>Le` | Show Errors |

### Table of Contents

| Key | Action |
|-----|--------|
| `<leader>Lt` | Toggle TOC |
| `<leader>LT` | Open TOC |

### Word Count

| Key | Action |
|-----|--------|
| `<leader>Lw` | Word Count |
| `<leader>LW` | Letter Count |

### latexmk Direct

| Key | Action |
|-----|--------|
| `<leader>Lm` | latexmk (PDF) |
| `<leader>LM` | latexmk (XeLaTeX) |
| `<leader>Lp` | latexmk (LuaLaTeX) |

### BibTeX

| Key | Action |
|-----|--------|
| `<leader>Lbb` | BibTeX |
| `<leader>Lbr` | Biber |

### Texlab

| Key | Action |
|-----|--------|
| `<leader>Lxb` | Texlab Build |
| `<leader>Lxf` | Texlab Forward |

### Templates

| Key | Action |
|-----|--------|
| `<leader>Ln` | Insert Article Template |
| `<leader>LN` | Insert Beamer Template |

### LSP

| Key | Action |
|-----|--------|
| `<leader>La` | Context Menu |
| `<leader>Lh` | Hover Info |
| `<leader>LAa` | Code Actions |

## Installation

### Mason Packages
```vim
:MasonInstall texlab latexindent
```

### System Requirements

```bash
# Arch - Full TeX Live
sudo pacman -S texlive-most texlive-lang

# Or minimal install
sudo pacman -S texlive-core texlive-latexextra

# PDF viewers
sudo pacman -S zathura zathura-pdf-mupdf
# or
sudo pacman -S okular
# or
sudo pacman -S evince

# BibTeX tools
sudo pacman -S biber
```

## Configuration

### texlab Settings

```lua
texlab = {
  build = {
    executable = "latexmk",
    args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "-outdir=build", "%f" },
    onSave = false,
    forwardSearchAfter = true,
  },
  forwardSearch = {
    executable = "zathura",
    args = { "--synctex-forward", "%l:1:%f", "%p" },
  },
  chktex = {
    onOpenAndSave = true,
  },
  latexFormatter = "latexindent",
}
```

### VimTeX Settings

- View method: zathura (configurable)
- Compiler: latexmk (continuous)
- Build directory: `build/`
- Folding enabled
- Syntax highlighting enabled

### .latexmkrc

```perl
$pdf_mode = 1;
$out_dir = 'build';
$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 %O %S';
$bibtex_use = 2;
$clean_ext = 'bbl nav snm';
```

## Article Template

Generated with `<leader>Ln`:
```latex
\documentclass[11pt,a4paper]{article}

\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{amsmath,amssymb,amsthm}
\usepackage{graphicx}
\usepackage{hyperref}
\usepackage{geometry}
\usepackage{booktabs}

\geometry{margin=1in}

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

\bibliographystyle{plain}
\bibliography{references}

\end{document}
```

## Beamer Template

Generated with `<leader>LN`:
```latex
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
  \end{itemize}
\end{frame}

\end{document}
```

## Usage Examples

### Document Writing
1. `<leader>Ln` - Insert article template
2. Write content
3. `<leader>Lb` - Start continuous compilation
4. `<leader>Lv` - View PDF

### Forward/Inverse Search
1. Position cursor in source
2. `<leader>Lf` - Jump to PDF location
3. Ctrl-click in PDF - Jump to source

### Bibliography
1. Create `references.bib`
2. `<leader>Lbb` - Run BibTeX
3. Recompile document

### Presentations
1. `<leader>LN` - Insert beamer template
2. Write slides
3. `<leader>Lb` - Compile
