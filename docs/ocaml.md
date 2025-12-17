# OCaml Development

> LSP: ocamllsp | Formatter: ocamlformat | Debugger: ocamlearlybird

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | ocamllsp (rust_hdl) |
| Formatter | ocamlformat |
| Debugger | ocamlearlybird |
| TreeSitter | ocaml, ocaml_interface, dune |

## Features

- Full ocamllsp integration
- Code lens
- Inlay hints
- Syntax documentation
- Dune build system integration
- Opam package management

## Keybindings

### Run & REPL

| Key | Action |
|-----|--------|
| `<leader>or` | Run with ocaml |
| `<leader>oi` | Utop REPL |
| `<leader>oI` | Utop with File |

### Dune

| Key | Action |
|-----|--------|
| `<leader>ob` | Dune Build |
| `<leader>oB` | Dune Build All |
| `<leader>ot` | Dune Test |
| `<leader>oT` | Dune Test (force) |
| `<leader>ox` | Dune Exec |
| `<leader>oX` | Dune Exec (project) |
| `<leader>oc` | Dune Clean |
| `<leader>ow` | Dune Watch |
| `<leader>on` | Dune Init Project |
| `<leader>oN` | Dune Init Library |
| `<leader>of` | Dune Format All |

### Opam

| Key | Action |
|-----|--------|
| `<leader>op` | Opam Install |
| `<leader>oP` | Opam Update/Upgrade |
| `<leader>os` | Opam Switch List |
| `<leader>oS` | Opam Switch Create |
| `<leader>ol` | Opam List Installed |

### Documentation

| Key | Action |
|-----|--------|
| `<leader>od` | Odig Documentation |
| `<leader>oD` | Dune Build Docs |

### Other

| Key | Action |
|-----|--------|
| `<leader>om` | Show Type |
| `<leader>oa` | Code Actions |
| `<leader>oE` | Signature Help |
| `<leader>oq` | Generate .mli |

## Installation

### Mason Packages
```vim
:MasonInstall ocaml-lsp ocamlformat
```

### System Requirements

**OCaml & Opam:**
```bash
# Arch
sudo pacman -S opam

# Initialize opam
opam init
eval $(opam env)

# Install tools
opam install ocaml-lsp-server ocamlformat utop dune
```

## Configuration

### ocamllsp Settings

- Code lens enabled
- Inlay hints enabled
- Syntax documentation enabled

### .ocamlformat

```
profile = default
version = 0.26.1
```

## Usage Examples

### Dune Project
1. `<leader>on` - Create new project
2. `<leader>ob` - Build
3. `<leader>oX` - Run

### Interactive Development
1. `<leader>oi` - Start utop
2. Test functions interactively

### Package Management
1. `<leader>op` - Install package
2. `<leader>oP` - Update all packages
