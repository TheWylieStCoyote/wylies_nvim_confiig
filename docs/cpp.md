# C/C++ Development

> LSP: clangd | Formatter: clang-format | Linter: clang-tidy | Debugger: codelldb

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | clangd |
| Formatter | clang-format |
| Linter | clang-tidy (via clangd) |
| Debugger | codelldb |
| TreeSitter | c, cpp, cmake, make, meson |

## Features

- Background indexing
- Clang-tidy integration
- Header insertion (IWYU)
- Detailed completions with placeholders
- Inlay hints
- AST visualization (via clangd_extensions)
- Type hierarchy
- Memory usage analysis
- Switch between source/header files

## Keybindings

### LSP & Navigation

| Key | Action |
|-----|--------|
| `<leader>ch` | Switch Source/Header |
| `<leader>ci` | Symbol Info |
| `<leader>ct` | Type Hierarchy |
| `<leader>cm` | Memory Usage |
| `<leader>ca` | View AST |

### CMake (cmake-tools.nvim)

| Key | Action |
|-----|--------|
| `<leader>cg` | CMake Generate |
| `<leader>cb` | CMake Build |
| `<leader>cr` | CMake Run |
| `<leader>cd` | CMake Debug |
| `<leader>cs` | Select Build Type |
| `<leader>cq` | CMake Close |

### Debugging (DAP)

| Key | Action |
|-----|--------|
| `<F5>` | Start/Continue |
| `<F9>` | Toggle Breakpoint |
| `<F10>` | Step Over |
| `<F11>` | Step Into |
| `<S-F11>` | Step Out |
| `<leader>db` | Toggle Breakpoint |
| `<leader>dB` | Conditional Breakpoint |
| `<leader>dr` | Open REPL |
| `<leader>dl` | Run Last |
| `<leader>du` | Toggle DAP UI |
| `<leader>de` | Evaluate Expression |

## Installation

### Mason Packages
```vim
:MasonInstall clangd clang-format codelldb
```

### System Requirements

**Arch Linux:**
```bash
sudo pacman -S clang cmake make meson
```

**Ubuntu/Debian:**
```bash
sudo apt install clangd clang-format cmake make
```

## Configuration

### compile_commands.json

For best results, generate `compile_commands.json`:

**CMake:**
```bash
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
```

**Bear (for Make):**
```bash
bear -- make
```

### .clang-format

Create a `.clang-format` file in your project root:
```yaml
BasedOnStyle: LLVM
IndentWidth: 4
ColumnLimit: 100
```

### .clang-tidy

Create a `.clang-tidy` file:
```yaml
Checks: '*,-fuchsia-*,-google-*,-llvm-*'
WarningsAsErrors: ''
```

## Usage Examples

### Quick Build & Run
1. Open a C++ file
2. `<leader>cg` - Generate CMake
3. `<leader>cb` - Build
4. `<leader>cr` - Run

### Debug Session
1. `<leader>cd` - Start CMake Debug
2. `<F9>` - Set breakpoints
3. `<F5>` - Start debugging
4. `<F10>` / `<F11>` - Step through code
