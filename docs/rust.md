# Rust Development

> LSP: rust-analyzer | Formatter: rustfmt | Linter: clippy | Debugger: codelldb | Checker: bacon

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | rust-analyzer (via rustaceanvim) |
| Formatter | rustfmt |
| Linter | clippy (via rust-analyzer) |
| Debugger | codelldb |
| Background Checker | bacon (nvim-bacon) |
| TreeSitter | rust, toml |

## Features

- Full rust-analyzer integration via rustaceanvim
- Clippy on save
- Inlay hints (types, lifetimes, parameter names)
- Macro expansion
- Crate management (crates.nvim)
- Proc macro support
- Auto-import completions
- Background code checking with bacon

## Keybindings

### Rust-Specific (rustaceanvim)

| Key | Action |
|-----|--------|
| `<leader>rr` | Runnables |
| `<leader>rt` | Testables |
| `<leader>rd` | Open docs.rs |
| `<leader>rc` | Open Cargo.toml |
| `<leader>rm` | Expand Macro |
| `<leader>rp` | Parent Module |
| `<leader>rj` | Join Lines |
| `<leader>ra` | Code Action |
| `<leader>re` | Explain Error |
| `<leader>rh` | Hover Actions |
| `<leader>rD` | Debuggables |

### Cargo.toml (crates.nvim)

| Key | Action |
|-----|--------|
| `<leader>cu` | Update All Crates |
| `<leader>cU` | Update Crate |
| `<leader>cf` | Show Crate Features |
| `<leader>cv` | Show Crate Versions |
| `<leader>cD` | Show Dependencies |
| `<leader>cH` | Open Homepage |
| `<leader>cR` | Open Repository |
| `<leader>cd` | Open Documentation |
| `<leader>cC` | Open crates.io |

### Bacon (Background Checker)

| Key | Action |
|-----|--------|
| `<leader>rb` | Load & Jump to First Error |
| `<leader>rB` | Show Bacon Window |
| `<leader>rl` | List All Locations |
| `<leader>rn` | Next Location |
| `<leader>rN` | Previous Location |

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
:MasonInstall rust-analyzer codelldb
```

### System Requirements

**Install Rust:**
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

**Components:**
```bash
rustup component add rust-analyzer clippy rustfmt
```

**Bacon (background checker):**
```bash
cargo install bacon
```

## Configuration

### rust-analyzer Settings

The configuration enables:
- All cargo features
- Build scripts
- Clippy on save
- Proc macros
- Comprehensive inlay hints

### Cargo.toml Features

When editing `Cargo.toml`, crates.nvim provides:
- Version completion
- Feature toggles
- Dependency info popups

## Usage Examples

### Run & Test
1. `<leader>rr` - Show runnables (main, examples)
2. `<leader>rt` - Show testables
3. Select and run

### Debug
1. `<leader>rD` - Show debuggables
2. Select debug target
3. `<F9>` - Set breakpoints
4. `<F5>` - Start debugging

### Macro Development
1. Place cursor on macro invocation
2. `<leader>rm` - Expand macro
3. View expanded code

### Crate Management
1. Open `Cargo.toml`
2. `<leader>cf` - View features for crate under cursor
3. `<leader>cu` - Update all crates

### Background Checking with Bacon
1. Run `bacon` in a terminal (in your project directory)
2. In Neovim, `<leader>rb` - Load errors and jump to first
3. `<leader>rn` / `<leader>rN` - Navigate through errors
4. `<leader>rB` - Show bacon summary window
