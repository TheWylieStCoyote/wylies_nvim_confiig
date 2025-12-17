# CUDA Development

> LSP: clangd (CUDA mode) | Formatter: clang-format | Debugger: cuda-gdb

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | clangd (with CUDA flags) |
| Formatter | clang-format |
| Debugger | cuda-gdb |
| Profilers | nvprof, nsys, ncu |
| TreeSitter | cuda, cpp |

## Features

- Full clangd support with CUDA extensions
- GPU architecture targeting
- PTX/CUBIN generation
- Multiple profiling tools
- Code templates (kernels, shared memory, Thrust)
- CMake integration
- nvidia-smi integration

## Keybindings

### Compilation

| Key | Action |
|-----|--------|
| `<leader>cc` | Compile (nvcc) |
| `<leader>cC` | Compile (optimized -O3) |
| `<leader>cg` | Compile (debug -g -G) |
| `<leader>ca` | Compile (specify arch) |
| `<leader>cr` | Run |
| `<leader>cR` | Compile & Run |

### PTX/CUBIN

| Key | Action |
|-----|--------|
| `<leader>cp` | Generate PTX |
| `<leader>cP` | Generate CUBIN |
| `<leader>cs` | Disassemble SASS |

### Profiling

| Key | Action |
|-----|--------|
| `<leader>cpr` | Profile (nvprof) |
| `<leader>cpn` | Profile (nsys) |
| `<leader>cpc` | Profile (ncu) |
| `<leader>cpv` | Memory Check |

### GPU Info

| Key | Action |
|-----|--------|
| `<leader>ci` | nvidia-smi |
| `<leader>cI` | nvidia-smi (detailed) |
| `<leader>cd` | GPU Device Info |
| `<leader>cq` | Device Query |

### Libraries

| Key | Action |
|-----|--------|
| `<leader>cl` | Compile to Object |
| `<leader>cL` | Compile to Library |

### CMake

| Key | Action |
|-----|--------|
| `<leader>cmb` | CMake Build |
| `<leader>cmc` | CMake Configure |
| `<leader>cmm` | Make (parallel) |

### Debugging

| Key | Action |
|-----|--------|
| `<leader>cdb` | Debug (cuda-gdb) |

### Templates

| Key | Action |
|-----|--------|
| `<leader>cn` | New Kernel File |
| `<leader>cN` | New Shared Memory Kernel |
| `<leader>ct` | New Thrust Example |

### Other

| Key | Action |
|-----|--------|
| `<leader>ch` | Hover Info |
| `<leader>caa` | Code Actions |
| `<leader>co` | Switch .cu/.cuh |

## Installation

### Mason Packages
```vim
:MasonInstall clangd clang-format
```

### System Requirements

**CUDA Toolkit:**
```bash
# Arch
sudo pacman -S cuda cuda-tools

# Ubuntu
sudo apt install nvidia-cuda-toolkit
```

**Verify installation:**
```bash
nvcc --version
nvidia-smi
```

## Configuration

### clangd CUDA Flags

The configuration includes:
- `--cuda-gpu-arch=sm_75` - Adjust for your GPU
- `--cuda-path=/usr/local/cuda` - Adjust for your CUDA path

Find your GPU architecture:
```bash
nvidia-smi --query-gpu=compute_cap --format=csv
```

### compile_commands.json

For CMake CUDA projects:
```cmake
cmake_minimum_required(VERSION 3.18)
project(myproject CUDA)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CUDA_ARCHITECTURES 75)
```

## Usage Examples

### Quick Compile & Run
1. Write CUDA kernel
2. `<leader>cc` - Compile
3. `<leader>cr` - Run

### Profile Performance
1. `<leader>cC` - Compile optimized
2. `<leader>cpn` - Profile with Nsight Systems
3. Or `<leader>cpc` - Profile with Nsight Compute

### Debug GPU Code
1. `<leader>cg` - Compile with debug symbols
2. `<leader>cdb` - Launch cuda-gdb
3. Set breakpoints in kernel code

### Generate Code Templates
1. `<leader>cn` - Create basic kernel file
2. `<leader>cN` - Create shared memory kernel
3. `<leader>ct` - Create Thrust example

### Check GPU Memory
1. `<leader>cpv` - Run cuda-memcheck
2. Identifies memory leaks and race conditions
