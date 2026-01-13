# Refactoring

> Code refactoring support (extract function, extract variable, etc.)

## Quick Reference

| Component | Tool |
|-----------|------|
| Plugin | ThePrimeagen/refactoring.nvim |
| Dependencies | plenary.nvim, nvim-treesitter |

## Keybindings (`<leader>e...`)

### Extract (Visual Mode)

| Key | Description |
|-----|-------------|
| `<leader>ee` | Extract Function |
| `<leader>ef` | Extract Function To File |
| `<leader>ev` | Extract Variable |

### Inline

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ei` | n, v | Inline Variable |
| `<leader>eI` | n | Inline Function |

### Block Extract (Normal Mode)

| Key | Description |
|-----|-------------|
| `<leader>eb` | Extract Block |
| `<leader>eB` | Extract Block To File |

### Menu

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>er` | n, v | Refactoring Menu (Telescope) |

### Debug Statements

| Key | Description |
|-----|-------------|
| `<leader>ep` | Debug Print Below |
| `<leader>eP` | Debug Print Above |
| `<leader>edv` | Debug Print Variable |
| `<leader>ec` | Debug Cleanup |

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
Select code in visual mode, `<leader>ee` to extract into a new function.

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
Select expression in visual mode, `<leader>ev` to extract into a variable.

```python
# Before (select `x * 2 + 10`)
result = x * 2 + 10

# After
extracted = x * 2 + 10
result = extracted
```

### Inline Variable
Place cursor on variable, `<leader>ei` to inline its value.

```python
# Before
temp = get_value()
result = temp * 2

# After
result = get_value() * 2
```

### Extract Block
In normal mode, `<leader>eb` extracts the current block into a function.

## Configuration

Located in `lua/plugins/refactoring.lua`

Features:
- Prompts for return type (Go, C++, C, Java)
- Prompts for parameter type (Go, C++, C, Java)
- Telescope integration
- Debug print helpers
