# Ruby Development

> LSP: ruby_lsp | Formatter: rubocop | Linter: rubocop | Debugger: rdbg

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | ruby_lsp (Shopify) |
| Formatter | rubocop |
| Linter | rubocop |
| Debugger | rdbg (debug gem) |
| TreeSitter | ruby |

## Features

- Full ruby_lsp integration
- RuboCop formatting and linting
- Rails support
- RSpec integration
- Bundler integration
- Debug gem support

## Keybindings

### Ruby-Specific

| Key | Action |
|-----|--------|
| `<leader>Rr` | Run File |
| `<leader>Ri` | IRB Console |
| `<leader>Rt` | RSpec (all) |
| `<leader>RT` | RSpec (file) |
| `<leader>Rl` | RSpec (line) |
| `<leader>RF` | RSpec (failures) |
| `<leader>Rb` | Bundle Install |
| `<leader>RB` | Bundle Update |
| `<leader>Re` | Bundle Exec |

### Rails

| Key | Action |
|-----|--------|
| `<leader>Rc` | Rails Console |
| `<leader>Rs` | Rails Server |
| `<leader>Rm` | Rails Migrate |
| `<leader>RM` | Rails Migrate Status |
| `<leader>Rd` | Rails Seed |
| `<leader>Rg` | Rails Generate |
| `<leader>RR` | Rails Routes |

### RuboCop

| Key | Action |
|-----|--------|
| `<leader>Ro` | RuboCop (file) |
| `<leader>RO` | RuboCop Auto-correct |

### Rake

| Key | Action |
|-----|--------|
| `<leader>Rk` | Rake Task |

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
:MasonInstall ruby-lsp rubocop
```

### System Requirements

**Ruby:**
```bash
# Arch
sudo pacman -S ruby

# Or use rbenv/rvm
```

**Debug gem:**
```bash
gem install debug
```

## Configuration

### ruby_lsp Features

All features enabled:
- Code actions, code lens
- Completion, definition
- Diagnostics, document highlights
- Document link, symbols
- Folding, formatting
- Hover, inlay hints
- On-type formatting
- References, rename
- Selection ranges
- Semantic highlighting
- Signature help
- Type hierarchy
- Workspace symbols

### .rubocop.yml

```yaml
AllCops:
  NewCops: enable
  TargetRubyVersion: 3.2

Style/Documentation:
  Enabled: false

Layout/LineLength:
  Max: 120
```

## Usage Examples

### Rails Development
1. `<leader>Rs` - Start Rails server
2. `<leader>Rc` - Open Rails console
3. `<leader>Rg` - Generate (model/controller/etc.)

### Testing with RSpec
1. Write tests
2. `<leader>Rl` - Run test at current line
3. `<leader>RT` - Run all tests in file
4. `<leader>RF` - Re-run failed tests

### Debug Session
1. Add `binding.break` in code
2. `<F9>` - Set breakpoints
3. `<F5>` - Start debugging
