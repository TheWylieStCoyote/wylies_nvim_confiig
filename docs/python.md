# Python Development

> LSP: pyright + ruff | Formatter: ruff | Linter: ruff | Debugger: debugpy

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | pyright (types) + ruff (linting) |
| Formatter | ruff format |
| Linter | ruff |
| Debugger | debugpy |
| TreeSitter | python, toml, requirements |

## Features

- Type checking with pyright
- Fast linting and formatting with ruff
- Virtual environment selection
- pytest integration
- Debug test methods/classes
- Interactive REPL support

## Keybindings

### Python-Specific

| Key | Action |
|-----|--------|
| `<leader>pr` | Run File |
| `<leader>pi` | Run Interactive |
| `<leader>pp` | Python REPL |
| `<leader>pv` | Select VirtualEnv |
| `<leader>pV` | Select Cached VirtualEnv |
| `<leader>po` | Organize Imports (ruff) |

### Debugging (DAP)

| Key | Action |
|-----|--------|
| `<leader>pd` | Debug Selection (visual) |
| `<leader>pt` | Debug Test Method |
| `<leader>pT` | Debug Test Class |
| `<F5>` | Start/Continue |
| `<F9>` | Toggle Breakpoint |
| `<F10>` | Step Over |
| `<F11>` | Step Into |
| `<S-F11>` | Step Out |

## Installation

### Mason Packages
```vim
:MasonInstall pyright ruff debugpy
```

### System Requirements

**Python:**
```bash
# Arch
sudo pacman -S python python-pip

# Virtual environments
python -m venv .venv
source .venv/bin/activate
```

## Configuration

### pyright Settings

- Auto search paths
- Library code for types
- Open files only diagnostics
- Basic type checking mode

### ruff Settings

Ruff handles:
- Import organization
- Code formatting
- Linting (replaces flake8, isort, etc.)

### pyproject.toml

```toml
[tool.ruff]
line-length = 88
select = ["E", "F", "I", "N", "W"]

[tool.ruff.format]
quote-style = "double"

[tool.pyright]
typeCheckingMode = "basic"
```

## Virtual Environments

### Selection
1. `<leader>pv` - Open venv selector
2. Choose from detected environments
3. LSP automatically restarts with new venv

### Supported Locations
- `.venv/` in project
- `venv/` in project
- Poetry environments
- Conda environments
- pyenv environments

## Usage Examples

### Quick Development
1. Create virtual environment
2. `<leader>pv` - Select it
3. Write code
4. `<leader>pr` - Run file

### Test Debugging
1. Write pytest tests
2. Place cursor on test method
3. `<leader>pt` - Debug test method
4. Or `<leader>pT` - Debug entire test class

### Interactive Development
1. `<leader>pi` - Run file interactively
2. Drops into REPL after execution
3. Inspect variables

### Import Organization
1. `<leader>po` - Organize imports with ruff
2. Or format on save handles it automatically
