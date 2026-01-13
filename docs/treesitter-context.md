# Treesitter Context

Shows sticky function/class context at the top of the screen.

## Quick Reference

| Feature | Tool |
|---------|------|
| Plugin | nvim-treesitter-context |
| Requires | nvim-treesitter |

## Keybindings

| Key | Action |
|-----|--------|
| `[c` | Jump to context (parent function/class) |
| `<leader>uc` | Toggle context on/off |

## How It Works

When scrolling through a long file, the context window shows which function or class you're currently inside:

```
┌─────────────────────────────────────────┐
│ function processData(items) {           │  <- Context (sticky)
├─────────────────────────────────────────┤
│     // ... lots of code ...             │
│     for (const item of items) {         │
│       if (item.valid) {                 │  <- Your cursor here
│         doSomething(item);              │
│       }                                 │
│     }                                   │
│     // ... more code ...                │
└─────────────────────────────────────────┘
```

Without context, you'd have to scroll up to see which function you're in.

## Configuration

### Current Settings

| Option | Value |
|--------|-------|
| Max lines | 3 |
| Min window height | 20 lines |
| Mode | cursor |
| Line numbers | Shown |

### Context Levels

Up to 3 levels of context are shown:

```
class UserService {                    <- Level 1
  async function getUser(id) {         <- Level 2
    try {                              <- Level 3
      // cursor here
```

## Example Use Cases

### Long Functions

When deep inside a long function:

```
Without context:
  - Scroll up to see function name
  - Lose your place
  - Scroll back down

With context:
  - Function name always visible
  - Never lose your place
  - Know exactly where you are
```

### Nested Classes/Functions

```python
class OrderProcessor:                  # Context line 1
    def process_order(self, order):    # Context line 2
        def validate_items(items):     # Context line 3
            for item in items:
                # Your cursor is here
                # You can see all 3 parent scopes
```

### Deep Nesting

```javascript
router.get('/api', (req, res) => {     // Context shows this
  db.query(sql, (err, results) => {    // And this
    results.forEach(item => {           // And this
      // Cursor here - you know exactly
      // which callback you're in
    });
  });
});
```

## Navigation

### Jump to Context

Press `[c` to jump to the context line:

```
1. You're deep in a function
2. Press [c
3. Cursor jumps to function definition
4. Press [c again for parent class
```

### Toggle Context

If context is distracting:

```
<leader>uc - Toggle off
<leader>uc - Toggle back on
```

## Visual Appearance

### Context Window

- Appears at line 1 of the visible area
- Shows up to 3 lines of context
- Includes line numbers
- Syntax highlighted

### Minimum Window Size

Context only appears if:
- Window has at least 20 lines visible
- You're scrolled past the context

## Supported Languages

Works with any language that has a treesitter parser:

- JavaScript/TypeScript
- Python
- Rust
- Go
- C/C++
- Lua
- Ruby
- Java
- And many more...

## Tips

### Quickly Orient Yourself

When opening a file at a specific line (from grep, error, etc.):
- Context immediately shows where you are
- No need to scroll up to understand

### Code Review

When reviewing long files:
- Always know which function you're reading
- Context provides continuous orientation

### Pair with Flash

```
1. See context shows you're in processData()
2. Press [c to jump there
3. Or use s to flash jump to specific spot
```

## Troubleshooting

### Context Not Showing

1. Check treesitter is installed for language:
   ```vim
   :TSInstallInfo
   ```

2. Verify window height (need 20+ lines)

3. Check if toggled off:
   ```vim
   :lua require('treesitter-context').enable()
   ```

### Wrong Context Showing

- Update treesitter parser: `:TSUpdate`
- Check language detection: `:set ft?`
- Report issue if parser bug

### Performance Issues

If context causes lag:
- Reduce max_lines to 1-2
- Disable in very large files
- Check treesitter health: `:checkhealth nvim-treesitter`
