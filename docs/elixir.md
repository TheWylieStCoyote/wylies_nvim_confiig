# Elixir Development

> LSP: elixir-ls | Formatter: mix format | Debugger: elixir-ls DAP

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | elixir-ls |
| Formatter | mix format |
| Debugger | elixir-ls (built-in DAP) |
| TreeSitter | elixir, heex, eex, erlang |

## Features

- Full elixir-ls integration
- Dialyzer enabled
- Test lenses
- Spec suggestions
- Phoenix support
- Ecto integration
- Mix task execution

## Keybindings

### Elixir-Specific

| Key | Action |
|-----|--------|
| `<leader>xr` | Run File |
| `<leader>xc` | IEx Console |
| `<leader>xC` | IEx with Mix |
| `<leader>xm` | Mix Compile |
| `<leader>xM` | Mix Compile (force) |
| `<leader>xd` | Mix Deps Get |
| `<leader>xD` | Mix Deps Update |

### Testing

| Key | Action |
|-----|--------|
| `<leader>xt` | Mix Test (all) |
| `<leader>xT` | Mix Test (file) |
| `<leader>xl` | Mix Test (line) |
| `<leader>xF` | Mix Test (failed) |
| `<leader>xw` | Mix Test (stale) |

### Phoenix

| Key | Action |
|-----|--------|
| `<leader>xp` | Phoenix Server |
| `<leader>xP` | Phoenix Server (IEx) |
| `<leader>xR` | Phoenix Routes |
| `<leader>xg` | Phoenix Generate |

### Ecto

| Key | Action |
|-----|--------|
| `<leader>xe` | Ecto Migrate |
| `<leader>xE` | Ecto Rollback |
| `<leader>xs` | Ecto Reset |
| `<leader>xS` | Ecto Setup |

### Other

| Key | Action |
|-----|--------|
| `<leader>xf` | Mix Format (all) |
| `<leader>xo` | Credo |
| `<leader>xO` | Credo (strict) |
| `<leader>xy` | Dialyzer |
| `<leader>xn` | Mix New |
| `<leader>xN` | Phoenix New |

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
:MasonInstall elixir-ls
```

### System Requirements

**Elixir:**
```bash
# Arch
sudo pacman -S elixir

# Or use asdf
asdf install elixir latest
```

## Configuration

### elixir-ls Settings

- Dialyzer enabled (dialyxir_long format)
- Fetch deps disabled (manual)
- Test lenses enabled
- Spec suggestions enabled

### .formatter.exs

```elixir
[
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"],
  line_length: 98
]
```

## Debug Configurations

1. **mix test** - Debug all tests
2. **mix test (current file)** - Debug tests in current file
3. **phx.server** - Debug Phoenix server

## Usage Examples

### Phoenix Development
1. `<leader>xP` - Start Phoenix with IEx
2. `<leader>xR` - View routes
3. `<leader>xg` - Generate resources

### Testing
1. `<leader>xl` - Run test at line
2. `<leader>xF` - Re-run failed tests
3. `<leader>xw` - Run stale tests only

### Database
1. `<leader>xS` - Setup database
2. `<leader>xe` - Run migrations
3. `<leader>xE` - Rollback if needed
