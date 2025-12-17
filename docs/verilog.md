# Verilog/SystemVerilog Development

> LSP: verible, svls | Formatter: verible | Linter: verilator

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | verible-verilog-ls, svls |
| Formatter | verible-verilog-format |
| Linter | verilator |
| TreeSitter | verilog |

## Features

- Verible toolchain (Google)
- Verilator linting
- Icarus Verilog simulation
- GTKWave waveform viewing
- Yosys synthesis
- FPGA tool integration

## Keybindings

### Simulation (Icarus)

| Key | Action |
|-----|--------|
| `<leader>vc` | Compile (iverilog) |
| `<leader>vC` | Compile (SV 2012) |
| `<leader>vr` | Run Simulation |
| `<leader>vR` | Compile & Run |

### Waveforms

| Key | Action |
|-----|--------|
| `<leader>vw` | View VCD in GTKWave |
| `<leader>vW` | View Waveform (select) |

### Verilator

| Key | Action |
|-----|--------|
| `<leader>vl` | Lint File |
| `<leader>vL` | Lint All Files |
| `<leader>vv` | Verilator Build |
| `<leader>vV` | Verilator Build (trace) |

### Verible

| Key | Action |
|-----|--------|
| `<leader>vf` | Format File |
| `<leader>vs` | Syntax Check |
| `<leader>vS` | Lint (verible) |

### Yosys

| Key | Action |
|-----|--------|
| `<leader>vy` | Synthesize |

### Templates

| Key | Action |
|-----|--------|
| `<leader>vt` | Generate Testbench |
| `<leader>vn` | New Module |

### FPGA

| Key | Action |
|-----|--------|
| `<leader>vFv` | Vivado Build |
| `<leader>vFq` | Quartus Build |

### LSP

| Key | Action |
|-----|--------|
| `<leader>va` | Code Actions |
| `<leader>vh` | Hover Info |

## Installation

### Mason Packages
```vim
:MasonInstall verible svls
```

### System Requirements

```bash
# Arch
sudo pacman -S iverilog verilator gtkwave

# Verible (from AUR)
yay -S verible-bin

# Optional: Yosys
sudo pacman -S yosys
```

## Module Template

Generated with `<leader>vn`:
```verilog
module name #(
  parameter WIDTH = 8
) (
  input  wire             clk,
  input  wire             rst_n,
  input  wire [WIDTH-1:0] data_in,
  output reg  [WIDTH-1:0] data_out
);
  // Implementation
endmodule
```

## Testbench Template

Generated with `<leader>vt`:
```verilog
`timescale 1ns/1ps
module name_tb;
  reg clk;
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  // DUT instantiation
  // Test stimulus
endmodule
```

## Usage Examples

### Simulation Flow
1. Write Verilog module
2. `<leader>vt` - Generate testbench
3. `<leader>vR` - Compile and run
4. `<leader>vw` - View waveforms

### Linting
1. `<leader>vl` - Verilator lint
2. Fix warnings
3. `<leader>vf` - Format code
