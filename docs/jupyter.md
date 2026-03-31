# Jupyter Notebooks

> Kernel execution: molten-nvim | Notebook format: jupytext

## Overview

Work with Jupyter notebooks entirely within Neovim using two complementary plugins:

- **jupytext.nvim** — transparently converts `.ipynb` ↔ percent-format `.py` on open/save, so notebooks are treated as normal Python files with full LSP, formatting, and version control support
- **molten-nvim** — connects to live Jupyter kernels and runs code cells with inline output displayed directly in the buffer

## Quick Reference

| Component | Tool |
|-----------|------|
| Kernel execution | molten-nvim |
| Notebook format | jupytext (percent `.py`) |
| Image output | image.nvim (optional — requires kitty, WezTerm, or iTerm2) |

## Keybindings (`<leader>nb...`)

| Key | Action |
|-----|--------|
| `<leader>nbi` | Init Kernel (prompts for kernel name) |
| `<leader>nbe` | Evaluate Line |
| `<leader>nbe` | Evaluate Selection (visual mode) |
| `<leader>nbr` | Re-evaluate Cell under cursor |
| `<leader>nbd` | Delete Cell output |
| `<leader>nbs` | Show Output window |
| `<leader>nbh` | Hide Output window |
| `<leader>nbI` | Interrupt Kernel |
| `<leader>nbR` | Restart Kernel (clears all output) |

## Installation

### Python Dependencies

```bash
pip install jupytext jupyter_client pynvim nbformat
```

### After Plugin Install

Run once in Neovim to register the remote plugin:

```vim
:UpdateRemotePlugins
```

Then restart Neovim.

### List Available Kernels

```bash
jupyter kernelspec list
```

## Workflow

### Opening a Notebook

1. Open a `.ipynb` file — jupytext silently converts it to percent-format `.py` in memory
2. Edit cells as normal Python code with full LSP support
3. Save — jupytext writes the changes back to `.ipynb`

### Running Code

1. `<leader>nbi` — select a kernel (e.g. `python3`)
2. Navigate to a cell (between `# %%` markers)
3. `<leader>nbe` — evaluate current line, or select lines and evaluate
4. `<leader>nbr` — re-run the cell under the cursor
5. Output appears inline below the cell

### Percent Format

Notebooks are edited as Python files with cell markers:

```python
# %%
import numpy as np
import matplotlib.pyplot as plt

# %% [markdown]
# ## My Analysis

# %%
x = np.linspace(0, 10, 100)
plt.plot(x, np.sin(x))
plt.show()
```

## Optional: Inline Images

To render matplotlib/plotly plots inline (instead of opening an external window), install `image.nvim` and set the provider:

```bash
# Requires kitty, WezTerm, or iTerm2
pip install cairosvg  # or pnglatex for LaTeX output
```

Then set in `jupyter.lua`:
```lua
vim.g.molten_image_provider = "image.nvim"
```

## Other Plugins Considered

| Plugin | Description | When to Add |
|--------|-------------|-------------|
| `3rd/image.nvim` | Inline image/plot rendering | When using a supported terminal |
| `GCBallesteros/NotebookNavigator.nvim` | Cell motions for percent files | Alternative cell navigation |
| `quarto-dev/quarto-nvim` + `jmbuhr/otter.nvim` | Quarto `.qmd` document support | If writing Quarto reports |
