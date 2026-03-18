# Neovim Configuration

A comprehensive Neovim configuration built on [LazyVim](https://github.com/LazyVim/LazyVim) with extensive multi-language support, modern development tools, and a focus on performance.

## Features

- **27+ Language Configurations** - LSP, formatting, linting, and debugging for major languages
- **Code Outline** - Navigate symbols with aerial.nvim (`<leader>cs`)
- **Smart Commenting** - Context-aware comments via Comment.nvim (`gcc`, `gc`)
- **Multiple Cursors** - VS Code-style multi-cursor editing (`<C-n>`)
- **TreeSitter Folding** - Syntax-aware code folding
- **Git Integration** - Diffview, Neogit, and gitsigns
- **Testing** - Unified test runner with Neotest (13 adapters)
- **Debugging** - Full DAP support with persistent breakpoints
- **AI Assistance** - GitHub Copilot integration
- **Remote Development** - SSH and container support

## Screenshots

![Dashboard & startup](docs/img/startup.gif)
![LSP & code intelligence](docs/img/lsp.gif)
![File & text search](docs/img/telescope.gif)
![Git workflow](docs/img/git.gif)
![Test runner](docs/img/neotest.gif)
![Debugger UI](docs/img/dap.gif)
![Local AI (ollama.nvim)](docs/img/ollama.gif)
![AI coding assistant](docs/img/avante.gif)
![Theme switching](docs/img/themes.gif)
![Editing workflow](docs/img/workflow.gif)

<details>
<summary>More screenshots</summary>

![Copilot Chat](docs/img/copilot-chat.gif)
![Harpoon navigation](docs/img/harpoon.gif)
![Trouble diagnostics](docs/img/trouble.gif)
![Navigation](docs/img/navigation.gif)
![UI extras](docs/img/ui-extras.gif)

</details>

## Quick Start

1. Clone this config to `~/.config/nvim`
2. Run `:Lazy sync` to install plugins
3. Run `:Mason` to install language servers

## Documentation

| Document | Description |
|----------|-------------|
| [docs/README.md](docs/README.md) | Language support quick reference |
| [docs/keybindings.md](docs/keybindings.md) | Complete keyboard shortcuts |
| [docs/setup-guide.md](docs/setup-guide.md) | Terminal, tmux, dotfiles configuration |
| [docs/plugin-recommendations.md](docs/plugin-recommendations.md) | Additional plugins to consider |

## Recent Additions

- **aerial.nvim** - Code outline and symbol navigation
- **Comment.nvim** - Smart commenting with JSX/TSX support
- **vim-visual-multi** - Multiple cursors
- **TreeSitter folding** - Syntax-aware folding

## Directory Structure

```
lua/
├── config/           # Core configuration
│   ├── options.lua   # Editor options
│   ├── keymaps.lua   # Global keymaps
│   ├── autocmds.lua  # Auto commands
│   └── lazy.lua      # Plugin manager setup
└── plugins/          # Plugin configurations
    ├── <language>.lua   # Per-language configs
    └── <plugin>.lua     # Per-plugin configs

docs/                 # Documentation
├── README.md         # Language quick reference
├── keybindings.md    # All keybindings
├── setup-guide.md    # System setup guide
└── <topic>.md        # Per-topic docs
```

## Supported Languages

**Systems:** C/C++, Rust, Go, Zig, CUDA
**Web/Backend:** TypeScript/JS, Python, Ruby, Elixir, Kotlin, Java, C#
**Functional:** Haskell, OCaml
**Scientific:** R, Julia, MATLAB
**Hardware:** Verilog, VHDL
**Config/Scripting:** Lua, Bash, YAML, JSON, TOML
**DevOps:** Terraform, Dockerfile, SQL, Protobuf
**Documentation:** LaTeX

## Key Plugins

| Category | Plugins |
|----------|---------|
| Completion | blink.cmp |
| LSP | nvim-lspconfig, mason.nvim |
| Navigation | telescope, harpoon, aerial |
| Git | gitsigns, diffview, neogit |
| Testing | neotest (13 adapters) |
| Debugging | nvim-dap, nvim-dap-ui |
| AI | copilot.lua, CopilotChat |

## Requirements

- Neovim 0.9+ (0.10+ recommended)
- A [Nerd Font](https://www.nerdfonts.com/)
- Git, ripgrep, fd
- Language-specific tools (see individual language docs)

## Theme

Default theme: **monokai-pro** (ristretto filter)

15+ themes available - switch with `:colorscheme <name>`
