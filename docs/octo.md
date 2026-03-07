# Octo - GitHub Integration

> GitHub issues, pull requests, and reviews inside Neovim

## Quick Reference

| Component | Tool |
|-----------|------|
| Plugin | pwntester/octo.nvim |
| Picker | Telescope |
| Merge Method | squash |
| Requires | GitHub CLI (`gh`) |

## Keybindings

### Global (`<leader>go...`)

| Key | Action |
|-----|--------|
| `<leader>goi` | List Issues |
| `<leader>gop` | List PRs |
| `<leader>goc` | Create PR |
| `<leader>gor` | Start Review |
| `<leader>gos` | Search |

## Commands

| Command | Description |
|---------|-------------|
| `:Octo issue list` | List repository issues |
| `:Octo pr list` | List pull requests |
| `:Octo pr create` | Create a pull request |
| `:Octo review start` | Start a PR review |
| `:Octo search` | Search issues and PRs |

## Features

- Browse and manage GitHub issues
- Create, review, and merge pull requests
- Inline code review with comments
- Telescope-based picker for issues and PRs
- Default remote priority: upstream, then origin
- Missing `projects_v2` scope suppressed

## Usage

```
1. <leader>gop     -- List pull requests
2. Select a PR     -- Opens PR buffer
3. <leader>gor     -- Start reviewing
4. Add comments    -- Inline review comments
```

## Configuration

Located in `lua/plugins/octo.lua`

- Squash merge by default
- Local filesystem access disabled
- Built-in Octo buffer features enabled
