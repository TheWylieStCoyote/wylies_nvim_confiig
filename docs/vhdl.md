# VHDL Development

> LSP: vhdl_ls | Formatter: vsg | Linter: ghdl

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | vhdl_ls (rust_hdl) |
| Formatter | vsg (VHDL Style Guide) |
| Linter | ghdl |
| TreeSitter | vhdl |

## Features

- rust_hdl (vhdl_ls) LSP
- GHDL simulation
- NVC alternative simulator
- GTKWave waveform viewing
- Entity/testbench templates
- FPGA tool integration

## Keybindings

### GHDL

| Key | Action |
|-----|--------|
| `<leader>Va` | Analyze (ghdl -a) |
| `<leader>VA` | Analyze All |
| `<leader>Ve` | Elaborate (ghdl -e) |
| `<leader>Vr` | Run Simulation |
| `<leader>VR` | Run (timed) |
| `<leader>Vx` | Analyze + Elaborate + Run |
| `<leader>Vs` | Syntax Check |
| `<leader>VS` | Syntax Check All |

### Waveforms

| Key | Action |
|-----|--------|
| `<leader>Vw` | View GHW in GTKWave |
| `<leader>VW` | View Waveform (select) |

### NVC

| Key | Action |
|-----|--------|
| `<leader>Vna` | NVC Analyze |
| `<leader>Vne` | NVC Elaborate |
| `<leader>Vnr` | NVC Run |

### Templates

| Key | Action |
|-----|--------|
| `<leader>Vt` | Generate Testbench |
| `<leader>Vn` | New Entity |
| `<leader>Vp` | New Package |
| `<leader>Vi` | Init vhdl_ls.toml |

### Other

| Key | Action |
|-----|--------|
| `<leader>Vc` | Clean Build |
| `<leader>Vf` | Format (emacs) |
| `<leader>Vh` | Hover Info |
| `<leader>Va` | Code Actions |

### FPGA

| Key | Action |
|-----|--------|
| `<leader>VFv` | Vivado Build |
| `<leader>VFq` | Quartus Build |

## Installation

### Mason Packages
```vim
:MasonInstall vhdl_ls
```

### System Requirements

```bash
# Arch
sudo pacman -S ghdl gtkwave

# NVC (faster simulator)
yay -S nvc

# Optional: VHDL Style Guide
pip install vsg
```

## Configuration

### vhdl_ls.toml

Required in project root (`<leader>Vi` creates it):
```toml
[libraries]
work.files = ["src/*.vhd", "tb/*.vhd"]
work.standard = "2008"
```

## Entity Template

Generated with `<leader>Vn`:
```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity name is
  generic (WIDTH : positive := 8);
  port (
    clk      : in  std_logic;
    rst_n    : in  std_logic;
    data_in  : in  std_logic_vector(WIDTH-1 downto 0);
    data_out : out std_logic_vector(WIDTH-1 downto 0)
  );
end entity;

architecture rtl of name is
begin
  -- Implementation
end architecture;
```

## Testbench Template

Generated with `<leader>Vt`:
```vhdl
entity name_tb is
end entity;

architecture sim of name_tb is
  constant CLK_PERIOD : time := 10 ns;
  signal clk : std_logic := '0';
  signal running : boolean := true;
begin
  clk <= not clk after CLK_PERIOD/2 when running;
  -- DUT instantiation
  -- Stimulus process
end architecture;
```

## Usage Examples

### Simulation Flow
1. Write VHDL entity
2. `<leader>Vt` - Generate testbench
3. `<leader>Vx` - Full compile + run
4. `<leader>Vw` - View waveforms

### Quick Check
1. `<leader>Vs` - Syntax check
2. `<leader>Va` - Analyze
