# Session Management

Automatically save and restore your Neovim sessions per project.

## Quick Reference

| Feature | Tool |
|---------|------|
| Plugin | auto-session |
| Storage | `~/.local/share/nvim/sessions/` |

## Keybindings

| Key | Action |
|-----|--------|
| `<leader>qS` | Save current session |
| `<leader>qR` | Restore session for current directory |
| `<leader>qD` | Delete current session |
| `<leader>qs` | Search/browse all sessions |
| `<leader>q.` | Restore session from file |

## How It Works

Sessions are saved **per directory** based on your project root (git root or cwd).

### What Gets Saved
- Open buffers
- Window layout and sizes
- Cursor positions
- Folds

### What Doesn't Get Saved
- Plugin UIs (neo-tree, Trouble, lazy, mason)
- Terminal buffers
- Unsaved changes (save files first!)

## Behavior

| Action | Behavior |
|--------|----------|
| Exit Neovim | Auto-saves if session exists |
| Open Neovim | Does NOT auto-restore (manual) |
| Save Session | Creates/updates session for cwd |

## Excluded Directories

Sessions are NOT created in these directories:
- `~/` (home directory)
- `~/Downloads`
- `~/Documents`
- `/` (root)

## Example Workflow

### First Time Setup

```
1. Open your project
   cd ~/projects/myapp && nvim

2. Open the files you work on
   - src/main.rs
   - src/lib.rs
   - Cargo.toml

3. Arrange your windows
   <C-w>v     (split vertical)
   <C-w>s     (split horizontal)

4. Save the session
   <leader>qS

5. Close Neovim
   :qa
```

### Returning to Work

```
1. Open Neovim in your project
   cd ~/projects/myapp && nvim

2. Restore your session
   <leader>qR

3. All your files and layout are back!
```

### Managing Multiple Sessions

```
1. Browse all saved sessions
   <leader>qs

2. Telescope picker opens
   - See all projects with sessions
   - Preview session details
   - Select to restore

3. Delete old sessions
   <leader>qD  (deletes current)
```

## Session Storage

Sessions are stored as Vim session files:

```
~/.local/share/nvim/sessions/
├── %Users%john%projects%webapp.vim
├── %Users%john%projects%api.vim
└── %Users%john%dotfiles.vim
```

The path is encoded in the filename (slashes become `%`).

## Tips

### Quick Project Switching

```
1. Save current session: <leader>qS
2. Search sessions: <leader>qs
3. Select another project
4. Instantly switch with full layout
```

### Session per Git Branch

Sessions are saved per directory, not per branch. If you want branch-specific sessions:

```
1. Create a worktree per branch
   git worktree add ../myapp-feature feature-branch

2. Open that directory
   cd ../myapp-feature && nvim

3. Save session there
   <leader>qS
```

### Clean Up Old Sessions

```
1. List session files
   :!ls ~/.local/share/nvim/sessions/

2. Delete manually
   :!rm ~/.local/share/nvim/sessions/old-session.vim
```

## Troubleshooting

### Session Not Restoring

- Ensure you're in the same directory where you saved
- Check that session file exists in `~/.local/share/nvim/sessions/`
- Try `<leader>q.` to restore from specific file

### Files Missing After Restore

- File paths may have changed
- Deleted files won't restore
- Relative paths require same cwd

### Layout Not Correct

- Terminal buffers aren't saved
- Plugin UIs (neo-tree) aren't saved
- Reopen these manually after restore
