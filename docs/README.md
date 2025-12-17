# Language Support Documentation

This Neovim configuration includes comprehensive LSP, formatting, linting, and debugging support for 27 languages.

## Quick Reference

| Language | LSP | Formatter | Linter | Debugger | Prefix | Doc |
|----------|-----|-----------|--------|----------|--------|-----|
| **Systems Programming** |
| C/C++ | clangd | clang-format | clang-tidy | codelldb | `<leader>c` | [cpp.md](cpp.md) |
| Rust | rust-analyzer | rustfmt | - | codelldb | `<leader>r` | [rust.md](rust.md) |
| Go | gopls | goimports | golangci-lint | delve | `<leader>g` | [go.md](go.md) |
| Zig | zls | zig fmt | - | codelldb | `<leader>z` | [zig.md](zig.md) |
| CUDA | clangd | clang-format | - | cuda-gdb | `<leader>c` | [cuda.md](cuda.md) |
| **Web & Backend** |
| TypeScript/JS | vtsls | prettier | eslint_d | js-debug | `<leader>t` | [typescript.md](typescript.md) |
| Python | pyright | ruff | ruff | debugpy | `<leader>p` | [python.md](python.md) |
| Ruby | ruby_lsp | rubocop | rubocop | rdbg | `<leader>R` | [ruby.md](ruby.md) |
| Elixir | elixir-ls | mix format | - | elixir-ls | `<leader>x` | [elixir.md](elixir.md) |
| Kotlin | kotlin-language-server | ktlint | ktlint | kotlin-debug | `<leader>k` | [kotlin.md](kotlin.md) |
| Java | jdtls | google-java-format | - | java-debug | `<leader>j` | [java.md](java.md) |
| C# | omnisharp | csharpier | - | netcoredbg | `<leader>n` | [csharp.md](csharp.md) |
| **Functional** |
| Haskell | haskell-language-server | ormolu | hlint | - | `<leader>h` | [haskell.md](haskell.md) |
| OCaml | ocamllsp | ocamlformat | - | earlybird | `<leader>o` | [ocaml.md](ocaml.md) |
| **Scientific/Data** |
| R | r-languageserver | styler | lintr | - | `<leader>r` | [r.md](r.md) |
| Julia | julials | JuliaFormatter | - | - | `<leader>j` | [julia.md](julia.md) |
| MATLAB/Octave | matlab-ls | - | - | - | `<leader>m` | [matlab.md](matlab.md) |
| **Hardware Description** |
| Verilog/SV | verible, svls | verible | verilator | - | `<leader>v` | [verilog.md](verilog.md) |
| VHDL | vhdl_ls | vsg | ghdl | - | `<leader>V` | [vhdl.md](vhdl.md) |
| **Scripting & Config** |
| Lua | lua_ls | stylua | - | - | `<leader>l` | [lua.md](lua.md) |
| Bash | bashls | shfmt | shellcheck | bash-debug | `<leader>b` | [bash.md](bash.md) |
| YAML/JSON/TOML | yamlls, jsonls, taplo | prettier | yamllint | - | `<leader>y/j/t` | [yaml-json.md](yaml-json.md) |
| **DevOps & Infrastructure** |
| Terraform | terraform-ls | terraform fmt | tflint, tfsec | - | `<leader>T` | [terraform.md](terraform.md) |
| Dockerfile | dockerls | - | hadolint | - | `<leader>d` | [dockerfile.md](dockerfile.md) |
| SQL | sqls | sql-formatter | sqlfluff | - | `<leader>S` | [sql.md](sql.md) |
| Protobuf | bufls | buf | buf, protolint | - | `<leader>p` | [protobuf.md](protobuf.md) |
| **Documentation** |
| LaTeX | texlab | latexindent | chktex | - | `<leader>L` | [latex.md](latex.md) |

## Installation

### 1. Sync Plugins
```vim
:Lazy sync
```

### 2. Install LSP Servers & Tools
```vim
:Mason
```

Then install the tools for your languages. Each language doc has specific Mason commands.

### 3. System Dependencies

Some languages require system-level tools. See individual language docs for details.

## Common Keybindings

These keybindings work across all languages via LSP:

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover documentation |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `<leader>cf` | Format buffer |
| `[d` / `]d` | Previous/next diagnostic |

## Debug Keybindings (DAP)

| Key | Action |
|-----|--------|
| `<F5>` | Start/Continue |
| `<F9>` | Toggle breakpoint |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<S-F11>` | Step out |

## File Structure

```
lua/plugins/
├── cpp.lua          # C/C++ configuration
├── rust.lua         # Rust configuration
├── python.lua       # Python configuration
├── ...              # One file per language
```

Each language config file contains:
- TreeSitter parser setup
- Mason tool installation
- LSP configuration
- Formatter setup (conform.nvim)
- Linter setup (nvim-lint)
- DAP debugger setup
- Language-specific keybindings
