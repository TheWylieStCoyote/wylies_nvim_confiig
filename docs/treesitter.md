# TreeSitter

Manual-only parser installation to avoid CPU spikes on startup.

## Quick Reference

| Command / Setting    | Purpose                                  |
|----------------------|------------------------------------------|
| `:TSInstall <parser>`| Install a specific parser manually       |
| `auto_install`       | Set to `false` — no auto-install         |
| `sync_install`       | Set to `false` — no synchronous installs |

## Source

`lua/plugins/treesitter.lua`

## Configuration

Both `auto_install` and `sync_install` are disabled on the
`nvim-treesitter/nvim-treesitter` plugin. This prevents TreeSitter
from compiling parsers during startup, which can cause noticeable
CPU spikes and freeze the editor on slower machines.

### Installing Parsers

Use the `:TSInstall` command followed by the parser name:

```vim
:TSInstall python
:TSInstall rust lua javascript
```

### Extending ensure_installed

Language plugin files (e.g. `lua/plugins/lang/*.lua`) can add
parsers to the `ensure_installed` list through LazyVim's `opts`
merging, so each language file declares exactly which parsers it
needs.
