# Screenshots

Automated terminal recordings and screenshots using [VHS](https://github.com/charmbracelet/vhs).

## Prerequisites

- [VHS](https://github.com/charmbracelet/vhs) — `brew install vhs` / `go install github.com/charmbracelet/vhs@latest`
- [ffmpeg](https://ffmpeg.org/) — for GIF/MP4 rendering
- [ttyd](https://github.com/tsl0922/ttyd) — terminal emulator used by VHS

## Generate

```bash
./scripts/generate-screenshots.sh
```

Output lands in `screenshots/output/` (git-ignored) and is copied to `docs/img/`.

## Tapes

| Tape | Demos |
|------|-------|
| `startup.tape` | Dashboard, syntax highlighting, LSP hover, completion, which-key, neo-tree, aerial |
| `lsp.tape` | LSP hover, diagnostics |
| `telescope.tape` | File finder, live grep |
| `git.tape` | Neogit status, Diffview |
| `harpoon.tape` | Harpoon menu, file navigation |
| `themes.tape` | Catppuccin, Tokyo Night, Kanagawa |
| `ollama.tape` | ollama.nvim explain/review prompts, Avante sidebar with Ollama provider |
| `neotest.tape` | Test summary panel, run tests, output, coverage overlay |
| `dap.tape` | Breakpoints, DAP UI, watch expressions |
| `trouble.tape` | Workspace/buffer diagnostics, symbols panel, todo-comments |
| `copilot-chat.tape` | Copilot Chat sidebar, explain code |
| `navigation.tape` | Flash labeled jumps, Oil filesystem buffer, Yazi file manager |
| `ui-extras.tape` | Render-markdown styled preview, treesitter context, Zen Mode |
| `workflow.tape` | Multiple cursors, Neogen docstrings, Refactoring extract, NeoComposer macros |

## Adding a new tape

1. Create `screenshots/tapes/<feature>.tape`
2. Start with `Output screenshots/output/<feature>.gif`
3. Run `vhs screenshots/tapes/<feature>.tape` to test
4. Add a row to the table above

## CI

The `.github/workflows/screenshots.yml` workflow regenerates screenshots on push to `master` and commits the updated `docs/img/` files back to the branch.
