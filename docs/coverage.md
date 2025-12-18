# Test Coverage

> Display test coverage in the sign column

## Quick Reference

| Component | Tool |
|-----------|------|
| Plugin | andythigpen/nvim-coverage |
| Dependencies | plenary.nvim |

## Keybindings

| Key | Description |
|-----|-------------|
| `<leader>tcl` | Load coverage data |
| `<leader>tcc` | Toggle coverage display |
| `<leader>tcs` | Coverage summary |
| `<leader>tcC` | Clear coverage |
| `<leader>tcL` | Load custom LCOV file |

## Supported Languages

| Language | Coverage Tool | Default File |
|----------|---------------|--------------|
| Python | coverage.py | `.coverage` |
| Go | go test -cover | `coverage.out` |
| Rust | tarpaulin/llvm-cov | `target/coverage/lcov.info` |
| JavaScript/TypeScript | c8/nyc/jest | `coverage/lcov.info` |
| Ruby | simplecov | `coverage/coverage.json` |
| Elixir | excoveralls | `cover/excoveralls.json` |
| Java | jacoco | `target/site/jacoco/jacoco.xml` |
| C/C++ | gcov/lcov | `coverage/lcov.info` |

## Usage

### Generate Coverage

**Python:**
```bash
coverage run -m pytest
coverage json -o coverage.json
```

**Go:**
```bash
go test -coverprofile=coverage.out ./...
```

**Rust:**
```bash
cargo tarpaulin --out Lcov
```

**JavaScript/TypeScript:**
```bash
npx jest --coverage
# or
npx c8 npm test
```

### View in Neovim

1. Generate coverage with your test runner
2. `<leader>tcl` to load coverage data
3. Signs appear in the gutter:
   - Green `▎` = covered
   - Red `▎` = uncovered
   - Yellow `▎` = partial
4. `<leader>tcs` for summary

## Commands

| Command | Description |
|---------|-------------|
| `:Coverage` | Load and show coverage |
| `:CoverageLoad` | Load coverage data |
| `:CoverageLoadLcov <file>` | Load specific LCOV file |
| `:CoverageShow` | Show coverage signs |
| `:CoverageHide` | Hide coverage signs |
| `:CoverageToggle` | Toggle coverage display |
| `:CoverageSummary` | Show coverage summary |
| `:CoverageClear` | Clear coverage data |

## Configuration

Located in `lua/plugins/coverage.lua`

Features:
- Auto-reload on file change
- Minimum coverage threshold (80%)
- Customizable sign colors
- Multiple language support
