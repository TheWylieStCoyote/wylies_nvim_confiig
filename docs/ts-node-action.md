# TreeSitter Node Actions

> Context-aware code transformations

## Quick Reference

| Component | Tool |
|-----------|------|
| Plugin | CKolkey/ts-node-action |
| Dependencies | nvim-treesitter |

## Keybindings

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>cn` | n | Node Action |
| `gn` | n | Node Action |

## Available Actions

Actions are context-dependent based on the TreeSitter node under cursor.

### Boolean

| Before | After |
|--------|-------|
| `true` | `false` |
| `false` | `true` |

### Strings

| Before | After |
|--------|-------|
| `"string"` | `'string'` |
| `'string'` | `` `string` `` |
| `` `string` `` | `"string"` |

### Operators

| Before | After |
|--------|-------|
| `==` | `!=` |
| `&&` | `\|\|` |
| `+` | `-` |

### Conditionals

| Before | After |
|--------|-------|
| `if (a) b else c` | `a ? b : c` |
| `a ? b : c` | `if (a) b else c` |

### Arrays/Objects

| Before | After |
|--------|-------|
| `[a, b, c]` | `[\n  a,\n  b,\n  c\n]` |
| Multi-line array | Single-line array |

### Functions (JavaScript/TypeScript)

| Before | After |
|--------|-------|
| `function foo() {}` | `const foo = () => {}` |
| `const foo = () => {}` | `function foo() {}` |

## Supported Languages

- JavaScript/TypeScript
- Lua
- Python
- Ruby
- Go
- Rust
- JSON
- HTML
- CSS
- And more...

## Usage

1. Place cursor on a node (boolean, string, operator, etc.)
2. Press `gn` or `<leader>cn`
3. Action is applied based on node type

## Configuration

Located in `lua/plugins/ts-node-action.lua`

The plugin automatically detects available actions based on the TreeSitter node under the cursor.
