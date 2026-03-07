# Neogen - Docstring Generator

> Auto-generate docstrings and annotations from function signatures

## Quick Reference

| Component | Tool |
|-----------|------|
| Plugin | danymat/neogen |
| Engine | nvim snippets |
| Dependencies | nvim-treesitter |

## Keybindings

### Generate (`<leader>cg...`)

| Key | Action |
|-----|--------|
| `<leader>cg` | Generate Docstring (auto-detect) |
| `<leader>cgf` | Generate Function Doc |
| `<leader>cgc` | Generate Class Doc |
| `<leader>cgt` | Generate Type Doc |
| `<leader>cgF` | Generate File Doc |

## Language Conventions

| Language | Convention |
|----------|------------|
| Python | google_docstrings |
| JavaScript | jsdoc |
| TypeScript | tsdoc |
| Lua | emmylua |
| Rust | rustdoc |
| Go | godoc |
| Java | javadoc |
| C | doxygen |
| C++ | doxygen |

## Usage

```
1. Place cursor on a function/class/type
2. Press <leader>cg to generate a docstring
3. Fill in the snippet placeholders with Tab
```

### Example: Python

```python
def calculate(x: int, y: int) -> int:
    ...

# After <leader>cgf:

def calculate(x: int, y: int) -> int:
    """[summary]

    Args:
        x (int): [description]
        y (int): [description]

    Returns:
        int: [description]
    """
    ...
```

## Configuration

Located in `lua/plugins/neogen.lua`

- Uses nvim built-in snippet engine
- TreeSitter-powered signature parsing
- Per-language annotation conventions
