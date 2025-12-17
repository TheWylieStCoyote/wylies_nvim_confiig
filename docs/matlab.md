# MATLAB/Octave Development

> LSP: matlab-ls | Formatter: - | Auto-detects MATLAB vs Octave

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | matlab-ls (requires MATLAB) |
| Alternative | Octave CLI |
| TreeSitter | matlab |

## Features

- MATLAB language server (if MATLAB installed)
- Octave fallback
- Workspace indexing
- Run scripts
- Plotting support
- Path management
- Debugging support

## Keybindings

### Run (auto-detects MATLAB/Octave)

| Key | Action |
|-----|--------|
| `<leader>mr` | Run File |
| `<leader>mR` | Run File (no desktop) |
| `<leader>mi` | CLI |
| `<leader>mI` | GUI |
| `<leader>ml` | Run Line |
| `<leader>ms` | Run Selection (visual) |

### Workspace

| Key | Action |
|-----|--------|
| `<leader>mc` | Clear Workspace |
| `<leader>mw` | Show Workspace (whos) |

### Help

| Key | Action |
|-----|--------|
| `<leader>mh` | Help (word) |
| `<leader>mH` | Help (input) |
| `<leader>md` | Documentation |

### Plotting

| Key | Action |
|-----|--------|
| `<leader>mpf` | Plot Line |
| `<leader>mps` | Save Figure |

### Path

| Key | Action |
|-----|--------|
| `<leader>mpa` | Add to Path |

### Debugging

| Key | Action |
|-----|--------|
| `<leader>mdb` | Set Breakpoint |
| `<leader>mdc` | Clear Breakpoints |

### Testing

| Key | Action |
|-----|--------|
| `<leader>mt` | Run Tests |

### Templates

| Key | Action |
|-----|--------|
| `<leader>mn` | New Function |
| `<leader>mN` | New Class |

### Packages (Octave)

| Key | Action |
|-----|--------|
| `<leader>mp` | List Packages |
| `<leader>mP` | Install Package |
| `<leader>mL` | Load Package |

## Installation

### Mason Packages
```vim
" matlab-ls requires MATLAB installation
:MasonInstall matlab-language-server
```

### System Requirements

**Option 1: MATLAB**
- Requires MATLAB license
- LSP provides full features

**Option 2: Octave (free)**
```bash
# Arch
sudo pacman -S octave

# Ubuntu
sudo apt install octave
```

## Configuration

### MATLAB LSP

Requires setting MATLAB installation path in config.

### Auto-Detection

The config automatically detects:
- If `octave` is available and `matlab` is not → uses Octave
- Otherwise → uses MATLAB

## Templates

### New Function
```matlab
function [output] = name(input)
%  NAME - Short description
%
%  Syntax:
%    output = name(input)
...
end
```

### New Class
```matlab
classdef Name
    properties
        Property1
    end
    methods
        function obj = Name(arg1)
            % Constructor
        end
    end
end
```

## Usage Examples

### Quick Script
1. Write `.m` file
2. `<leader>mr` - Run script

### Interactive
1. `<leader>mi` - Open CLI
2. Test commands
3. `<leader>mw` - View workspace

### Plotting
1. Run plotting code
2. `<leader>mps` - Save figure
