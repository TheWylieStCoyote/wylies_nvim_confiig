# Haskell Development

> LSP: haskell-language-server | Formatter: ormolu | Linter: hlint

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | haskell-language-server (HLS) |
| Formatter | ormolu |
| Linter | hlint |
| TreeSitter | haskell |

## Features

- Full HLS integration
- Wingman/Tactics code generation
- Type lenses
- HLint integration
- Eval plugin (run code in comments)
- Import management
- Case splitting
- Fill holes

## Keybindings

### Run & REPL

| Key | Action |
|-----|--------|
| `<leader>hr` | Run with runhaskell |
| `<leader>hR` | Run with runghc |
| `<leader>hi` | GHCi REPL |
| `<leader>hI` | GHCi with File |
| `<leader>hL` | GHCi Load File |

### Cabal

| Key | Action |
|-----|--------|
| `<leader>hb` | Cabal Build |
| `<leader>hB` | Cabal Build All |
| `<leader>ht` | Cabal Test |
| `<leader>hT` | Cabal Test (verbose) |
| `<leader>hx` | Cabal Run |
| `<leader>hc` | Cabal Clean |
| `<leader>hu` | Cabal Update |
| `<leader>hd` | Cabal Install |
| `<leader>hn` | Cabal Init |

### Stack

| Key | Action |
|-----|--------|
| `<leader>hSb` | Stack Build |
| `<leader>hSt` | Stack Test |
| `<leader>hSr` | Stack Run |
| `<leader>hSg` | Stack GHCi |
| `<leader>hN` | Stack New |

### Hoogle

| Key | Action |
|-----|--------|
| `<leader>hh` | Hoogle Search |
| `<leader>hH` | Hoogle Word |

### HLint & GHC

| Key | Action |
|-----|--------|
| `<leader>hl` | HLint File |
| `<leader>hg` | GHC Compile |
| `<leader>hG` | GHC Compile (optimized) |
| `<leader>hD` | Generate Haddock |

### LSP

| Key | Action |
|-----|--------|
| `<leader>hs` | Show Type |
| `<leader>ha` | Code Actions |

## Installation

### Mason Packages
```vim
:MasonInstall haskell-language-server ormolu hlint
```

### System Requirements

**GHC & Build Tools:**
```bash
# Arch
sudo pacman -S ghc cabal-install stack

# Or use ghcup (recommended)
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
```

## HLS Plugins

All major plugins enabled:
- `ghcide-*` - Core IDE features
- `hlint` - Style suggestions
- `tactics` - Wingman code generation
- `eval` - Evaluate code in comments
- `importLens` - Import management
- `rename` - Symbol renaming
- `splice` - Template Haskell
- `retrie` - Code refactoring

## Usage Examples

### Quick Development
1. `<leader>hi` - Start GHCi
2. Write code
3. `<leader>hb` - Build with Cabal

### Type-Driven Development
1. Write type signature
2. Use code actions to fill holes
3. `<leader>hs` - Check inferred types

### Search Documentation
1. `<leader>hh` - Search Hoogle
2. Enter type signature or function name
