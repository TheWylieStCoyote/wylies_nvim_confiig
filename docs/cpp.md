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
| `<leader>cU` | Memory Usage |
| `<leader>ca` | View AST |

### Compile & Run

| Key | Action |
|-----|--------|
| `<leader>cc` | Compile File |
| `<leader>cx` | Run Compiled |
| `<leader>cM` | Make |
| `<leader>cmc` | Make Clean |

### CMake (cmake-tools.nvim)

| Key | Action |
|-----|--------|
| `<leader>cmg` | CMake Generate |
| `<leader>cmb` | CMake Build |
| `<leader>cmr` | CMake Run |
| `<leader>cmd` | CMake Debug |
| `<leader>cms` | Select Build Type |
| `<leader>cmq` | CMake Close |
| `<leader>cmC` | CMake Clean |
| `<leader>cmt` | CMake Select Target |
| `<leader>cmT` | CMake Select Launch Target |
| `<leader>cmS` | CMake Settings |

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
2. `<leader>cmg` - Generate CMake
3. `<leader>cmb` - Build
4. `<leader>cmr` - Run

### Debug Session
1. `<leader>cmd` - Start CMake Debug
2. `<F9>` - Set breakpoints
3. `<F5>` - Start debugging
4. `<F10>` / `<F11>` - Step through code
