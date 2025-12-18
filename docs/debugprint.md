# Debug Print

> Quick debug print statement insertion

## Quick Reference

| Component | Tool |
|-----------|------|
| Plugin | andrewferrier/debugprint.nvim |
| Dependencies | nvim-treesitter |

## Keybindings

### Normal Mode

| Key | Description |
|-----|-------------|
| `g?p` | Insert debug print below |
| `g?P` | Insert debug print above |
| `g?v` | Print variable below (cursor word) |
| `g?V` | Print variable above (cursor word) |
| `g?o` | Print text object below |
| `g?O` | Print text object above |

### Visual Mode

| Key | Description |
|-----|-------------|
| `g?v` | Print selected variable below |
| `g?V` | Print selected variable above |

### Insert Mode

| Key | Description |
|-----|-------------|
| `<C-G>p` | Insert plain debug print |
| `<C-G>v` | Insert variable print |

### Management

| Key | Description |
|-----|-------------|
| `<leader>dP` | Toggle comment all debug prints |
| `<leader>dX` | Delete all debug prints |

## Output Examples

**Python:**
```python
print(f"DEBUG[1]: my_var={my_var}")
```

**JavaScript/TypeScript:**
```javascript
console.log("DEBUG[1]: myVar=", myVar);
```

**Go:**
```go
fmt.Printf("DEBUG[1]: myVar=%v\n", myVar)
```

**Rust:**
```rust
println!("DEBUG[1]: my_var={:?}", my_var);
```

**Lua:**
```lua
print("DEBUG[1]: my_var=" .. vim.inspect(my_var))
```

**C/C++:**
```c
printf("DEBUG[1]: my_var=%d\n", my_var);
```

## Commands

| Command | Description |
|---------|-------------|
| `:ToggleCommentDebugPrints` | Comment/uncomment all debug prints |
| `:DeleteDebugPrints` | Delete all debug prints |

## Usage Workflow

1. Position cursor on a variable
2. Press `g?v` to insert a debug print
3. Run your code to see the output
4. When done, `<leader>dX` to remove all debug prints

## Configuration

Located in `lua/plugins/debugprint.lua`

Features:
- Counter for tracking print order
- Snippet display in print
- Language-aware formatting
- TreeSitter integration for accuracy
