# Neogit

> Magit-like git interface for Neovim

## Quick Reference

| Component | Tool |
|-----------|------|
| Plugin | NeogitOrg/neogit |
| Dependencies | plenary.nvim, diffview.nvim, telescope.nvim |

## Keybindings

### Global

| Key | Description |
|-----|-------------|
| `<leader>gn` | Open Neogit |
| `<leader>gN` | Neogit (split) |
| `<leader>gl` | Neogit Log |
| `<leader>gp` | Neogit Push |
| `<leader>gP` | Neogit Pull |
| `<leader>gc` | Neogit Commit |
| `<leader>gb` | Neogit Branch |

### Status Buffer

| Key | Description |
|-----|-------------|
| `q` / `<Esc>` | Close |
| `<Tab>` | Toggle section fold |
| `1` - `4` | Set fold depth |
| `s` | Stage file/hunk |
| `u` | Unstage file/hunk |
| `x` | Discard changes |
| `c` | Commit popup |
| `p` | Push popup |
| `P` | Pull popup |
| `b` | Branch popup |
| `m` | Merge popup |
| `r` | Rebase popup |
| `f` | Fetch popup |
| `Z` | Stash popup |
| `$` | Show git command history |
| `g?` | Show help |

## Sections

The status buffer shows:
- **Untracked** - New files not in git
- **Unstaged** - Modified files not staged
- **Staged** - Files ready to commit
- **Stashes** - Stashed changes
- **Unpulled** - Commits to pull
- **Unmerged** - Commits to push
- **Recent** - Recent commits

## Commands

| Command | Description |
|---------|-------------|
| `:Neogit` | Open Neogit status |
| `:Neogit kind=split` | Open in split |
| `:Neogit log` | Open log view |
| `:Neogit commit` | Open commit popup |
| `:Neogit push` | Open push popup |
| `:Neogit pull` | Open pull popup |
| `:Neogit branch` | Open branch popup |

## Workflow Example

1. `<leader>gn` to open Neogit
2. Navigate to file with `j`/`k`
3. `s` to stage, `u` to unstage
4. `c` then `c` to commit
5. Write message, `<C-c><C-c>` to confirm
6. `p` then `p` to push

## Integrations

- **Diffview** - `d` on a file opens diffview
- **Telescope** - Branch/commit selection uses Telescope

## Configuration

Located in `lua/plugins/neogit.lua`

Features:
- Diffview integration
- Telescope integration
- Per-project settings
- Customizable sections
- GitHub/GitLab PR URL generation
