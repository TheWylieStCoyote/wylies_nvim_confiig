# Zig Development

> LSP: zls | Formatter: zig fmt | Debugger: codelldb

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | zls (Zig Language Server) |
| Formatter | zig fmt |
| Debugger | codelldb |
| TreeSitter | zig |

## Features

- Full ZLS integration
- Snippets and argument placeholders
- AST check diagnostics
- Autofix suggestions
- Import/embedFile completions
- Style warnings
- Semantic tokens
- Inlay hints (parameter names, types, builtins)
- Operator completions

## Keybindings

### Zig-Specific

| Key | Action |
|-----|--------|
| `<leader>zb` | Build |
| `<leader>zB` | Build (Release) |
| `<leader>zr` | Build & Run |
| `<leader>zt` | Build & Test |
| `<leader>zR` | Run File |
| `<leader>zT` | Test File |
| `<leader>zf` | Fetch Dependencies |
| `<leader>zF` | Format File |
| `<leader>zc` | AST Check |
| `<leader>zo` | Open build.zig |

### Debugging (DAP)

| Key | Action |
|-----|--------|
| `<F5>` | Start/Continue |
| `<F9>` | Toggle Breakpoint |
| `<F10>` | Step Over |
| `<F11>` | Step Into |
| `<S-F11>` | Step Out |

## Installation

### Mason Packages
```vim
:MasonInstall zls codelldb
```

### System Requirements

**Install Zig:**
```bash
# Arch
sudo pacman -S zig

# Or download from ziglang.org
```

## Configuration

### ZLS Settings

Enabled features:
- Snippets
- Argument placeholders
- AST check diagnostics
- Autofix
- Import completions
- Style warnings
- Semantic tokens
- Inlay hints

### build.zig

Standard Zig project structure:
```
project/
├── build.zig
├── build.zig.zon
└── src/
    └── main.zig
```

## Usage Examples

### Quick Build & Run
1. `<leader>zb` - Build project
2. `<leader>zr` - Build and run

### Release Build
1. `<leader>zB` - Build with ReleaseFast

### Testing
1. Write tests in your Zig file
2. `<leader>zt` - Build and run tests
3. Or `<leader>zT` - Test current file only

### Debug Session
1. Build with debug info: `zig build`
2. `<F9>` - Set breakpoints
3. `<F5>` - Start debugging
4. Executable found in `zig-out/bin/`

### Single File Development
1. Create `.zig` file
2. `<leader>zR` - Run file directly
3. `<leader>zT` - Test file directly

### Check Syntax
1. `<leader>zc` - Run AST check on current file
2. View diagnostics in quickfix
