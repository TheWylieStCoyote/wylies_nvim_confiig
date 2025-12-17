# Neovim Setup Guide

A comprehensive guide to optimizing your Neovim environment beyond plugins.

## Table of Contents

1. [Health Checks](#health-checks)
2. [Fonts & Terminal](#fonts--terminal)
3. [System Integration](#system-integration)
4. [Shell Configuration](#shell-configuration)
5. [Tmux Integration](#tmux-integration)
6. [Dotfiles Management](#dotfiles-management)
7. [Performance Optimization](#performance-optimization)
8. [Custom Configuration](#custom-configuration)
9. [Workflow Tips](#workflow-tips)
10. [Learning Resources](#learning-resources)

---

## Health Checks

### Run Neovim Health Check

```vim
:checkhealth
```

This checks:
- Neovim version and build
- Clipboard support
- Python/Node/Ruby providers
- LSP servers
- TreeSitter parsers
- Plugin health

### Fix Common Issues

```bash
# Clipboard support (Arch)
sudo pacman -S xclip  # X11
sudo pacman -S wl-clipboard  # Wayland

# Python provider
pip install pynvim

# Node provider
npm install -g neovim

# Ruby provider (optional)
gem install neovim
```

### Verify LSP Servers

```vim
:LspInfo          " Show active LSP clients
:Mason            " Check installed tools
:MasonLog         " View installation logs
```

### Verify TreeSitter

```vim
:TSInstallInfo    " Show installed parsers
:TSUpdate         " Update all parsers
```

---

## Fonts & Terminal

### Install Nerd Fonts

Nerd Fonts include icons used by many plugins (neo-tree, lualine, etc.).

```bash
# Arch
sudo pacman -S ttf-jetbrains-mono-nerd
sudo pacman -S ttf-firacode-nerd
sudo pacman -S ttf-hack-nerd

# Or download from
# https://www.nerdfonts.com/font-downloads

# Popular choices:
# - JetBrains Mono Nerd Font
# - FiraCode Nerd Font
# - Hack Nerd Font
# - Iosevka Nerd Font
# - CaskaydiaCove Nerd Font (Cascadia Code)
```

### Terminal Emulator Recommendations

| Terminal | Platform | Notes |
|----------|----------|-------|
| **Kitty** | Linux/Mac | GPU-accelerated, highly configurable |
| **Alacritty** | Cross-platform | Fast, minimal, GPU-accelerated |
| **WezTerm** | Cross-platform | Lua config, multiplexer built-in |
| **Ghostty** | Linux/Mac | New, fast, Zig-based |
| **foot** | Linux (Wayland) | Lightweight, fast |
| **Windows Terminal** | Windows | Modern Windows terminal |
| **iTerm2** | Mac | Feature-rich Mac terminal |

### Terminal Configuration

**Kitty (~/.config/kitty/kitty.conf):**
```conf
font_family JetBrainsMono Nerd Font
font_size 12.0
enable_audio_bell no
window_padding_width 4
confirm_os_window_close 0

# Colors (example: Catppuccin)
include themes/catppuccin-mocha.conf
```

**Alacritty (~/.config/alacritty/alacritty.toml):**
```toml
[font]
normal = { family = "JetBrainsMono Nerd Font", style = "Regular" }
size = 12.0

[window]
padding = { x = 4, y = 4 }
```

### True Color Support

Verify your terminal supports true colors:

```bash
# Test true color
curl -s https://raw.githubusercontent.com/JohnMorber/dotfiles/master/colors/24-bit-color.sh | bash
```

Add to shell config if needed:
```bash
export TERM=xterm-256color
# Or for tmux
export TERM=tmux-256color
```

---

## System Integration

### Set Neovim as Default Editor

```bash
# ~/.bashrc or ~/.zshrc
export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="nvim"

# Git
git config --global core.editor "nvim"

# For systemd (edit units)
export SYSTEMD_EDITOR="nvim"
```

### Desktop File Association (Linux)

```bash
# Set nvim as default for text files
xdg-mime default nvim.desktop text/plain
xdg-mime default nvim.desktop text/x-python
# etc.
```

### Clipboard Integration

```lua
-- In your Neovim config (lua/config/options.lua)
vim.opt.clipboard = "unnamedplus"  -- Use system clipboard
```

For SSH sessions:
```bash
# Install xclip/xsel or use OSC 52
# LazyVim supports OSC 52 for remote clipboard
```

### File Manager Integration

Open files from file manager in existing Neovim:

```bash
# Using neovim-remote (pip install neovim-remote)
nvr --remote-tab-silent file.txt

# Or use Neovim's built-in server
nvim --server /tmp/nvim.sock --remote file.txt
```

---

## Shell Configuration

### Useful Aliases

```bash
# ~/.bashrc or ~/.zshrc

# Neovim
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias nv="nvim"

# Quick config edit
alias vimrc="nvim ~/.config/nvim/init.lua"
alias nvimrc="nvim ~/.config/nvim/"

# Open in existing nvim (requires neovim-remote)
alias vr="nvr --remote-tab-silent"

# Diff with nvim
alias vimdiff="nvim -d"

# Quick notes
alias notes="nvim ~/notes/"
alias todo="nvim ~/notes/todo.md"

# Project shortcuts
alias dev="cd ~/dev && nvim ."
```

### Shell Functions

```bash
# Open nvim with fzf file finder
vf() {
  local file
  file=$(fzf --preview 'bat --color=always {}' --preview-window=right:60%)
  [[ -n "$file" ]] && nvim "$file"
}

# Open nvim at specific line (usage: vl file.py 42)
vl() {
  nvim "+$2" "$1"
}

# Open nvim with grep result
vg() {
  local file line
  read -r file line <<< $(rg --line-number "$1" | fzf | awk -F: '{print $1, $2}')
  [[ -n "$file" ]] && nvim "+$line" "$file"
}

# Create and open new file with directory
vn() {
  mkdir -p "$(dirname "$1")" && nvim "$1"
}
```

### Zsh Integration

```bash
# Enable vi mode in zsh
bindkey -v

# Edit command line in nvim (ctrl-x ctrl-e)
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line
```

---

## Tmux Integration

### Tmux Configuration

```bash
# ~/.tmux.conf

# True color support
set -g default-terminal "tmux-256color"
set -ag terminal-overrides ",xterm-256color:RGB"

# Neovim recommendations
set -sg escape-time 10
set -g focus-events on

# Vi mode
setw -g mode-keys vi

# Smart pane switching with vim awareness
is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'

# Resize panes with vim awareness
bind-key -n 'M-h' if-shell "$is_vim" 'send-keys M-h' 'resize-pane -L 5'
bind-key -n 'M-j' if-shell "$is_vim" 'send-keys M-j' 'resize-pane -D 5'
bind-key -n 'M-k' if-shell "$is_vim" 'send-keys M-k' 'resize-pane -U 5'
bind-key -n 'M-l' if-shell "$is_vim" 'send-keys M-l' 'resize-pane -R 5'
```

### Neovim Tmux Plugin

Add smart-splits or vim-tmux-navigator:

```lua
-- lua/plugins/tmux.lua
return {
  {
    "mrjones2014/smart-splits.nvim",
    opts = {},
    keys = {
      { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "Move to left pane" },
      { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "Move to below pane" },
      { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "Move to above pane" },
      { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Move to right pane" },
    },
  },
}
```

---

## Dotfiles Management

### Git Repository

```bash
# Initialize dotfiles repo
mkdir ~/dotfiles
cd ~/dotfiles
git init

# Structure
dotfiles/
├── nvim/           # -> ~/.config/nvim
├── tmux/           # -> ~/.config/tmux or ~/.tmux.conf
├── kitty/          # -> ~/.config/kitty
├── zsh/            # -> ~/.zshrc, etc.
├── git/            # -> ~/.gitconfig
├── scripts/        # Setup scripts
└── install.sh      # Installation script
```

### Symlink Management

**Using stow (recommended):**
```bash
sudo pacman -S stow
cd ~/dotfiles

# Each folder becomes a package
stow nvim    # Links nvim/ to ~/.config/nvim
stow tmux    # Links tmux/ to ~/.tmux.conf
```

**Manual symlinks:**
```bash
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
```

### Backup Neovim Config

```bash
# Add to dotfiles
cp -r ~/.config/nvim ~/dotfiles/nvim

# Exclude generated files in .gitignore
# ~/dotfiles/nvim/.gitignore
lazy-lock.json
.luarc.json
.neoconf.json
spell/
```

### Sync Across Machines

```bash
# On new machine
git clone https://github.com/username/dotfiles ~/dotfiles
cd ~/dotfiles
./install.sh   # Or use stow
```

---

## Performance Optimization

### Profile Startup Time

```bash
# Measure startup time
nvim --startuptime startup.log
nvim startup.log

# Or use vim-startuptime plugin
:StartupTime
```

### Lazy Loading Best Practices

```lua
-- Load on command
{ "plugin/name", cmd = "PluginCommand" }

-- Load on keymap
{ "plugin/name", keys = { "<leader>x" } }

-- Load on filetype
{ "plugin/name", ft = { "lua", "python" } }

-- Load on event
{ "plugin/name", event = "VeryLazy" }  -- After UI
{ "plugin/name", event = "BufReadPost" }  -- After reading file
{ "plugin/name", event = "InsertEnter" }  -- On insert mode
```

### Reduce Installed Plugins

```vim
:Lazy profile    " See load times
:Lazy clean      " Remove unused plugins
```

### Disable Unused Providers

```lua
-- lua/config/options.lua
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
```

---

## Custom Configuration

### Project-Local Config

Create `.nvim.lua` in project root for project-specific settings:

```lua
-- /path/to/project/.nvim.lua
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
```

Enable in Neovim config:
```lua
vim.opt.exrc = true  -- Enable project-local config
```

### Custom Commands

```lua
-- lua/config/autocmds.lua

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Auto-resize splits on window resize
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Return to last edit position
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
```

### Custom Keymaps

```lua
-- lua/config/keymaps.lua

local map = vim.keymap.set

-- Better movement
map("n", "j", "gj")  -- Move by visual line
map("n", "k", "gk")

-- Center after jump
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Quick save
map("n", "<C-s>", ":w<CR>")
map("i", "<C-s>", "<Esc>:w<CR>a")

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move lines
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Quick escape
map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")

-- Clear search highlight
map("n", "<Esc>", ":noh<CR>")

-- Buffer navigation
map("n", "<Tab>", ":bnext<CR>")
map("n", "<S-Tab>", ":bprevious<CR>")

-- Split navigation (without plugin)
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Quickfix navigation
map("n", "]q", ":cnext<CR>")
map("n", "[q", ":cprev<CR>")
```

### Abbreviations

```lua
-- lua/config/autocmds.lua

-- Typo corrections
vim.cmd("iabbrev teh the")
vim.cmd("iabbrev adn and")
vim.cmd("iabbrev waht what")

-- Quick snippets
vim.cmd("iabbrev @@ your@email.com")
vim.cmd("iabbrev ccopy Copyright 2025, All Rights Reserved.")

-- Date/time
vim.cmd([[iabbrev <expr> ddate strftime("%Y-%m-%d")]])
vim.cmd([[iabbrev <expr> ttime strftime("%H:%M")]])
```

---

## Workflow Tips

### Must-Know Commands

```vim
" Navigation
gd          " Go to definition
gr          " Find references
K           " Hover documentation
<C-o>       " Jump back
<C-i>       " Jump forward

" Editing
ciw         " Change inner word
yi"         " Yank inside quotes
da(         " Delete around parens
va{         " Select around braces

" Search
/pattern    " Search forward
?pattern    " Search backward
*           " Search word under cursor
:%s/old/new/g  " Replace all

" Windows
<C-w>s      " Split horizontal
<C-w>v      " Split vertical
<C-w>o      " Close other windows
<C-w>=      " Equal size windows

" Tabs
:tabnew     " New tab
gt          " Next tab
gT          " Previous tab
```

### Useful Ex Commands

```vim
:earlier 5m     " Undo to 5 minutes ago
:later 5m       " Redo to 5 minutes later
:sort           " Sort lines
:sort u         " Sort and remove duplicates
:g/pattern/d    " Delete lines matching pattern
:v/pattern/d    " Delete lines NOT matching pattern
:%!jq .         " Format JSON with external command
:%!sort         " Sort with external command
:r !date        " Insert command output
:w !sudo tee %  " Save with sudo
```

### Registers

```vim
"ayy        " Yank to register a
"ap         " Paste from register a
"+y         " Yank to system clipboard
"+p         " Paste from system clipboard
"0p         " Paste last yank (not delete)
:reg        " View all registers
```

### Macros

```vim
qa          " Start recording to register a
q           " Stop recording
@a          " Play macro a
@@          " Repeat last macro
10@a        " Play macro 10 times
```

### Marks

```vim
ma          " Set mark a
'a          " Jump to line of mark a
`a          " Jump to exact position of mark a
:marks      " List all marks
''          " Jump to last position
'.          " Jump to last edit
```

---

## Learning Resources

### Official Documentation

- `:help` - Built-in help (comprehensive)
- `:Tutor` - Interactive tutorial
- [Neovim Documentation](https://neovim.io/doc/)
- [LazyVim Documentation](https://lazyvim.org)

### Books & Guides

- [Practical Vim](https://pragprog.com/titles/dnvim2/practical-vim-second-edition/) - Drew Neil
- [Learn Vim the Smart Way](https://github.com/iggredible/Learn-Vim) - Free online book
- [Vim Tips Wiki](https://vim.fandom.com/wiki/Vim_Tips_Wiki)

### Videos & Courses

- [ThePrimeagen](https://www.youtube.com/@ThePrimeagen) - Vim motions, workflows
- [TJ DeVries](https://www.youtube.com/@telooj) - Neovim core developer
- [chris@machine](https://www.youtube.com/@chrisatmachine) - Plugin tutorials
- [Vim as IDE](https://www.youtube.com/watch?v=Gs1VDYnS-Ac) - Development setup

### Practice

- [Vim Adventures](https://vim-adventures.com/) - Game to learn Vim
- [Open Vim](https://www.openvim.com/) - Interactive tutorial
- [Vim Golf](https://www.vimgolf.com/) - Solve challenges in fewest keystrokes

### Communities

- [r/neovim](https://reddit.com/r/neovim) - Reddit community
- [Neovim Discourse](https://neovim.discourse.group/) - Official forum
- [Neovim Matrix/Gitter](https://matrix.to/#/#neovim:matrix.org) - Chat

---

## Checklist

### Essential Setup

- [ ] Run `:checkhealth` and fix issues
- [ ] Install a Nerd Font
- [ ] Configure terminal for true color
- [ ] Set Neovim as default editor
- [ ] Configure clipboard integration
- [ ] Set up dotfiles repository

### Recommended

- [ ] Configure tmux integration
- [ ] Add useful shell aliases
- [ ] Create project-local config template
- [ ] Learn basic Vim motions
- [ ] Customize keymaps for your workflow

### Advanced

- [ ] Profile and optimize startup time
- [ ] Create custom snippets
- [ ] Set up debugging configurations
- [ ] Configure language-specific settings
- [ ] Automate with custom commands
