# Python Development

> LSP: pyright + ruff | Formatter: ruff | Linter: ruff | Debugger: debugpy

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | pyright (types) + ruff (linting) |
| Formatter | ruff format |
| Linter | ruff |
| Debugger | debugpy |
| TreeSitter | python, toml, requirements, rst |

## Features

- Type checking with pyright
- Fast linting and formatting with ruff
- Virtual environment selection
- pytest integration (run and debug)
- Django/Flask/FastAPI debugging
- Package management (pip, uv, poetry)
- Interactive REPL support
- Remote debugging

## Keybindings (`<leader>p...`)

### Code Quality

| Key | Action |
|-----|--------|
| `<leader>po` | Organize Imports (ruff) |
| `<leader>pf` | Ruff Fix All |
| `<leader>pF` | Ruff Format (conform) |
| `<leader>pc` | Type Check (pyright) |
| `<leader>pC` | Type Check (mypy) |

### Run & Execute

| Key | Action |
|-----|--------|
| `<leader>pr` | Run File |
| `<leader>pR` | Run with Arguments |
| `<leader>pm` | Run as Module |
| `<leader>pi` | Run Interactive |
| `<leader>pp` | Python REPL |
| `<leader>pI` | IPython REPL |

### Virtual Environment

| Key | Action |
|-----|--------|
| `<leader>pv` | Select VirtualEnv |
| `<leader>pV` | Select Cached VirtualEnv |

### Testing (pytest)

| Key | Action |
|-----|--------|
| `<leader>ptt` | Run All Tests |
| `<leader>ptf` | Test Current File |
| `<leader>ptv` | Run Tests (verbose) |
| `<leader>ptl` | Run Last Failed |
| `<leader>ptw` | Watch Tests |

### Package Management (pip)

| Key | Action |
|-----|--------|
| `<leader>pii` | pip install |
| `<leader>pir` | pip install requirements.txt |
| `<leader>pie` | pip install -e . (editable) |
| `<leader>piu` | pip install (prompt for package) |

### Package Management (uv)

| Key | Action |
|-----|--------|
| `<leader>puv` | uv pip install |
| `<leader>pur` | uv install requirements.txt |
| `<leader>pus` | uv pip sync |

### Package Management (poetry)

| Key | Action |
|-----|--------|
| `<leader>poa` | poetry add |
| `<leader>poi` | poetry install |
| `<leader>por` | poetry run |

### Debugging (DAP)

| Key | Action |
|-----|--------|
| `<leader>pd` | Debug Selection (visual) |
| `<leader>pdt` | Debug Test Method |
| `<leader>pdT` | Debug Test Class |
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

**Optional tools:**
```bash
# Fast package manager
pip install uv

# Watch mode for tests
pip install pytest-watch

# IPython REPL
pip install ipython
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

## Debug Configurations

Available configurations (select with `<F5>`):

| Config | Description |
|--------|-------------|
| Launch File | Debug current file |
| Launch with Arguments | Debug with custom args |
| Attach to Process | Attach to running process |
| Django: runserver | Debug Django development server |
| Flask: Run App | Debug Flask application |
| FastAPI: uvicorn | Debug FastAPI with uvicorn |
| Attach to Remote | Connect to remote debugpy (port 5678) |

### Remote Debugging Setup

Start debugpy on remote:
```python
import debugpy
debugpy.listen(5678)
debugpy.wait_for_client()
```

Then use "Attach to Remote" configuration.

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
1. Create virtual environment: `python -m venv .venv`
2. `<leader>pv` - Select it
3. Write code
4. `<leader>pr` - Run file

### Type Check Project
1. `<leader>pc` - Run pyright on project
2. View errors in terminal
3. Or use `<leader>pC` for mypy

### Run with Arguments
1. `<leader>pR` - Prompted for arguments
2. Enter: `--verbose --config config.yaml`
3. Script runs with arguments

### Test Debugging
1. Write pytest tests
2. Place cursor on test method
3. `<leader>pdt` - Debug test method
4. Or `<leader>pdT` - Debug entire test class

### Debug Django
1. `<F9>` - Set breakpoints in views
2. `<F5>` - Select "Django: runserver"
3. Access your app in browser
4. Debugger stops at breakpoints

### Debug Flask
1. Set `FLASK_APP` in debug config if needed
2. `<F5>` - Select "Flask: Run App"
3. Access localhost:5000

### Interactive Development
1. `<leader>pi` - Run file interactively
2. Drops into REPL after execution
3. Inspect variables

### Import Organization
1. `<leader>po` - Organize imports with ruff
2. `<leader>pf` - Fix all ruff issues
3. `<leader>pF` - Format file with ruff (via conform)
4. Or format on save handles it automatically

### Package Management
1. `<leader>piu` - Install a package (prompted)
2. Or `<leader>pir` - Install from requirements.txt
3. Use `<leader>pu*` for faster uv commands
