# Bash Development

> LSP: bashls | Formatter: shfmt | Linter: shellcheck | Debugger: bash-debug-adapter

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | bashls (bash-language-server) |
| Formatter | shfmt |
| Linter | shellcheck |
| Debugger | bash-debug-adapter |
| TreeSitter | bash |

## Features

- Full bash-language-server integration
- ShellCheck linting
- shfmt formatting
- Bash debugging support
- Explainshell integration

## Keybindings

### Bash-Specific

| Key | Action |
|-----|--------|
| `<leader>br` | Run Script |
| `<leader>bR` | Run with bash -x |
| `<leader>bc` | Check Syntax |
| `<leader>bl` | Lint (shellcheck) |
| `<leader>be` | Explain Command |

### Debugging (DAP)

| Key | Action |
|-----|--------|
| `<F5>` | Start/Continue |
| `<F9>` | Toggle Breakpoint |
| `<F10>` | Step Over |
| `<F11>` | Step Into |
| `<S-F11>` | Step Out |

### LSP

| Key | Action |
|-----|--------|
| `<leader>ba` | Code Actions |
| `<leader>bh` | Hover Info |

## Installation

### Mason Packages
```vim
:MasonInstall bash-language-server shfmt shellcheck bash-debug-adapter
```

### System Requirements

```bash
# Arch
sudo pacman -S bash shellcheck shfmt

# Explainshell (optional)
# Uses web service
```

## Configuration

### bashls Settings

- Glob pattern for script detection
- Background analysis

### .shellcheckrc

```
# Disable specific warnings
disable=SC2086,SC2034

# Shell dialect
shell=bash
```

### shfmt Options

Default formatting:
- Indent: 2 spaces
- Binary ops at start of line
- Switch case indent
- Space after redirects

## Debug Configuration

Supports:
- Launch script
- Launch with arguments
- Attach to running script

## Usage Examples

### Development Cycle
1. Write script
2. `<leader>bc` - Check syntax
3. `<leader>bl` - Run shellcheck
4. `<leader>br` - Run script

### Debug Script
1. `<F9>` - Set breakpoints
2. `<F5>` - Start debugging
3. Step through execution

### Trace Execution
1. `<leader>bR` - Run with `bash -x`
2. See each command as executed
