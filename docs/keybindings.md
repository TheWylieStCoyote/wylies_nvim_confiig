# Neovim Keybindings Reference

> Complete reference for all keyboard shortcuts and key combinations

## Table of Contents

- [Leader Key Groups](#leader-key-groups)
- [Harpoon - Quick File Navigation](#harpoon---quick-file-navigation)
- [Copilot - AI Code Assistance](#copilot---ai-code-assistance)
- [Diffview - Git Diff Viewer](#diffview---git-diff-viewer)
- [Neogit - Git Interface](#neogit---git-interface)
- [Neotest - Test Runner](#neotest---test-runner)
- [Test Coverage](#test-coverage)
- [Debug Adapter Protocol (DAP)](#debug-adapter-protocol-dap)
- [Debug Print](#debug-print)
- [Todo Comments](#todo-comments)
- [Yazi - File Manager](#yazi---file-manager)
- [Refactoring](#refactoring)
- [TreeSitter Node Actions](#treesitter-node-actions)
- [Aerial - Code Outline](#aerial---code-outline)
- [Comment.nvim - Commenting](#commentnvim---commenting)
- [Multi-Cursors (vim-visual-multi)](#multi-cursors-vim-visual-multi)
- [Remote Development](#remote-development)
- [Language-Specific Keybindings](#language-specific-keybindings)
  - [Rust](#rust-development)
  - [Go](#go-development)
  - [Python](#python-development)
  - [C/C++](#cc-development)
  - [CUDA](#cuda-development)
  - [TypeScript/JavaScript](#typescriptjavascript-development)
  - [Java](#java-development)
  - [Lua](#lua-development)
  - [Bash](#bash-development)
  - [SQL](#sql-development)
  - [LaTeX](#latex-development)
  - [Docker](#docker-development)
  - [Terraform](#terraform-development)
- [Standard Navigation](#standard-navigation)
- [Folding (TreeSitter)](#folding-treesitter)

---

## Leader Key Groups

| Prefix | Group | Description |
|--------|-------|-------------|
| `<leader>a` | AI/Copilot | GitHub Copilot commands |
| `<leader>b` | Buffer | Buffer management |
| `<leader>c` | Code | Code actions, C++, CUDA, Crates, Node actions |
| `<leader>d` | Debug | Debugging (DAP), Debug print |
| `<leader>D` | Devcontainer | Container development |
| `<leader>f` | Find/Files | File finding and search |
| `<leader>g` | Git/Go | Git, Neogit, Go development |
| `<leader>h` | Harpoon | Quick file navigation |
| `<leader>l` | LSP/Lua | Language Server Protocol |
| `<leader>n` | C# | C# development |
| `<leader>o` | OCaml | OCaml development |
| `<leader>p` | Python | Python development |
| `<leader>r` | Remote/Rust/R/Refactor | Remote dev, Rust, R, Refactoring |
| `<leader>s` | Search | Search operations, TODOs |
| `<leader>t` | Test | Testing (Neotest), Coverage |
| `<leader>u` | UI/Toggle | UI toggles |
| `<leader>w` | Window | Window management |
| `<leader>x` | Diagnostics | Trouble/diagnostics, TODOs |
| `<leader>y` | Yazi | File manager |
| `<leader>z` | Zig | Zig development |
| `<leader>C` | CUDA Profile | CUDA profiling commands |
| `g?` | Debug Print | Insert debug print statements |
| `gn` | Node Action | TreeSitter node actions |

---

## Harpoon - Quick File Navigation

### File Management

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ha` | n | Add file to Harpoon |
| `<leader>hr` | n | Remove file from Harpoon |
| `<leader>hh` | n | Toggle Harpoon menu |
| `<leader>hc` | n | Clear all Harpoon entries |

### Quick Jump (1-5)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>1` | n | Jump to Harpoon file 1 |
| `<leader>2` | n | Jump to Harpoon file 2 |
| `<leader>3` | n | Jump to Harpoon file 3 |
| `<leader>4` | n | Jump to Harpoon file 4 |
| `<leader>5` | n | Jump to Harpoon file 5 |

### Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>hp` | n | Previous Harpoon file |
| `<leader>hn` | n | Next Harpoon file |
| `[h` | n | Previous Harpoon file |
| `]h` | n | Next Harpoon file |

### Slot Replacement

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>h1` | n | Replace slot 1 with current file |
| `<leader>h2` | n | Replace slot 2 with current file |
| `<leader>h3` | n | Replace slot 3 with current file |
| `<leader>h4` | n | Replace slot 4 with current file |
| `<leader>h5` | n | Replace slot 5 with current file |

---

## Copilot - AI Code Assistance

### Inline Suggestions

| Key | Mode | Description |
|-----|------|-------------|
| `<M-l>` | i | Accept suggestion |
| `<M-k>` | i | Accept word |
| `<M-j>` | i | Accept line |
| `<M-]>` | i | Next suggestion |
| `<M-[>` | i | Previous suggestion |
| `<C-]>` | i | Dismiss suggestion |

### Copilot Panel

| Key | Mode | Description |
|-----|------|-------------|
| `<M-CR>` | i | Open Copilot panel |
| `[[` | n | Jump to previous suggestion |
| `]]` | n | Jump to next suggestion |
| `<CR>` | n | Accept suggestion |
| `gr` | n | Refresh panel |

### Copilot Chat

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>aa` | n,v | Toggle Chat |
| `<leader>ax` | n | Reset Chat |
| `<leader>as` | n | Stop Output |
| `<leader>ae` | n,v | Explain Code |
| `<leader>ar` | n,v | Review Code |
| `<leader>af` | n,v | Fix Code |
| `<leader>ao` | n,v | Optimize Code |
| `<leader>ad` | n,v | Generate Docs |
| `<leader>at` | n,v | Generate Tests |
| `<leader>aD` | n | Fix Diagnostic |
| `<leader>ac` | n | Generate Commit Message |
| `<leader>aC` | n | Commit Staged Changes |
| `<leader>aq` | n,v | Quick Chat |
| `<leader>ap` | n,v | Prompt Actions |
| `<leader>ah` | n | Select Model |

### Copilot Management

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>cpe` | n | Enable Copilot |
| `<leader>cpd` | n | Disable Copilot |
| `<leader>cps` | n | Copilot Status |
| `<leader>cpp` | n | Open Copilot Panel |
| `<leader>cpt` | n | Toggle Suggestions |

---

## Diffview - Git Diff Viewer

### Main Commands

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gd` | n | Open Diffview |
| `<leader>gD` | n | Compare with HEAD~1 |
| `<leader>gc` | n | Close Diffview |
| `<leader>gh` | n | File history (current file) |
| `<leader>gH` | n | Branch history |
| `<leader>gB` | n | Compare with branch |
| `<leader>gf` | n | Toggle file panel |
| `<leader>gR` | n | Refresh Diffview |

### Visual Mode

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gh` | v | History for selection |

### Diff Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `<Tab>` | n | Next file |
| `<S-Tab>` | n | Previous file |
| `gf` | n | Open file |
| `<C-w><C-f>` | n | Open file (split) |
| `<C-w>gf` | n | Open file (tab) |
| `g<C-x>` | n | Cycle layout |
| `[x` | n | Previous conflict |
| `]x` | n | Next conflict |

### Conflict Resolution

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>co` | n | Choose OURS |
| `<leader>ct` | n | Choose THEIRS |
| `<leader>cb` | n | Choose BASE |
| `<leader>ca` | n | Choose ALL |
| `dx` | n | Delete conflict |
| `<leader>cO` | n | Choose OURS (all) |
| `<leader>cT` | n | Choose THEIRS (all) |
| `<leader>cB` | n | Choose BASE (all) |
| `<leader>cA` | n | Choose ALL (all) |
| `dX` | n | Delete all conflicts |

### File Panel

| Key | Mode | Description |
|-----|------|-------------|
| `j` / `<Down>` | n | Next entry |
| `k` / `<Up>` | n | Previous entry |
| `<CR>` / `o` | n | Open diff |
| `-` / `s` | n | Stage/unstage |
| `S` | n | Stage all |
| `U` | n | Unstage all |
| `X` | n | Restore entry |
| `L` | n | Open commit log |
| `zo` | n | Open fold |
| `zc` / `h` | n | Close fold |
| `za` | n | Toggle fold |
| `zR` | n | Open all folds |
| `zM` | n | Close all folds |
| `R` | n | Refresh files |
| `g?` | n | Help |

---

## Neogit - Git Interface

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gn` | n | Open Neogit |
| `<leader>gN` | n | Neogit (split) |
| `<leader>gl` | n | Neogit Log |
| `<leader>gp` | n | Neogit Push |
| `<leader>gP` | n | Neogit Pull |
| `<leader>gnc` | n | Neogit Commit |
| `<leader>gnb` | n | Neogit Branch |

### Neogit Status Buffer

| Key | Mode | Description |
|-----|------|-------------|
| `q` / `<Esc>` | n | Close |
| `<Tab>` | n | Toggle section |
| `1` - `4` | n | Set fold depth |

---

## Neotest - Test Runner

### Running Tests

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>tt` | n | Run nearest test |
| `<leader>tT` | n | Run current file tests |
| `<leader>ta` | n | Run all tests |
| `<leader>tl` | n | Run last test |
| `<leader>tf` | n | Run failed tests |

### Debugging Tests

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>td` | n | Debug nearest test |
| `<leader>tD` | n | Debug current file |

### Test Management

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ts` | n | Stop tests |
| `<leader>tw` | n | Toggle watch mode |
| `<leader>tm` | n | Mark test |
| `<leader>tM` | n | Run marked tests |

### Output & Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>to` | n | Show output |
| `<leader>tO` | n | Toggle output panel |
| `<leader>tS` | n | Toggle summary |
| `[t` | n | Previous failed test |
| `]t` | n | Next failed test |

---

## Test Coverage

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>tcl` | n | Load coverage data |
| `<leader>tcc` | n | Toggle coverage display |
| `<leader>tcs` | n | Coverage summary |
| `<leader>tcC` | n | Clear coverage |
| `<leader>tcL` | n | Load custom LCOV file |

---

## Debug Adapter Protocol (DAP)

### Session Control

| Key | Mode | Description |
|-----|------|-------------|
| `<F5>` | n | Continue/Start debugging |
| `<F10>` | n | Step over |
| `<F11>` | n | Step into |
| `<F12>` | n | Step out |
| `<S-F5>` | n | Terminate session |
| `<leader>dC` | n | Run to cursor |

### Breakpoints (Persistent)

| Key | Mode | Description |
|-----|------|-------------|
| `<F9>` | n | Toggle breakpoint (persisted) |
| `<leader>db` | n | Toggle breakpoint (persisted) |
| `<leader>dB` | n | Conditional breakpoint |
| `<leader>dL` | n | Log point |
| `<leader>dc` | n | Clear all breakpoints |

### UI

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>du` | n | Toggle DAP UI |
| `<leader>de` | n | Eval expression |
| `<leader>dE` | n,v | Eval expression (float) |
| `<leader>dr` | n | Toggle REPL |
| `<leader>ds` | n | View scopes |
| `<leader>df` | n | View frames |
| `<leader>dw` | n | View watches |

---

## Debug Print

Quick debug print statement insertion with debugprint.nvim.

| Key | Mode | Description |
|-----|------|-------------|
| `g?p` | n | Debug print below |
| `g?P` | n | Debug print above |
| `g?v` | n, v | Print variable below |
| `g?V` | n, v | Print variable above |
| `g?o` | n | Print text object below |
| `g?O` | n | Print text object above |
| `<C-G>p` | i | Insert plain debug print |
| `<C-G>v` | i | Insert variable print |
| `<leader>dP` | n | Toggle comment debug prints |
| `<leader>dX` | n | Delete all debug prints |

---

## Todo Comments

| Key | Mode | Description |
|-----|------|-------------|
| `]t` | n | Next TODO comment |
| `[t` | n | Previous TODO comment |
| `<leader>xt` | n | Todo list (Trouble) |
| `<leader>xT` | n | Todo/Fix/Fixme (Trouble) |
| `<leader>st` | n | Search TODOs (Telescope) |
| `<leader>sT` | n | Search TODO/FIX/FIXME |

**Recognized keywords:** `TODO:`, `FIX:`, `FIXME:`, `BUG:`, `HACK:`, `WARN:`, `PERF:`, `NOTE:`, `TEST:`

---

## Yazi - File Manager

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>y` | n | Yazi (current file) |
| `<leader>Y` | n | Yazi (cwd) |
| `<leader>fy` | n | Yazi File Manager |

### Inside Yazi

| Key | Description |
|-----|-------------|
| `<C-v>` | Open in vertical split |
| `<C-x>` | Open in horizontal split |
| `<C-t>` | Open in new tab |
| `<C-s>` | Grep in directory |
| `<C-y>` | Copy relative path |
| `<C-q>` | Send to quickfix |
| `<Tab>` | Cycle open buffers |

---

## Refactoring

### Extract (Visual Mode)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>re` | v | Extract Function |
| `<leader>rf` | v | Extract Function To File |
| `<leader>rv` | v | Extract Variable |

### Inline

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ri` | n, v | Inline Variable |
| `<leader>rI` | n | Inline Function |

### Block Extract (Normal Mode)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>rb` | n | Extract Block |
| `<leader>rB` | n | Extract Block To File |

### Refactoring Menu

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>rr` | n, v | Refactoring Menu (Telescope) |

### Debug Statements

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>rp` | n | Debug Print Below |
| `<leader>rP` | n | Debug Print Above |
| `<leader>rv` | n, v | Debug Print Variable |
| `<leader>rc` | n | Debug Cleanup |

---

## TreeSitter Node Actions

Context-aware code transformations using ts-node-action.

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>cn` | n | Node Action |
| `gn` | n | Node Action |

**Actions include:** Toggle boolean, cycle quotes, split/join blocks, expand/collapse ternary, and more (context-dependent).

---

## Aerial - Code Outline

Navigate code structure with a symbol sidebar.

### Global Keybindings

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>cs` | n | Toggle Aerial (Symbols sidebar) |
| `<leader>cS` | n | Toggle Aerial Nav (floating) |
| `[s` | n | Previous symbol |
| `]s` | n | Next symbol |
| `[[` | n | Previous parent symbol |
| `]]` | n | Next parent symbol |

### Aerial Window

| Key | Mode | Description |
|-----|------|-------------|
| `<CR>` | n | Jump to symbol |
| `<C-v>` | n | Jump in vertical split |
| `<C-s>` | n | Jump in horizontal split |
| `p` | n | Preview symbol (scroll) |
| `{` / `}` | n | Previous / Next symbol |
| `q` | n | Close Aerial |
| `?` | n | Show help |

### Tree Navigation (in Aerial)

| Key | Mode | Description |
|-----|------|-------------|
| `o` / `za` | n | Toggle fold |
| `l` / `zo` | n | Open node |
| `h` / `zc` | n | Close node |
| `zR` | n | Open all folds |
| `zM` | n | Close all folds |

---

## Comment.nvim - Commenting

Smart commenting with language-aware support.

### Toggle Comments

| Key | Mode | Description |
|-----|------|-------------|
| `gcc` | n | Toggle line comment |
| `gbc` | n | Toggle block comment |
| `gc` | v | Comment selection (line-wise) |
| `gb` | v | Block comment selection |

### Operator-Pending (with motion)

| Key | Mode | Description |
|-----|------|-------------|
| `gc{motion}` | n | Comment with motion (e.g., `gcap`) |
| `gb{motion}` | n | Block comment with motion |

### Extra Mappings

| Key | Mode | Description |
|-----|------|-------------|
| `gcO` | n | Add comment above |
| `gco` | n | Add comment below |
| `gcA` | n | Add comment at end of line |

---

## Multi-Cursors (vim-visual-multi)

Multiple cursors for simultaneous editing (VS Code style).

### Adding Cursors

| Key | Mode | Description |
|-----|------|-------------|
| `<C-n>` | n, v | Select word / Find next occurrence |
| `<C-S-n>` | n | Select all occurrences |
| `<C-Down>` | n | Add cursor below |
| `<C-Up>` | n | Add cursor above |

### Managing Cursors

| Key | Mode | Description |
|-----|------|-------------|
| `q` | n | Skip current match |
| `Q` | n | Remove current cursor |
| `u` | n | Undo |
| `<C-r>` | n | Redo |
| `<Esc>` | n | Exit multi-cursor mode |

---

## Remote Development

### Remote Neovim

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>rs` | n | Start remote connection |
| `<leader>rx` | n | Stop remote connection |
| `<leader>ri` | n | Remote info |
| `<leader>rc` | n | Cleanup remote resources |
| `<leader>rd` | n | Delete saved config |
| `<leader>rl` | n | View logs |

### Devcontainer

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>Ds` | n | Start devcontainer |
| `<leader>Da` | n | Attach to devcontainer |
| `<leader>De` | n | Execute in container |
| `<leader>Dx` | n | Stop container |
| `<leader>DX` | n | Stop all containers |
| `<leader>DR` | n | Remove all containers |
| `<leader>Dl` | n | View container logs |
| `<leader>Dc` | n | Edit config |
| `<leader>Du` | n | Docker compose up |
| `<leader>Dd` | n | Docker compose down |
| `<leader>Dr` | n | Docker compose remove |

---

## Language-Specific Keybindings

### Rust Development

#### Rustaceanvim

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>rr` | n | Runnables |
| `<leader>rt` | n | Testables |
| `<leader>rd` | n | Open docs.rs |
| `<leader>rc` | n | Open Cargo.toml |
| `<leader>rm` | n | Expand macro |
| `<leader>rp` | n | Parent module |
| `<leader>rj` | n | Join lines |
| `<leader>ra` | n | Code action |
| `<leader>re` | n | Explain error |
| `<leader>rh` | n | Hover actions |
| `<leader>rD` | n | Debuggables |

#### Crates.nvim (Cargo.toml)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>cu` | n | Update all crates |
| `<leader>cU` | n | Update single crate |
| `<leader>cf` | n | Show crate features |
| `<leader>cv` | n | Show crate versions |
| `<leader>cD` | n | Show dependencies |
| `<leader>cH` | n | Open homepage |
| `<leader>cR` | n | Open repository |
| `<leader>cd` | n | Open documentation |
| `<leader>cC` | n | Open crates.io |

### Go Development

#### Running & Testing

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gr` | n | Run package |
| `<leader>gR` | n | Run file |
| `<leader>gt` | n | Test package |
| `<leader>gT` | n | Test file |
| `<leader>gtt` | n | Test function |
| `<leader>Gc` | n | Show coverage |
| `<leader>GC` | n | Toggle coverage |

#### Code Generation

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gi` | n | Implement interface |
| `<leader>gf` | n | Fill struct |
| `<leader>ga` | n | Add tags |
| `<leader>gA` | n | Remove tags |
| `<leader>ge` | n | Generate if err |
| `<leader>gw` | n | Fill switch |

#### Go Modules

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gm` | n | Go mod tidy |
| `<leader>gM` | n | Go mod init |

#### Debugging

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>GD` | n | Debug |
| `<leader>gD` | n | Debug test |
| `<leader>gb` | n | Toggle breakpoint |
| `<leader>dgt` | n | Debug Go test |
| `<leader>dgl` | n | Debug last Go test |

#### Linting

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gl` | n | Lint |
| `<leader>gv` | n | Vet |
| `<leader>gp` | n | Fix plurals |

### Python Development

#### Virtual Environment

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>pv` | n | Select virtual environment |
| `<leader>pV` | n | Select cached venv |

#### Execution

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>pr` | n | Run file |
| `<leader>pi` | n | Run interactive |
| `<leader>pp` | n | Python REPL |

#### Debugging

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>pd` | v | Debug selection |
| `<leader>pt` | n | Debug test method |
| `<leader>pT` | n | Debug test class |

#### Ruff (Linting)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>po` | n | Organize imports |

### C/C++ Development

#### Clangd

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ch` | n | Switch source/header |
| `<leader>ci` | n | Symbol info |
| `<leader>ct` | n | Type hierarchy |
| `<leader>cm` | n | Memory usage |
| `<leader>ca` | n | View AST |

#### CMake

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>cg` | n | CMake generate |
| `<leader>cb` | n | CMake build |
| `<leader>cr` | n | CMake run |
| `<leader>cd` | n | CMake debug |
| `<leader>cs` | n | CMake select build type |
| `<leader>cq` | n | CMake close |
| `<leader>cC` | n | CMake clean |
| `<leader>ct` | n | CMake select target |
| `<leader>cT` | n | CMake select launch target |
| `<leader>cS` | n | CMake settings |

### CUDA Development

#### Compilation

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>cc` | n | Compile (nvcc) |
| `<leader>cC` | n | Compile (optimized) |
| `<leader>cg` | n | Compile (debug) |
| `<leader>ca` | n | Compile (specify arch) |
| `<leader>cr` | n | Run |
| `<leader>cR` | n | Compile & Run |

#### PTX/CUBIN

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>Cp` | n | Generate PTX |
| `<leader>cP` | n | Generate CUBIN |
| `<leader>cs` | n | Disassemble SASS |

#### Profiling

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>Cpr` | n | Profile (nvprof) |
| `<leader>Cpn` | n | Profile (nsys) |
| `<leader>Cpc` | n | Profile (ncu) |
| `<leader>Cpv` | n | Memory check |

#### GPU Info

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ci` | n | GPU info (nvidia-smi) |
| `<leader>cI` | n | GPU info (detailed) |
| `<leader>cd` | n | GPU device info |
| `<leader>cq` | n | Device query |

#### Templates

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>cn` | n | New kernel file |
| `<leader>cN` | n | New shared memory kernel |
| `<leader>ct` | n | New Thrust example |

#### Other

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>co` | n | Switch .cu/.cuh |
| `<leader>cdb` | n | Debug (cuda-gdb) |

### TypeScript/JavaScript Development

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>Ti` | n | Organize imports |
| `<leader>tu` | n | Remove unused imports |
| `<leader>ti` | n | Add missing imports |
| `<leader>tf` | n | Fix all |
| `<leader>tD` | n | Go to source definition |
| `<leader>tR` | n | File references |
| `<leader>tr` | n | Rename file |
| `<leader>tn` | n | npm run |
| `<leader>tt` | n | npm test |

### Java Development

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>jo` | n | Organize imports |
| `<leader>jv` | n | Extract variable |
| `<leader>jc` | n | Extract constant |
| `<leader>jm` | n | Extract method |
| `<leader>jt` | n | Test class |
| `<leader>jn` | n | Test nearest |
| `<leader>jb` | n | Build project |

### Lua Development

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>lx` | n | Execute file |
| `<leader>ls` | n | Source file |
| `<leader>le` | v | Evaluate selection |
| `<leader>li` | n | Inspect word |
| `<leader>lS` | n | Lua scratch buffer |

### Bash Development

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>br` | n | Run script |
| `<leader>bc` | n | Check syntax |
| `<leader>bs` | n | Source script |
| `<leader>bS` | n | Add shebang |
| `<leader>bx` | n | Make executable |

### SQL Development

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>se` | n,v | Execute query |
| `<leader>sE` | n | Execute file |
| `<leader>sd` | n | Describe table |
| `<leader>sl` | n | List tables |
| `<leader>sf` | n | Format SQL |
| `<leader>sc` | n | Show connections |
| `<leader>sC` | n | Switch connection |
| `<leader>si` | n | Init .sqls.yaml |

### LaTeX Development

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ll` | n | Compile |
| `<leader>lv` | n | View PDF |
| `<leader>le` | n | View errors |
| `<leader>lc` | n | Clean auxiliary |
| `<leader>lC` | n | Full clean |
| `<leader>lt` | n | TOC |
| `<leader>lw` | n | Word count |
| `<leader>la` | n | Insert article template |
| `<leader>lb` | n | Insert beamer template |

### Docker Development

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>db` | n | Build image |
| `<leader>dB` | n | Build (no cache) |
| `<leader>dr` | n | Run container |
| `<leader>ds` | n | Stop container |
| `<leader>dl` | n | View logs |
| `<leader>di` | n | Inspect |
| `<leader>dI` | n | Image history |
| `<leader>dp` | n | Push image |
| `<leader>dP` | n | Pull image |
| `<leader>de` | n | Exec into container |
| `<leader>du` | n | Compose up |
| `<leader>dU` | n | Compose up (build) |
| `<leader>dd` | n | Compose down |
| `<leader>dD` | n | Compose down (volumes) |

### Terraform Development

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ti` | n | Terraform init |
| `<leader>tp` | n | Terraform plan |
| `<leader>ta` | n | Terraform apply |
| `<leader>td` | n | Terraform destroy |
| `<leader>tv` | n | Terraform validate |
| `<leader>tf` | n | Terraform fmt |
| `<leader>ts` | n | Terraform state list |
| `<leader>to` | n | Terraform output |
| `<leader>tg` | n | Terraform graph |
| `<leader>tw` | n | Terraform workspace list |
| `<leader>tW` | n | Terraform workspace select |

---

## Standard Navigation

### Diagnostics

| Key | Mode | Description |
|-----|------|-------------|
| `[d` | n | Previous diagnostic |
| `]d` | n | Next diagnostic |
| `<leader>cd` | n | Line diagnostics |
| `<leader>xd` | n | Document diagnostics |
| `<leader>xw` | n | Workspace diagnostics |

### LSP Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `gd` | n | Go to definition |
| `gD` | n | Go to declaration |
| `gr` | n | Go to references |
| `gI` | n | Go to implementation |
| `gy` | n | Go to type definition |
| `K` | n | Hover documentation |
| `<C-k>` | n | Signature help |

### Search & Replace

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>sr` | n | Search and replace |
| `<leader>sw` | n | Search word |
| `<leader>sg` | n | Grep |
| `<leader>sf` | n | Find files |
| `<leader>sb` | n | Search buffers |

---

## Folding (TreeSitter)

Code folding using TreeSitter for syntax-aware folds.

### Fold Commands

| Key | Mode | Description |
|-----|------|-------------|
| `za` | n | Toggle fold under cursor |
| `zo` | n | Open fold |
| `zc` | n | Close fold |
| `zO` | n | Open all folds under cursor |
| `zC` | n | Close all folds under cursor |
| `zR` | n | Open all folds in buffer |
| `zM` | n | Close all folds in buffer |
| `zr` | n | Reduce fold level by one |
| `zm` | n | Increase fold level by one |
| `zj` | n | Move to next fold |
| `zk` | n | Move to previous fold |

### Fold Info

| Key | Mode | Description |
|-----|------|-------------|
| `zv` | n | View cursor line (open folds) |
| `zi` | n | Toggle foldenable |

---

## Notes

- **Mode Key**: `n` = Normal, `v` = Visual, `i` = Insert, `x` = Visual Block
- **Leader Key**: Default is `<Space>` (check your config)
- `<M-*>` = Alt + key
- `<C-*>` = Ctrl + key
- `<S-*>` = Shift + key
- Language-specific bindings are only active for their respective filetypes
- Some keybindings require the relevant plugin/LSP to be installed and active
