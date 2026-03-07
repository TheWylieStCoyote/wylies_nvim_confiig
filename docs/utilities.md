# Utilities - Undotree and Lazy.nvim

Undotree visualization and Lazy.nvim plugin manager shortcuts.

## Quick Reference

| Component | Value |
|-----------|-------|
| Undotree | mbbill/undotree |
| Package Manager | folke/lazy.nvim |

## Keybindings

### Undotree

| Key | Action |
|-----|--------|
| `<leader>U` | Toggle Undotree |

### Lazy.nvim

| Key | Action |
|-----|--------|
| `<leader>up` | Profile Startup |
| `<leader>ul` | Open Lazy |
| `<leader>us` | Sync Plugins |
| `<leader>uc` | Check Updates |

## Features

### Undotree

- Visual undo history as a tree with diff panel
- Tree panel on the left, diff panel below
- Automatically focuses the tree when toggled open
- Short time indicators for compact display

### Lazy.nvim

- `Profile` shows startup timing for each plugin
- `Sync` installs, updates, and cleans plugins in one step
- `Check` shows available updates without installing

## Configuration

### Undotree Layout

| Setting | Value |
|---------|-------|
| Layout | Tree left, diff below (layout 2) |
| Tree width | 30 columns |
| Diff panel height | 10 rows |
| Focus on toggle | Yes |
| Short indicators | Yes |
