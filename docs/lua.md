# Lua Development

> LSP: lua_ls | Formatter: stylua

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | lua_ls (lua-language-server) |
| Formatter | stylua |
| TreeSitter | lua, luadoc |

## Features

- Full lua_ls integration
- lazydev.nvim for Neovim Lua development
- Neovim API completions
- Plugin library support
- LuaJIT and Lua 5.1-5.4 support

## Keybindings

### Lua-Specific

| Key | Action |
|-----|--------|
| `<leader>lr` | Run File |
| `<leader>li` | Lua REPL |
| `<leader>lR` | Reload Module |
| `<leader>lt` | Run Tests (busted) |
| `<leader>lT` | Run Test File |
| `<leader>lL` | Luacheck |
| `<leader>la` | Code Actions |
| `<leader>lh` | Hover Info |

## Installation

### Mason Packages
```vim
:MasonInstall lua-language-server stylua
```

### System Requirements

```bash
# Arch
sudo pacman -S lua luajit

# Optional: testing
luarocks install busted
```

## Configuration

### lua_ls Settings

For Neovim Lua development:
- Runtime path includes Neovim runtime
- Workspace library includes plugin paths
- Diagnostics configured for Neovim globals

### lazydev.nvim

Automatically provides:
- `vim.*` API completions
- Plugin type definitions
- Lazy.nvim spec completions

### .stylua.toml

```toml
column_width = 120
line_endings = "Unix"
indent_type = "Spaces"
indent_width = 2
quote_style = "AutoPreferDouble"
```

## Usage Examples

### Neovim Plugin Development
1. Write plugin in `lua/` directory
2. Get full completions for vim API
3. `<leader>lr` - Test with `:luafile %`

### Standalone Lua
1. Write `.lua` file
2. `<leader>lr` - Run with lua interpreter
3. `<leader>li` - Interactive REPL
