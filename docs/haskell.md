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

## Keybindings (`<leader>H...`)

### Run & REPL

| Key | Action |
|-----|--------|
| `<leader>Hr` | Run with runhaskell |
| `<leader>HR` | Run with runghc |
| `<leader>Hi` | GHCi REPL |
| `<leader>HI` | GHCi with File |
| `<leader>HL` | GHCi Load File |

### Cabal

| Key | Action |
|-----|--------|
| `<leader>Hb` | Cabal Build |
| `<leader>HB` | Cabal Build All |
| `<leader>Ht` | Cabal Test |
| `<leader>HT` | Cabal Test (verbose) |
| `<leader>Hx` | Cabal Run |
| `<leader>Hc` | Cabal Clean |
| `<leader>Hu` | Cabal Update |
| `<leader>Hd` | Cabal Install |
| `<leader>Hn` | Cabal Init |

### Stack

| Key | Action |
|-----|--------|
| `<leader>HSb` | Stack Build |
| `<leader>HSt` | Stack Test |
| `<leader>HSr` | Stack Run |
| `<leader>HSg` | Stack GHCi |
| `<leader>HN` | Stack New |

### Hoogle

| Key | Action |
|-----|--------|
| `<leader>Hh` | Hoogle Search |
| `<leader>HH` | Hoogle Word |

### HLint & GHC

| Key | Action |
|-----|--------|
| `<leader>Hl` | HLint File |
| `<leader>Hg` | GHC Compile |
| `<leader>HG` | GHC Compile (optimized) |
| `<leader>HD` | Generate Haddock |

### LSP

| Key | Action |
|-----|--------|
| `<leader>Hs` | Show Type |
| `<leader>Ha` | Code Actions |

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
1. `<leader>Hi` - Start GHCi
2. Write code
3. `<leader>Hb` - Build with Cabal

### Type-Driven Development
1. Write type signature
2. Use code actions to fill holes
3. `<leader>Hs` - Check inferred types

### Search Documentation
1. `<leader>Hh` - Search Hoogle
2. Enter type signature or function name
