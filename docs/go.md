# Go Development

> LSP: gopls | Formatter: goimports | Linter: golangci-lint | Debugger: delve

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | gopls |
| Formatter | goimports, gofmt |
| Linter | golangci-lint |
| Debugger | delve (dlv) |
| TreeSitter | go, gomod, gosum, gowork |

## Features

- Full gopls integration
- gofumpt formatting
- Code lenses (generate, test, tidy)
- Inlay hints
- Static analysis
- Struct tag management
- Interface implementation
- Test generation and running
- Coverage visualization

## Keybindings

### Go-Specific (go.nvim)

| Key | Action |
|-----|--------|
| `<leader>Gr` | Go Run |
| `<leader>GR` | Go Run File |
| `<leader>Gt` | Go Test |
| `<leader>GT` | Go Test File |
| `<leader>Gtt` | Go Test Function |
| `<leader>Gc` | Go Coverage |
| `<leader>GC` | Go Coverage Toggle |
| `<leader>Gi` | Implement Interface |
| `<leader>Gf` | Fill Struct |
| `<leader>Ga` | Add Tags |
| `<leader>GA` | Remove Tags |
| `<leader>Gm` | Go Mod Tidy |
| `<leader>GM` | Go Mod Init |
| `<leader>GD` | Go Debug |
| `<leader>Gd` | Go Debug Test |
| `<leader>Gb` | Toggle Breakpoint |
| `<leader>Ge` | Go If Err |
| `<leader>Gw` | Fill Switch |
| `<leader>Gl` | Go Lint |
| `<leader>Gv` | Go Vet |
| `<leader>Gp` | Fix Plurals |

### Debugging (DAP)

| Key | Action |
|-----|--------|
| `<F5>` | Start/Continue |
| `<F9>` | Toggle Breakpoint |
| `<F10>` | Step Over |
| `<F11>` | Step Into |
| `<S-F11>` | Step Out |
| `<leader>dgt` | Debug Go Test |
| `<leader>dgl` | Debug Last Go Test |

## Installation

### Mason Packages
```vim
:MasonInstall gopls goimports golangci-lint delve
```

### System Requirements

**Install Go:**
```bash
# Arch
sudo pacman -S go

# Or download from golang.org
```

**Go tools (installed automatically by go.nvim):**
```bash
:GoInstallBinaries
```

## Configuration

### gopls Settings

Enabled features:
- gofumpt formatting
- Code lenses (generate, test, tidy, vendor)
- Inlay hints (types, parameters, composite literals)
- Static analysis (fieldalignment, nilness, unusedparams)
- Semantic tokens

### golangci-lint

Create `.golangci.yml` in project root:
```yaml
linters:
  enable:
    - gofmt
    - golint
    - govet
    - errcheck
    - staticcheck
```

## Usage Examples

### Quick Development Cycle
1. Write code
2. `<leader>Ge` - Add error handling
3. `<leader>Gf` - Fill struct fields
4. `<leader>Gl` - Lint
5. `<leader>Gt` - Test

### Interface Implementation
1. Create struct
2. `<leader>Gi` - Implement interface
3. Enter interface name
4. Methods are generated

### Tag Management
1. Place cursor on struct
2. `<leader>Ga` - Add tags (json, xml, etc.)
3. `<leader>GA` - Remove tags

### Testing with Coverage
1. `<leader>Gc` - Run with coverage
2. Coverage shown inline
3. `<leader>GC` - Toggle coverage display

### Debug Session
1. `<leader>GD` - Start debug
2. Or `<leader>Gd` - Debug test
3. `<F9>` - Set breakpoints
4. `<F5>` - Continue
