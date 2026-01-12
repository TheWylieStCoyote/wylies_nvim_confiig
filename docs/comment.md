# Comment.nvim - Smart Commenting

Toggle comments with context-aware support for embedded languages (JSX/TSX).

## Quick Reference

| Component | Value |
|-----------|-------|
| Plugin | numToStr/Comment.nvim |
| Integration | nvim-ts-context-commentstring |
| Trigger | `gcc`, `gc`, `gbc`, `gb` |

## Keybindings

### Toggle Comments

| Key | Mode | Action |
|-----|------|--------|
| `gcc` | Normal | Toggle line comment |
| `gbc` | Normal | Toggle block comment |

### Operator-Pending (with motion)

| Key | Mode | Action |
|-----|------|--------|
| `gc{motion}` | Normal | Comment with motion |
| `gb{motion}` | Normal | Block comment with motion |
| `gc` | Visual | Comment selection (line-wise) |
| `gb` | Visual | Block comment selection |

### Extra Mappings

| Key | Mode | Action |
|-----|------|--------|
| `gcO` | Normal | Add comment on line above |
| `gco` | Normal | Add comment on line below |
| `gcA` | Normal | Add comment at end of line |

## Examples

### Line Comments

```lua
-- Comment a single line
gcc

-- Comment 3 lines down
gc3j

-- Comment a paragraph
gcap

-- Comment to end of function
gc}
```

### Block Comments

```lua
-- Block comment selection (visual mode)
-- 1. Select text with v or V
-- 2. Press gb

-- Block comment with motion
gb2j  -- Block comment 2 lines down
```

### Adding Comments

```lua
-- Add comment above current line
gcO

-- Add comment below current line
gco

-- Add comment at end of current line
gcA
```

## JSX/TSX Support

Comment.nvim integrates with `nvim-ts-context-commentstring` to use the correct comment syntax in embedded languages:

```jsx
function Component() {
  return (
    <div>
      {/* This gets JSX comment syntax */}
      <span>Hello</span>
    </div>
  );
}
// This gets JavaScript comment syntax
```

## Configuration

### Current Settings

- **Padding**: Space between comment delimiter and text
- **Sticky cursor**: Cursor stays at its position after commenting
- **Ignore empty lines**: Empty lines are not commented

## Usage Tips

1. **Quick toggle**: `gcc` is the fastest way to toggle a comment
2. **Visual selection**: Select lines with `V`, then press `gc` to comment them all
3. **Motion-based**: Use `gcap` to comment an entire paragraph
4. **Block vs Line**: Use `gb` for block comments (`/* */`) and `gc` for line comments (`//`)
