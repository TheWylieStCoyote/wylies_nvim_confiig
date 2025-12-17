# C# Development

> LSP: omnisharp | Formatter: csharpier | Debugger: netcoredbg

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | omnisharp |
| Formatter | csharpier |
| Debugger | netcoredbg |
| TreeSitter | c_sharp |

## Features

- Full OmniSharp integration
- Roslyn analyzers
- Decompilation support
- Enhanced go-to-definition (omnisharp-extended)
- Import completion
- EditorConfig support

## Keybindings

### C#-Specific

| Key | Action |
|-----|--------|
| `gd` | Go to Definition (OmniSharp) |
| `<leader>nD` | Go to Type Definition |
| `<leader>ni` | Go to Implementations |
| `<leader>nr` | Find References |
| `<leader>nb` | Build |
| `<leader>nB` | Build (Release) |
| `<leader>nR` | Run |
| `<leader>nt` | Test |
| `<leader>nT` | Test (filtered) |
| `<leader>nc` | Clean |
| `<leader>ne` | Restore |
| `<leader>nw` | Watch Run |
| `<leader>nW` | Watch Test |
| `<leader>no` | Organize Usings |
| `<leader>ng` | Generate... |
| `<leader>nn` | New Project |
| `<leader>np` | Add Package |

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
:MasonInstall omnisharp netcoredbg csharpier
```

### System Requirements

**.NET SDK:**
```bash
# Arch
sudo pacman -S dotnet-sdk

# Or from Microsoft
# https://dotnet.microsoft.com/download
```

## Configuration

### OmniSharp Settings

- Roslyn analyzers enabled
- Import completion enabled
- Organize imports on format
- Decompilation support enabled
- EditorConfig support enabled
- Load projects on demand disabled
- Include prereleases enabled

### omnisharp-extended

Enhanced navigation:
- Telescope integration for definitions
- Type definitions
- Implementations
- References

### .editorconfig

```ini
[*.cs]
indent_size = 4
indent_style = space
dotnet_sort_system_directives_first = true
```

## Debug Configurations

1. **Launch** - Auto-find DLL in bin/Debug
2. **Launch (with args)** - Specify arguments
3. **Attach** - Attach to running process

## Usage Examples

### Quick Development
1. `<leader>ne` - Restore packages
2. `<leader>nb` - Build
3. `<leader>nR` - Run

### Testing
1. `<leader>nt` - Run all tests
2. `<leader>nT` - Run filtered tests

### Hot Reload
1. `<leader>nw` - Watch run (auto-reload on changes)

### Add Package
1. `<leader>np` - Add NuGet package
2. Enter package name
3. Package is added to .csproj

### New Project
1. `<leader>nn` - Create new project
2. Choose template (console, webapi, etc.)
3. Enter project name
