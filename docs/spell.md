# Spell Checking

Spell checking for comments and strings in code files.

## Quick Reference

| Feature | Tool |
|---------|------|
| Plugin | Built-in + Treesitter |
| Language | en_us |
| Mode | Comments & Strings only |

## Keybindings

| Key | Mode | Action |
|-----|------|--------|
| `z=` | n | Show spelling suggestions |
| `]s` | n | Next misspelling |
| `[s` | n | Previous misspelling |
| `zg` | n | Add word to dictionary |
| `zw` | n | Mark word as wrong |
| `zug` | n | Undo add to dictionary |
| `zuw` | n | Undo mark as wrong |

## How It Works

### Treesitter Integration

Spell checking uses Treesitter to only check:
- Comments (single-line and multi-line)
- String literals
- Documentation strings

Code identifiers, keywords, and syntax are NOT spell-checked.

### CamelCase Support

The `spelloptions=camel` setting means:
- `getUserName` is checked as "get", "User", "Name"
- Each word in CamelCase is checked separately
- Reduces false positives for variable names

## Enabled Filetypes

Spell checking is enabled for:

### Code Files
- Lua
- Python
- JavaScript / TypeScript / React
- Rust
- Go
- C / C++
- Java
- Kotlin
- Ruby
- Elixir
- Haskell

### Documentation
- Markdown
- Plain text
- Git commits

### Disabled In
- Help files
- Terminal
- Plugin UIs (lazy, mason, etc.)
- Quickfix

## Usage

### Fix a Misspelling

```
1. See underlined word in comment
2. Move cursor to word
3. Press z=
4. Select correct spelling (number)
5. Word is replaced
```

### Navigate Misspellings

```
]s  -> Jump to next misspelling
[s  -> Jump to previous misspelling
```

### Add to Dictionary

```
1. Cursor on valid word marked as misspelled
2. Press zg
3. Word added to personal dictionary
4. No longer marked as wrong
```

### Mark as Wrong

```
1. Cursor on incorrectly spelled word
2. Press zw
3. Word marked as always wrong
```

## Example Workflow

```python
# This is a coment with a typo
#           ^^^^^^^
# 1. ]s jumps to "coment"
# 2. z= shows suggestions
# 3. Select "comment"
# 4. Fixed!

def get_usr_data():  # usr is not flagged (code)
    """Fetch user data from the databse."""
    #                              ^^^^^^^
    # "databse" is flagged in docstring
    pass
```

## Configuration

Settings in `lua/plugins/spell.lua`:

```lua
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }
vim.opt.spelloptions = "camel"
```

## Personal Dictionary

Words added with `zg` are saved to:
```
~/.local/share/nvim/spell/en.utf-8.add
```

You can edit this file directly to add/remove words.

## Tips

### Quick Fix Workflow

```
]s      -> Find next typo
z=      -> See suggestions
1-9     -> Pick correction
]s      -> Continue to next
```

### Batch Review

```
1. Open file
2. ]s to first misspelling
3. Fix or zg to add
4. Repeat until no more
```

### Disable Temporarily

```vim
:set nospell    " Disable
:set spell      " Enable
```

### Check Specific Word

```vim
:spellgood word   " Add to dictionary
:spellwrong word  " Mark as wrong
```

## Troubleshooting

### Too Many False Positives

Technical terms being flagged:
1. `zg` to add to dictionary
2. Or add to spell file directly

### Not Working in Comments

Ensure Treesitter parser is installed:
```vim
:TSInstall <language>
```

### Wrong Language

Change in `lua/plugins/spell.lua`:
```lua
vim.opt.spelllang = { "en_gb" }  -- British English
```
