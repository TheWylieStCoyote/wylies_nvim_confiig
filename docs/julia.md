# Julia Development

> LSP: julials | Formatter: JuliaFormatter

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | julials (LanguageServer.jl) |
| Formatter | JuliaFormatter.jl |
| TreeSitter | julia |

## Features

- Full Julia language server
- Lint diagnostics
- Format support
- Package management integration
- Revise.jl support
- Benchmarking tools

## Keybindings

### Run & REPL

| Key | Action |
|-----|--------|
| `<leader>jr` | Run File |
| `<leader>ji` | Julia REPL |
| `<leader>jI` | Julia REPL (project) |
| `<leader>jl` | Run Line |
| `<leader>js` | Run Selection (visual) |

### Packages

| Key | Action |
|-----|--------|
| `<leader>jp` | Package Status |
| `<leader>jP` | Add Package |
| `<leader>ju` | Update Packages |
| `<leader>jU` | Remove Package |
| `<leader>jb` | Build Packages |

### Project

| Key | Action |
|-----|--------|
| `<leader>jn` | New Project |
| `<leader>ja` | Activate Project |
| `<leader>jA` | Instantiate Project |

### Testing

| Key | Action |
|-----|--------|
| `<leader>jt` | Run Tests |
| `<leader>jT` | Run Test File |

### Documentation

| Key | Action |
|-----|--------|
| `<leader>jd` | Documentation |
| `<leader>jD` | Show Methods |
| `<leader>jw` | Which Method |

### Profiling

| Key | Action |
|-----|--------|
| `<leader>jB` | Benchmark |
| `<leader>jf` | Profile File |
| `<leader>jR` | Revise Include |

### Compilation

| Key | Action |
|-----|--------|
| `<leader>jc` | Create Sysimage |
| `<leader>jC` | Create App |

### Type Inspection

| Key | Action |
|-----|--------|
| `<leader>jy` | Type Of |
| `<leader>jY` | Code Warntype |

### LSP

| Key | Action |
|-----|--------|
| `<leader>jh` | Hover Info |
| `<leader>jaa` | Code Actions |

## Installation

### Mason Packages
```vim
:MasonInstall julia-lsp
```

### System Requirements

**Julia:**
```bash
# Arch
sudo pacman -S julia

# Install LSP packages
julia -e 'using Pkg; Pkg.add(["LanguageServer", "SymbolServer", "StaticLint", "JuliaFormatter"])'
```

## Configuration

### Lint Settings

Enabled checks:
- Missing refs
- Iteration patterns
- Lazy evaluation
- Module names
- Function calls
- Type parameters

## Usage Examples

### Quick Development
1. `<leader>ji` - Start REPL
2. Write code
3. `<leader>jr` - Run file

### Package Development
1. `<leader>jn` - Create package
2. `<leader>ja` - Activate
3. `<leader>jR` - Use Revise for hot reloading

### Performance
1. `<leader>jY` - Check type stability
2. `<leader>jB` - Benchmark function
