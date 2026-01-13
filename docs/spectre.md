# Spectre - Search & Replace

Project-wide find and replace with live preview.

## Quick Reference

| Feature | Tool |
|---------|------|
| Plugin | nvim-spectre |
| Backend | ripgrep + sed |

## Keybindings

| Key | Mode | Action |
|-----|------|--------|
| `<leader>sr` | n | Open search & replace panel |
| `<leader>sw` | n | Replace word under cursor |
| `<leader>sw` | v | Replace selection |
| `<leader>sp` | n | Replace in current file |

## Panel Keybindings

When inside the Spectre panel:

| Key | Action |
|-----|--------|
| `dd` | Toggle line (exclude from replace) |
| `<CR>` | Go to file |
| `<leader>R` | Replace all |
| `<leader>rc` | Replace current line |
| `<leader>q` | Send to quickfix |
| `<leader>o` | Show options |
| `<leader>v` | Change view mode |
| `<leader>l` | Resume last search |
| `ti` | Toggle ignore case |
| `th` | Toggle hidden files |

## Example Workflow

### Basic Search & Replace

```
1. Open Spectre
   <leader>sr

2. Enter search pattern
   oldFunction

3. Enter replacement
   newFunction

4. Review matches
   - Green = search match
   - Red = will be replaced

5. Toggle unwanted matches
   dd on lines to exclude

6. Replace all
   <leader>R
```

### Replace Word Under Cursor

```
1. Place cursor on word
2. Press <leader>sw
3. Spectre opens with word pre-filled
4. Enter replacement
5. <leader>R to replace all
```

### Replace in Current File Only

```
1. Press <leader>sp
2. Spectre opens scoped to current file
3. Faster for single-file refactors
```

## Search Options

### Regex Support

```
Search: foo\d+bar
Replace: baz

Matches: foo123bar, foo456bar
Result: baz, baz
```

### Case Sensitivity

Press `ti` to toggle ignore case:
- Case sensitive: `Foo` matches only `Foo`
- Ignore case: `Foo` matches `foo`, `FOO`, `Foo`

### Hidden Files

Press `th` to include hidden files (dotfiles).

## Advanced Usage

### Using Capture Groups

```
Search: (\w+)\.old
Replace: $1.new

Matches: file.old, config.old
Result: file.new, config.new
```

### Limit to File Types

Use glob patterns in the path field:
```
Path: **/*.js
```

### Exclude Directories

```
Path: !**/node_modules/**
```

## Tips

### Quick Refactoring Workflow

```
1. Use LSP rename (<leader>rn) for symbol renames
2. Use Spectre for text-based replacements
3. Combine: LSP for code, Spectre for strings/comments
```

### Preview Before Replacing

Always review the matches before `<leader>R`:
- Check context in the preview
- Toggle off false positives with `dd`
- Use `<CR>` to jump to file and verify

### Undo After Replace

Spectre modifies files directly. To undo:
- Use git: `git checkout -- .`
- Or undo in each file: `u`

## Troubleshooting

### No Results Found

- Check if ripgrep is installed: `which rg`
- Verify search pattern is correct
- Check path filter isn't too restrictive

### Replacement Not Working

- Ensure sed is installed: `which sed`
- Check for special characters (escape with `\`)
- Verify you have write permissions

### Panel Not Opening

- Check for plugin errors: `:messages`
- Ensure plenary.nvim is installed
- Try `:Spectre` command directly
