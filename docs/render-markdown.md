# Render Markdown - In-Buffer Markdown Rendering

Live rendering of markdown elements directly in the buffer.

## Quick Reference

| Component | Value |
|-----------|-------|
| Plugin | MeanderingProgrammer/render-markdown.nvim |
| Dependencies | nvim-treesitter, nvim-web-devicons |
| Filetypes | markdown, norg, rmd, org |

## Keybindings

| Key | Action |
|-----|--------|
| `<leader>um` | Toggle Markdown Render |

## Features

- **Headings**: Nerd font icons (󰲡 through 󰲫) with sign column markers
- **Code blocks**: Full-width style with left/right/language padding
- **Bullets**: Nested list markers (● ○ ◆ ◇)
- **Checkboxes**: Unchecked 󰄱 and checked 󰱒 icons
- **Pipe tables**: Full-style rendering with borders
- **Links**: Hyperlink 󰌹 and image 󰥶 icons
- **LaTeX**: Disabled

## Configuration

### Rendering Elements

| Element | Style | Details |
|---------|-------|---------|
| Headings | Icons + signs | 󰲡 󰲣 󰲥 󰲧 󰲩 󰲫 |
| Code | Full | 1 char left/right/language pad |
| Bullets | 4 levels | ● ○ ◆ ◇ |
| Checkboxes | Icons | 󰄱 unchecked, 󰱒 checked |
| Tables | Full | Bordered pipe tables |
| Links | Icons | 󰌹 hyperlink, 󰥶 image |
| LaTeX | Disabled | -- |
