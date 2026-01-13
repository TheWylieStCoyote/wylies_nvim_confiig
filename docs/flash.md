# Flash.nvim - Enhanced Motions

Jump anywhere on screen with search labels.

## Quick Reference

| Feature | Tool |
|---------|------|
| Plugin | flash.nvim |
| Author | folke |

## Keybindings

| Key | Mode | Action |
|-----|------|--------|
| `s` | n, x, o | Flash jump |
| `S` | n, x, o | Flash Treesitter select |
| `f` | n, x, o | Enhanced f motion |
| `F` | n, x, o | Enhanced F motion |
| `t` | n, x, o | Enhanced t motion |
| `T` | n, x, o | Enhanced T motion |
| `r` | o | Remote flash |
| `R` | o, x | Treesitter search |
| `<C-s>` | c | Toggle flash in search |

## How Flash Works

### Basic Jump (s)

```
1. Press s
2. Type 1-2 characters to search
3. Labels appear on matches
4. Press label key to jump

Example:
  Press: s
  Type: fu
  See: Labels [a] [b] [c] on "function" matches
  Press: a
  Result: Jump to first match
```

### Enhanced f/F/t/T

Traditional Vim motions with labels:

```
f{char}  - Jump to next {char} on line
F{char}  - Jump to previous {char} on line
t{char}  - Jump to before next {char}
T{char}  - Jump to after previous {char}

With Flash:
- Multiple matches show labels
- Press ; or , to repeat
- Labels appear for quick selection
```

## Treesitter Integration

### Select with S

```
1. Press S
2. Labels appear on treesitter nodes
3. Press label to select entire node

Great for:
- Selecting functions
- Selecting blocks
- Selecting arguments
```

### Remote Operations (r)

In operator-pending mode:

```
d + r + {search} + {label}
  Delete text at label location without moving

y + r + {search} + {label}
  Yank text at label location
```

## Example Workflows

### Quick Navigation

```
# Jump to any word starting with "fn"
s fn [press label]

# Jump to specific function
s def [press label for "def" in Python]
s fun [press label for "function" in JS]
```

### Code Editing

```
# Delete to a word
d s {search} {label}

# Change to a word
c s {search} {label}

# Yank to a word
y s {search} {label}
```

### Select Code Blocks

```
# Select entire function
S [press label on function]

# Select if block
S [press label on if statement]

# Select loop
S [press label on for/while]
```

### Multi-Window Jump

Flash searches across all visible windows:

```
1. Have multiple splits open
2. Press s
3. Type search chars
4. Labels appear in ALL windows
5. Jump to any window instantly
```

## Configuration

### Current Settings

| Option | Value |
|--------|-------|
| Multi-window | Enabled |
| Backdrop | Dimmed |
| Labels | a-z |
| Search mode | Not overriding `/` |

### Label Priority

Labels are assigned by distance from cursor:
- Closest matches get `a`, `s`, `d`, `f`
- Home row keys prioritized
- Uppercase for far matches

## Tips

### Faster Than Regular Search

```
# Old way (slow)
/functionName<CR>

# Flash way (fast)
s fu [label]
```

### Combine with Operators

```
# Delete everything up to "return"
d s ret [label]

# Change text until "}"
c s } [label]
```

### Use Treesitter for Selection

Instead of `va{` or `vaf`:

```
S [select entire node]
- More precise than text objects
- Works with any language
- Respects syntax structure
```

### Repeat Last Jump

```
After a flash jump:
; - Go to next match
, - Go to previous match
```

## Comparison to Other Plugins

| Feature | Flash | Leap | Sneak |
|---------|-------|------|-------|
| 2-char search | Yes | Yes | Yes |
| Labels | Yes | Yes | Limited |
| Treesitter | Yes | No | No |
| Multi-window | Yes | Yes | No |
| Remote ops | Yes | No | No |

## Troubleshooting

### Labels Not Showing

- Ensure enough matches exist
- Check if pattern matches anything
- Try simpler search (1 char)

### Conflict with Other Plugins

Flash uses `s` which may conflict with:
- vim-surround (use `ys` instead)
- mini.surround (use `sa` instead)

### Performance Issues

- Disable backdrop: `highlight = { backdrop = false }`
- Reduce search scope
- Check treesitter health: `:TSInstallInfo`
