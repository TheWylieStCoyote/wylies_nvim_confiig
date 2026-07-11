# Plugin Gap Analysis

Recommendations filtered against the currently-installed plugin set (LazyVim base + the files in `lua/plugins/`). Unlike `plugin-recommendations.md` (which is a broad catalog), this is opinionated about what would actually fill a gap vs. what would overlap.

Date: 2026-05-08

## Already well-covered

LazyVim base plus: harpoon, flash, oil, yazi, neogit, octo, diffview, git-worktree, trouble, treesitter (+ context), mason, neotest, dap, dadbod, render-markdown, which-key, lualine, todo-comments, refactoring, multicursors, neogen, aerial, bqf, sessions, zen-mode, avante, copilot, ollama, neocomposer, http-client, overseer, debugprint, tiny-inline-diagnostic, various-textobjs, comment, spell, theme.

## Gaps worth filling

### Editing

| Plugin | Why it fills a gap |
|--------|-------------------|
| **nvim-spectre** | Project-wide search/replace with a real buffer UI. Telescope's replace can't compete for big refactors. |
| **yanky.nvim** | Clipboard ring + better paste behavior. Pairs well with the motion-heavy setup. |
| **nvim-surround** | Surround motions are the one editing primitive currently missing (unless picked up via mini). |
| **mini.ai** | Extended text objects. Overlaps with `various-textobjs` but is more composable — pick one. |

### Navigation / UI

| Plugin | Why it fills a gap |
|--------|-------------------|
| **noice.nvim** | Replaces cmdline/messages UI. Big QoL win, but invasive — try before committing. |
| **undotree** / **mundo** | Visualize undo tree. Surprisingly useful for recovery. |
| **grapple.nvim** | Harpoon alternative with branch/git-worktree awareness. Worth evaluating now that `git-worktree` is installed. |

### Notes / docs

| Plugin | Why it fills a gap |
|--------|-------------------|
| **obsidian.nvim** | If notes live in Markdown. Slots cleanly alongside the existing `render-markdown`. |
| **neorg** | Org-mode-style alternative to obsidian.nvim. Pick one, not both. |
| **markdown-preview.nvim** | Browser-based WYSIWYG; complements `render-markdown` for richer preview. |

## Skip / prune candidates

- **More AI plugins.** Already running copilot + avante + ollama + neocomposer + 99. Adding more is diminishing returns; consider pruning to whichever is actually used daily.
- **Overlapping motion/text-object plugins.** `flash` + `multicursors` + `various-textobjs` + a hypothetical `mini.ai` would all overlap. Decide which primitives matter and drop the rest.

## Added since this analysis

- **ThePrimeagen/99** (2026-05-08) — agentic AI workflow. BETA upstream. Shells out to `opencode` (default) or `claude` CLI. Configured in `lua/plugins/99.lua` under `<leader>9` prefix. Brings the active AI plugin count to 5 — see prune note above.

## Notes

- Several recommendations here (nvim-surround, mini.ai, undotree, noice, obsidian.nvim, markdown-preview, yanky) also appear in the broader `plugin-recommendations.md` catalog — this file's value is filtering them against what's already installed and flagging overlaps.
- LazyVim has [extras](http://www.lazyvim.org/extras) for many of these — check there first before writing a custom plugin spec.
