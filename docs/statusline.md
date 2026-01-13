# Statusline Enhancements

Custom statusline components added to lualine.

## Quick Reference

| Feature | Location |
|---------|----------|
| Plugin | lualine.nvim |
| Config | `lua/plugins/lualine.lua` |

## Components

### Macro Recording Indicator

When recording a macro, the statusline shows:

```
Recording @a
```

- Appears in pink/red for high visibility
- Shows which register is being recorded to
- Disappears when recording stops

#### How to Use Macros

```
1. Start recording
   qa          (record to register 'a')

2. Perform actions
   (your keystrokes are recorded)

3. Stop recording
   q

4. Play back macro
   @a          (play register 'a')
   @@          (repeat last macro)
   10@a        (play 10 times)
```

### Search Count Indicator

When searching, the statusline shows:

```
[3/15]
```

- Shows current match / total matches
- Appears in green
- Disappears when search is cleared (`<Esc>`)

#### How to Use Search

```
1. Start search
   /pattern    (search forward)
   ?pattern    (search backward)

2. Navigate matches
   n           (next match)
   N           (previous match)

3. See count in statusline
   [1/15] -> [2/15] -> [3/15]

4. Clear search
   <Esc>       (clears highlight)
```

### Copilot Status Indicator

Shows GitHub Copilot status:

| Icon | Meaning |
|------|---------|
| `` | Copilot active |
| `` | Copilot disabled |
| (none) | Copilot not attached to buffer |

## Statusline Layout

The default lualine layout with enhancements:

```
┌─────────────────────────────────────────────────────────────────┐
│ mode │ branch │ filename     │ ... │ Recording @a │ [3/15] │  │
└─────────────────────────────────────────────────────────────────┘
         Left                              Right (lualine_x)
```

## Customization

### Adding Your Own Components

Edit `lua/plugins/lualine.lua`:

```lua
opts = function(_, opts)
  -- Create your component function
  local function my_component()
    return "Hello"
  end

  -- Add to statusline
  opts.sections = opts.sections or {}
  opts.sections.lualine_x = opts.sections.lualine_x or {}
  table.insert(opts.sections.lualine_x, {
    my_component,
    cond = function() return true end,  -- When to show
    color = { fg = "#ff0000" },          -- Color
  })
end
```

### Component Options

| Option | Description |
|--------|-------------|
| `cond` | Function returning boolean (show/hide) |
| `color` | `{ fg = "#hex", bg = "#hex", gui = "bold" }` |
| `icon` | Icon to prepend |
| `padding` | Space around component |

### Available Sections

| Section | Position |
|---------|----------|
| `lualine_a` | Far left (mode) |
| `lualine_b` | Left (branch, diff) |
| `lualine_c` | Center-left (filename) |
| `lualine_x` | Center-right (encoding, filetype) |
| `lualine_y` | Right (progress) |
| `lualine_z` | Far right (location) |

## Theme Colors

Using Monokai Pro colors:

| Color | Hex | Use |
|-------|-----|-----|
| Pink | `#ff6188` | Warnings, recording |
| Green | `#a9dc76` | Success, search count |
| Blue | `#78dce8` | Info |
| Yellow | `#ffd866` | Modified |
| Orange | `#fc9867` | Errors |
| Purple | `#ab9df2` | Special |

## Example: Custom Git Status

```lua
local function git_status()
  local status = vim.b.gitsigns_status
  if status then
    return status
  end
  return ""
end

table.insert(opts.sections.lualine_x, {
  git_status,
  cond = function() return vim.b.gitsigns_status ~= nil end,
  color = { fg = "#a9dc76" },
})
```

## Example: LSP Status

```lua
local function lsp_status()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients > 0 then
    return " " .. clients[1].name
  end
  return ""
end

table.insert(opts.sections.lualine_x, {
  lsp_status,
  cond = function()
    return #vim.lsp.get_clients({ bufnr = 0 }) > 0
  end,
  color = { fg = "#78dce8" },
})
```
