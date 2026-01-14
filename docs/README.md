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
| TypeScript/JS | vtsls | prettier | eslint_d | js-debug | `<leader>j` | [typescript.md](typescript.md) |
| Python | pyright | ruff | ruff | debugpy | `<leader>p` | [python.md](python.md) |
| Ruby | ruby_lsp | rubocop | rubocop | rdbg | `<leader>R` | [ruby.md](ruby.md) |
| Elixir | elixir-ls | mix format | - | elixir-ls | `<leader>x` | [elixir.md](elixir.md) |
| Kotlin | kotlin-language-server | ktlint | ktlint | kotlin-debug | `<leader>K` | [kotlin.md](kotlin.md) |
| Java | jdtls | google-java-format | - | java-debug | `<leader>J` | [java.md](java.md) |
| C# | omnisharp | csharpier | - | netcoredbg | `<leader>n` | [csharp.md](csharp.md) |
| **Functional** |
| Haskell | haskell-language-server | ormolu | hlint | - | `<leader>H` | [haskell.md](haskell.md) |
| OCaml | ocamllsp | ocamlformat | - | earlybird | `<leader>o` | [ocaml.md](ocaml.md) |
| **Scientific/Data** |
| R | r-languageserver | styler | lintr | - | `<leader>R` | [r.md](r.md) |
| Julia | julials | JuliaFormatter | - | - | `<leader>J` | [julia.md](julia.md) |
| MATLAB/Octave | matlab-ls | - | - | - | `<leader>m` | [matlab.md](matlab.md) |
| **Hardware Description** |
| Verilog/SV | verible, svls | verible | verilator | - | `<leader>v` | [verilog.md](verilog.md) |
| VHDL | vhdl_ls | vsg | ghdl | - | `<leader>V` | [vhdl.md](vhdl.md) |
| **Scripting & Config** |
| Lua | lua_ls | stylua | - | - | `<leader>l` | [lua.md](lua.md) |
| Bash | bashls | shfmt | shellcheck | bash-debug | `<leader>b` | [bash.md](bash.md) |
| YAML/JSON/TOML | yamlls, jsonls, taplo | prettier | yamllint | - | `<leader>y` | [yaml-json.md](yaml-json.md) |
| **DevOps & Infrastructure** |
| Terraform | terraform-ls | terraform fmt | tflint, tfsec | - | `<leader>T` | [terraform.md](terraform.md) |
| Dockerfile | dockerls | - | hadolint | - | `<leader>k` | [dockerfile.md](dockerfile.md) |
| SQL | sqls | sql-formatter | sqlfluff | - | `<leader>S` | [sql.md](sql.md) |
| Protobuf | bufls | buf | buf, protolint | - | `<leader>P` | [protobuf.md](protobuf.md) |
| **Documentation** |
| LaTeX | texlab | latexindent | chktex | - | `<leader>L` | [latex.md](latex.md) |
| **AI Assistants** |
| GitHub Copilot | copilot.lua | - | - | - | `<leader>a/cp` | [copilot.md](copilot.md) |
| Ollama (Local AI) | ollama.nvim | - | - | - | `<leader>O` | [ollama.md](ollama.md) |
| **Testing** |
| Neotest | neotest + adapters | - | - | DAP | `<leader>t` | [neotest.md](neotest.md) |
| **Navigation** |
| Harpoon | harpoon2 | - | - | - | `<leader>h`, `<leader>1-5` | [harpoon.md](harpoon.md) |
| Flash | flash.nvim | - | - | - | `s`, `S`, `f/F/t/T` | [flash.md](flash.md) |
| Treesitter Context | nvim-treesitter-context | - | - | - | `[c` | [treesitter-context.md](treesitter-context.md) |
| Which-Key | which-key.nvim | - | - | - | (auto) | [which-key.md](which-key.md) |
| **Git** |
| Diffview | diffview.nvim | - | - | - | `<leader>g` | [diffview.md](diffview.md) |
| Neogit | neogit | - | - | - | `<leader>g` | [neogit.md](neogit.md) |
| **Remote Development** |
| Remote Neovim | remote-nvim.nvim | - | - | - | `<leader>R` | [remote-nvim.md](remote-nvim.md) |
| Devcontainer | nvim-dev-container | - | - | - | `<leader>D` | [devcontainer.md](devcontainer.md) |
| **File Management** |
| Yazi | yazi.nvim | - | - | - | `<leader>y` | [yazi.md](yazi.md) |
| **Code Quality** |
| Trouble | trouble.nvim | - | - | - | `<leader>xx` | [trouble.md](trouble.md) |
| Spectre | nvim-spectre | - | - | - | `<leader>sr` | [spectre.md](spectre.md) |
| Todo Comments | todo-comments.nvim | - | - | - | `<leader>x/s` | [todo-comments.md](todo-comments.md) |
| Refactoring | refactoring.nvim | - | - | - | `<leader>e` | [refactoring.md](refactoring.md) |
| Node Actions | ts-node-action | - | - | - | `gn` | [ts-node-action.md](ts-node-action.md) |
| **Code Editing** |
| Code Outline | aerial.nvim | - | - | - | `<leader>cs` | [aerial.md](aerial.md) |
| Commenting | Comment.nvim | - | - | - | `gcc/gc/gbc` | [comment.md](comment.md) |
| Multi-Cursors | vim-visual-multi | - | - | - | `<C-n>` | [multicursors.md](multicursors.md) |
| **Utilities** |
| Session Management | auto-session | - | - | - | `<leader>q` | [sessions.md](sessions.md) |
| Database UI | vim-dadbod + UI | - | - | - | `<leader>S` | [database.md](database.md) |
| HTTP Client | rest.nvim | - | - | - | `<leader>r` | [http-client.md](http-client.md) |
| Statusline | lualine.nvim | - | - | - | - | [statusline.md](statusline.md) |
| Undotree | undotree | - | - | - | `<leader>U` | - |
| Lazy Profile | lazy.nvim | - | - | - | `<leader>up` | - |
| Zen Mode | zen-mode.nvim | - | - | - | `<leader>uz` | [zen-mode.md](zen-mode.md) |
| Better Quickfix | nvim-bqf | - | - | - | (auto) | [bqf.md](bqf.md) |
| Spell Checking | (built-in) | - | - | - | `z=`, `]s`, `[s` | [spell.md](spell.md) |
| **Testing & Debugging** |
| Test Coverage | nvim-coverage | - | - | - | `<leader>tc` | [coverage.md](coverage.md) |
| Debug Print | debugprint.nvim | - | - | - | `g?` | [debugprint.md](debugprint.md) |

**Note:** Some prefixes are shared between features (context-dependent by filetype):
- `<leader>R` - Ruby, R language, Remote-nvim
- `<leader>J` - Java, Julia
- `<leader>y` - YAML subcommands, Yazi file manager

## Additional Resources

- [Keybindings Reference](keybindings.md) - Complete keyboard shortcuts reference
- [Setup Guide](setup-guide.md) - System integration, terminal, tmux, dotfiles, workflow tips
- [Plugin Recommendations](plugin-recommendations.md) - Curated list of plugins to consider

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
