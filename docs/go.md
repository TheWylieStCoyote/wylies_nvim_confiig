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
| `<leader>gr` | Go Run |
| `<leader>gR` | Go Run File |
| `<leader>gt` | Go Test |
| `<leader>gT` | Go Test File |
| `<leader>gtt` | Go Test Function |
| `<leader>gc` | Go Coverage |
| `<leader>gC` | Go Coverage Toggle |
| `<leader>gi` | Implement Interface |
| `<leader>gf` | Fill Struct |
| `<leader>ga` | Add Tags |
| `<leader>gA` | Remove Tags |
| `<leader>gm` | Go Mod Tidy |
| `<leader>gM` | Go Mod Init |
| `<leader>gd` | Go Debug |
| `<leader>gD` | Go Debug Test |
| `<leader>gb` | Toggle Breakpoint |
| `<leader>ge` | Go If Err |
| `<leader>gw` | Fill Switch |
| `<leader>gl` | Go Lint |
| `<leader>gv` | Go Vet |
| `<leader>gp` | Fix Plurals |

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
2. `<leader>ge` - Add error handling
3. `<leader>gf` - Fill struct fields
4. `<leader>gl` - Lint
5. `<leader>gt` - Test

### Interface Implementation
1. Create struct
2. `<leader>gi` - Implement interface
3. Enter interface name
4. Methods are generated

### Tag Management
1. Place cursor on struct
2. `<leader>ga` - Add tags (json, xml, etc.)
3. `<leader>gA` - Remove tags

### Testing with Coverage
1. `<leader>gc` - Run with coverage
2. Coverage shown inline
3. `<leader>gC` - Toggle coverage display

### Debug Session
1. `<leader>gd` - Start debug
2. Or `<leader>gD` - Debug test
3. `<F9>` - Set breakpoints
4. `<F5>` - Continue
