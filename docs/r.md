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

## Keybindings

### Start/Stop

| Key | Action |
|-----|--------|
| `<leader>rs` | Start R |
| `<leader>rq` | Stop R |
| `<leader>rQ` | Kill R |

### Send Code

| Key | Action |
|-----|--------|
| `<Enter>` | Send Line (normal) |
| `<Enter>` | Send Selection (visual) |
| `<leader>rl` | Send Line |
| `<leader>rp` | Send Paragraph |
| `<leader>rf` | Send File |
| `<leader>rb` | Send Above Lines |
| `<leader>rc` | Send Chunk (Rmd) |

### Object Browser

| Key | Action |
|-----|--------|
| `<leader>ro` | Object Browser |
| `<leader>rO` | Clear Objects |

### Help & Docs

| Key | Action |
|-----|--------|
| `<leader>rh` | Help (word) |
| `<leader>rH` | Help (input) |
| `<leader>re` | Show Example |
| `<leader>ra` | Show Arguments |

### Data

| Key | Action |
|-----|--------|
| `<leader>rv` | View Data Frame |
| `<leader>rV` | Dput Object |

### Packages

| Key | Action |
|-----|--------|
| `<leader>ri` | Install Package |
| `<leader>rL` | Load Library |

### Working Directory

| Key | Action |
|-----|--------|
| `<leader>rw` | Set Working Dir |
| `<leader>rW` | Get Working Dir |

### Rmarkdown

| Key | Action |
|-----|--------|
| `<leader>rk` | Knit Document |
| `<leader>rK` | Make All (PDF) |
| `<leader>rm` | Make PDF |

### Plots

| Key | Action |
|-----|--------|
| `<leader>rpd` | Close Plot Device |
| `<leader>rps` | Save Plot |

### Debugging

| Key | Action |
|-----|--------|
| `<leader>rdd` | Debug Function |
| `<leader>rdu` | Undebug Function |
| `<leader>rdt` | Traceback |

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
1. `<leader>rs` - Start R
2. Write code
3. `<Enter>` - Send lines to R
4. `<leader>rv` - View data frames

### Rmarkdown
1. Open .Rmd file
2. `<leader>rc` - Run chunks
3. `<leader>rk` - Knit to output
