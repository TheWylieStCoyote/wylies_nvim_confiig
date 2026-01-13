# BQF - Better Quickfix

Enhanced quickfix window with preview, fuzzy filtering, and better navigation.

## Quick Reference

| Feature | Tool |
|---------|------|
| Plugin | nvim-bqf |
| Author | kevinhwang91 |
| Dependency | fzf |

## Features

- Preview window for quickfix items
- Fuzzy filtering with fzf
- Sign column with item numbers
- Better navigation
- Auto-resize height

## Keybindings (in Quickfix Window)

### Navigation

| Key | Action |
|-----|--------|
| `j` / `k` | Navigate items |
| `<CR>` | Open item |
| `o` | Open item and close qf |
| `O` | Open item in new tab |

### Preview

| Key | Action |
|-----|--------|
| `p` | Toggle preview window |
| `P` | Toggle auto-preview |
| `<C-f>` | Scroll preview down |
| `<C-b>` | Scroll preview up |

### Splits

| Key | Action |
|-----|--------|
| `<C-v>` | Open in vertical split |
| `<C-s>` | Open in horizontal split |
| `<C-t>` | Open in new tab |

### Filtering

| Key | Action |
|-----|--------|
| `zf` | Enter fzf filter mode |
| `zF` | Exit fzf filter mode |
| `<Tab>` | Toggle item selection |
| `<S-Tab>` | Toggle and move up |
| `zn` | Create new list from selected |

### Other

| Key | Action |
|-----|--------|
| `<` | Previous quickfix list |
| `>` | Next quickfix list |
| `q` | Close quickfix |

## Usage Examples

### Grep Results

```bash
# In Neovim
:grep pattern **/*.lua

# Quickfix opens with BQF enhancements
# Preview shows file content
# Navigate with j/k
# <CR> to jump to match
```

### LSP References

```
1. gd on a function
2. gr to find references
3. Results in quickfix with BQF
4. Preview each reference
5. <CR> to jump
```

### Telescope to Quickfix

```
1. <leader>sg to grep
2. Find results
3. <C-q> to send to quickfix
4. BQF enhances the list
5. Filter with zf if needed
```

## FZF Filtering

Enter filter mode with `zf`:

```
1. Open quickfix with results
2. Press zf
3. Type to fuzzy filter
4. <CR> to filter list
5. zF to exit filter mode
```

### Filter Actions

| Key | Action |
|-----|--------|
| `<CR>` | Apply filter |
| `<C-o>` | Toggle all items |
| `<C-s>` | Open selected in split |
| `<C-v>` | Open selected in vsplit |

## Configuration

Current settings in `lua/plugins/bqf.lua`:

```lua
opts = {
  auto_enable = true,
  auto_resize_height = true,
  preview = {
    auto_preview = true,
    win_height = 15,
    winblend = 0,
  },
}
```

## Tips

### Quick Preview Workflow

```
1. Run grep/search
2. Quickfix opens
3. j/k to navigate
4. Preview auto-shows
5. <CR> when you find what you need
```

### Filtering Large Results

```
1. Grep returns many results
2. zf to enter filter mode
3. Type filename or pattern
4. Results narrow down
5. <CR> to apply filter
```

### Multi-file Editing

```
1. Search for pattern
2. Navigate quickfix
3. <C-v> to open in vsplit
4. Edit in split
5. Continue navigating qf
```
