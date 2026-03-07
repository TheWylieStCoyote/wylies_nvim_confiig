# Various Text Objects - Extended Text Objects

30+ additional text objects for indentation, subwords, numbers, URLs, and more.

## Quick Reference

| Component | Value |
|-----------|-------|
| Plugin | chrisgrieser/nvim-various-textobjs |
| Event | VeryLazy |
| Keymaps | Default (plugin-provided) |

## Keybindings

Uses the plugin's default keymaps. All work in visual and operator-pending modes.

### Common Text Objects

| Key | Text Object |
|-----|-------------|
| `ii` / `ai` | Indentation (inner/outer) |
| `iS` / `aS` | Subword (camelCase/snake_case parts) |
| `in` / `an` | Number |
| `iD` / `aD` | Double square bracket `[[...]]` |
| `ik` / `ak` | Key (in key-value pair) |
| `iv` / `av` | Value (in key-value pair) |
| `iU` / `aU` | URL |
| `iL` / `aL` | Line (trimmed/full) |
| `ie` / `ae` | Entire buffer |
| `ig` / `ag` | Greedy outer indentation |
| `R` | Rest of indentation |

## Features

- All text objects work with standard operators (`d`, `c`, `y`, `v`)
- Inner (`i`) and outer (`a`) variants where applicable
- No additional configuration needed -- works out of the box

## Configuration

| Setting | Value |
|---------|-------|
| Default keymaps | Enabled |
| Disabled keymaps | None |
