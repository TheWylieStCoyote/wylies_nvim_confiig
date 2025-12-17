# Which-Key - Keybinding Hints

> Displays a popup with available keybindings as you type

## Quick Reference

| Component | Tool |
|-----------|------|
| Plugin | folke/which-key.nvim |
| Trigger | Any incomplete key sequence |
| Delay | 300ms (configurable) |

## Features

- **Keybinding Discovery** - Shows available keys after pressing a prefix
- **Group Labels** - Organized categories for related bindings
- **Operator Help** - Shows motions after d, y, c, etc.
- **Mark/Register Preview** - Shows marks with `'` and registers with `"`
- **Spelling Suggestions** - Shows options with `z=`

## How It Works

1. Press a key like `<leader>`
2. Wait 300ms (or keep typing)
3. Popup appears showing all available continuations
4. Press the next key to execute, or `<Esc>` to cancel

## Registered Groups

### Leader Key Groups (`<leader>...`)

| Prefix | Group |
|--------|-------|
| `<leader>a` | AI/Copilot |
| `<leader>b` | Buffer |
| `<leader>c` | Code/C++ |
| `<leader>d` | Debug/Docker |
| `<leader>f` | Find/Files |
| `<leader>g` | Git |
| `<leader>h` | Harpoon |
| `<leader>l` | LSP/Lua |
| `<leader>n` | Notifications/C# |
| `<leader>o` | OCaml |
| `<leader>p` | Python/Protobuf |
| `<leader>r` | Remote/Rust/R |
| `<leader>s` | Search |
| `<leader>t` | Test/TypeScript |
| `<leader>u` | UI/Toggle |
| `<leader>w` | Window |
| `<leader>x` | Diagnostics/Elixir |
| `<leader>z` | Zig |

### Language Prefixes (Uppercase)

| Prefix | Language |
|--------|----------|
| `<leader>B` | Bash |
| `<leader>D` | Dockerfile |
| `<leader>H` | Haskell |
| `<leader>J` | Java/Julia |
| `<leader>K` | Kotlin |
| `<leader>L` | LaTeX |
| `<leader>M` | MATLAB |
| `<leader>R` | Ruby |
| `<leader>S` | SQL |
| `<leader>T` | Terraform |
| `<leader>V` | VHDL |

### Bracket Navigation

| Prefix | Action |
|--------|--------|
| `[` | Previous (diagnostic, hunk, conflict, etc.) |
| `]` | Next (diagnostic, hunk, conflict, etc.) |

### Goto Prefix

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `gf` | Go to file |

## Built-in Presets

Which-key shows help for these built-in Vim features:

### Operators
After pressing `d`, `y`, `c`, `>`, `<`, etc., shows available motions and text objects.

### Marks
Press `'` or `` ` `` to see all marks:
- `'a` - Jump to mark a (line)
- `` `a `` - Jump to mark a (exact position)

### Registers
Press `"` in normal mode or `<C-r>` in insert mode:
- `"a` - Use register a
- `"+` - System clipboard
- `"0` - Yank register

### Spelling
Press `z=` on a misspelled word to see suggestions.

### Folds
Press `z` to see fold commands:
- `za` - Toggle fold
- `zo` - Open fold
- `zc` - Close fold
- `zR` - Open all folds
- `zM` - Close all folds

### Window Management
Press `<C-w>` to see window commands:
- `<C-w>s` - Split horizontal
- `<C-w>v` - Split vertical
- `<C-w>h/j/k/l` - Navigate windows
- `<C-w>q` - Close window

## Usage Examples

### Discover Git Commands

```
<leader>g               " Press leader then g
                        " Wait for popup
                        " See: d=Diffview, h=History, B=Branch compare, etc.
```

### Discover Harpoon Commands

```
<leader>h               " Press leader then h
                        " See: a=Add, r=Remove, h=Menu, f=Telescope, etc.
```

### Discover Test Commands

```
<leader>t               " Press leader then t
                        " See: n=Run nearest, f=Run file, s=Run suite, etc.
```

### See Available Motions

```
d                       " Press d (delete operator)
                        " See: w=word, $=end of line, iw=inner word, etc.
```

### Quick File Navigation

```
<leader>                " Press leader
                        " See: 1-5 for Harpoon files
```

## Configuration

### Change Delay

Edit `lua/plugins/which-key.lua`:

```lua
opts = {
  delay = 500, -- Wait 500ms before showing popup
}
```

### Disable for Certain Modes

```lua
opts = {
  disable = {
    ft = { "TelescopePrompt" }, -- Disable in Telescope
    bt = { "terminal" }, -- Disable in terminals
  },
}
```

### Add Custom Groups

```lua
config = function(_, opts)
  local wk = require("which-key")
  wk.setup(opts)

  wk.add({
    { "<leader>m", group = "My Custom Group" },
    { "<leader>ma", desc = "Custom action A" },
    { "<leader>mb", desc = "Custom action B" },
  })
end
```

## Popup Navigation

While the popup is open:

| Key | Action |
|-----|--------|
| `<Esc>` | Close popup |
| `<BS>` | Go back one key |
| `<Down>` / `j` | Scroll down |
| `<Up>` / `k` | Scroll up |

## Tips

### Press Slowly to Discover

If you're unsure what keys are available, type slowly and let the popup appear.

### Use Telescope for Full List

```vim
:Telescope keymaps
```

Shows all keymaps with fuzzy search.

### Check Health

```vim
:checkhealth which-key
```

### Debugging

If a keymap isn't showing:

```lua
-- In config, enable debug mode
opts = {
  debug = true,
}
```

Then check `:messages` for warnings.

## See Also

- [Which-Key GitHub](https://github.com/folke/which-key.nvim)
- [Telescope Keymaps](https://github.com/nvim-telescope/telescope.nvim)
