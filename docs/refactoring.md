# Refactoring

> Code refactoring support (extract function, extract variable, etc.)

## Quick Reference

| Component | Tool |
|-----------|------|
| Plugin | ThePrimeagen/refactoring.nvim |
| Dependencies | plenary.nvim, nvim-treesitter |

## Keybindings

### Extract (Visual Mode)

| Key | Description |
|-----|-------------|
| `<leader>re` | Extract Function |
| `<leader>rf` | Extract Function To File |
| `<leader>rv` | Extract Variable |

### Inline

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ri` | n, v | Inline Variable |
| `<leader>rI` | n | Inline Function |

### Block Extract (Normal Mode)

| Key | Description |
|-----|-------------|
| `<leader>rb` | Extract Block |
| `<leader>rB` | Extract Block To File |

### Menu

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>rr` | n, v | Refactoring Menu (Telescope) |

### Debug Statements

| Key | Description |
|-----|-------------|
| `<leader>rp` | Debug Print Below |
| `<leader>rP` | Debug Print Above |
| `<leader>rv` | Debug Print Variable |
| `<leader>rc` | Debug Cleanup |

## Supported Languages

- Go
- JavaScript/TypeScript
- Lua
- Python
- Ruby
- C/C++
- Java
- PHP

## Refactoring Operations

### Extract Function
Select code in visual mode, `<leader>re` to extract into a new function.

```python
# Before (select lines 2-3)
def process():
    x = get_value()
    result = x * 2 + 10
    return result

# After
def extracted():
    x = get_value()
    result = x * 2 + 10
    return result

def process():
    return extracted()
```

### Extract Variable
Select expression in visual mode, `<leader>rv` to extract into a variable.

```python
# Before (select `x * 2 + 10`)
result = x * 2 + 10

# After
extracted = x * 2 + 10
result = extracted
```

### Inline Variable
Place cursor on variable, `<leader>ri` to inline its value.

```python
# Before
temp = get_value()
result = temp * 2

# After
result = get_value() * 2
```

### Extract Block
In normal mode, `<leader>rb` extracts the current block into a function.

## Configuration

Located in `lua/plugins/refactoring.lua`

Features:
- Prompts for return type (Go, C++, C, Java)
- Prompts for parameter type (Go, C++, C, Java)
- Telescope integration
- Debug print helpers
