# Mason Package Manager

Manual-only package management to keep startup fast and predictable.

## Quick Reference

| Command / Setting             | Purpose                                    |
|-------------------------------|--------------------------------------------|
| `:Mason`                      | Open Mason UI to install packages manually |
| `automatic_installation`      | Set to `false` — no auto-install on open   |
| Language `opts.ensure_installed` | Language files extend the install list   |

## Source

`lua/plugins/mason.lua`

## Configuration

Mason and mason-lspconfig are configured with all auto-installation
disabled. This prevents unexpected downloads and startup delays.

### Dependency-Gated LSP Handlers

mason-lspconfig uses custom handlers that skip server setup when
required system dependencies are missing:

| Server              | Required Binary | Skipped When Missing |
|---------------------|-----------------|----------------------|
| `gopls`             | `go`            | Yes                  |
| `hls`               | `ghcup`         | Yes                  |
| `ocamllsp`          | `opam`          | Yes                  |
| `r_language_server` | `R`             | Yes                  |

Each handler checks `vim.fn.executable()` and returns early if the
binary is not found, preventing lspconfig errors on machines that
lack that language toolchain.

### Extending ensure_installed

Language plugin files (e.g. `lua/plugins/lang/*.lua`) can append to
Mason's `ensure_installed` list through LazyVim's `opts` merging.
Mason itself declares an empty `ensure_installed` so language files
are the sole source of truth.
