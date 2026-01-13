# R Development

> LSP: r-languageserver | Formatter: styler | Linter: lintr

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | r-languageserver |
| Formatter | styler |
| Linter | lintr |
| TreeSitter | r, rnoweb, rmd |

## Features

- Full R language server integration
- R.nvim for enhanced REPL support
- Object browser
- Data frame viewing
- Rmarkdown/Quarto support
- cmp-r completions

## Keybindings (`<leader>R...`)

### Start/Stop

| Key | Action |
|-----|--------|
| `<leader>Rs` | Start R |
| `<leader>Rq` | Stop R |
| `<leader>RQ` | Kill R |

### Send Code

| Key | Action |
|-----|--------|
| `<Enter>` | Send Line (normal) |
| `<Enter>` | Send Selection (visual) |
| `<leader>Rl` | Send Line |
| `<leader>Rp` | Send Paragraph |
| `<leader>Rf` | Send File |
| `<leader>Rb` | Send Above Lines |
| `<leader>Rc` | Send Chunk (Rmd) |

### Object Browser

| Key | Action |
|-----|--------|
| `<leader>Ro` | Object Browser |
| `<leader>RO` | Clear Objects |

### Help & Docs

| Key | Action |
|-----|--------|
| `<leader>Rh` | Help (word) |
| `<leader>RH` | Help (input) |
| `<leader>Re` | Show Example |
| `<leader>Ra` | Show Arguments |

### Data

| Key | Action |
|-----|--------|
| `<leader>Rv` | View Data Frame |
| `<leader>RV` | Dput Object |

### Packages

| Key | Action |
|-----|--------|
| `<leader>Ri` | Install Package |
| `<leader>RL` | Load Library |

### Working Directory

| Key | Action |
|-----|--------|
| `<leader>Rw` | Set Working Dir |
| `<leader>RW` | Get Working Dir |

### Rmarkdown

| Key | Action |
|-----|--------|
| `<leader>Rk` | Knit Document |
| `<leader>RK` | Make All (PDF) |
| `<leader>Rm` | Make PDF |

### Plots

| Key | Action |
|-----|--------|
| `<leader>Rpd` | Close Plot Device |
| `<leader>Rps` | Save Plot |

### Debugging

| Key | Action |
|-----|--------|
| `<leader>Rdd` | Debug Function |
| `<leader>Rdu` | Undebug Function |
| `<leader>Rdt` | Traceback |

## Installation

### Mason Packages
```vim
:MasonInstall r-languageserver
```

### System Requirements

**R:**
```bash
# Arch
sudo pacman -S r

# Install R packages
R -e "install.packages(c('languageserver', 'styler', 'lintr'))"
```

## Configuration

### R.nvim Settings

- Native pipe (`|>`) by default
- Assignment: `Alt+-`
- Pipe: `Alt+m`

## Usage Examples

### Interactive Analysis
1. `<leader>Rs` - Start R
2. Write code
3. `<Enter>` - Send lines to R
4. `<leader>Rv` - View data frames

### Rmarkdown
1. Open .Rmd file
2. `<leader>Rc` - Run chunks
3. `<leader>Rk` - Knit to output
