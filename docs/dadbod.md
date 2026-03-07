# Dadbod - Database Browser and Query Executor

Visual database browser with SQL completion and table helpers.

## Quick Reference

| Component | Value |
|-----------|-------|
| Core | tpope/vim-dadbod |
| UI | kristijanhusak/vim-dadbod-ui |
| Completion | kristijanhusak/vim-dadbod-completion |
| Query Storage | `stdpath("data")/db_ui` |

## Keybindings

| Key | Action |
|-----|--------|
| `<leader>SD` | Toggle DB UI |
| `<leader>SA` | Add DB Connection |
| `<leader>SF` | Find DB Buffer |

## Features

- Visual database browser with tree-style navigation
- SQL query execution against configured databases
- Nerd font icons for database objects
- Saved queries persist to `stdpath("data")/db_ui`
- Execute-on-save disabled by default

### Built-in Table Helpers

| Helper | PostgreSQL | MySQL | SQLite |
|--------|-----------|-------|--------|
| Count | `SELECT COUNT(*)` | `SELECT COUNT(*)` | `SELECT COUNT(*)` |
| List | `SELECT * LIMIT 100` | `SELECT * LIMIT 100` | `SELECT * LIMIT 100` |
| Schema | `\d+ {table}` | `DESCRIBE {table}` | `.schema {table}` |
| Indexes | `pg_indexes` query | `SHOW INDEX` | -- |

### SQL Completion

Completion is provided via blink.cmp for the following filetypes:

| Filetype | Source |
|----------|--------|
| sql | dadbod |
| mysql | dadbod |
| plsql | dadbod |

## Configuration

| Setting | Value |
|---------|-------|
| Nerd fonts | Enabled |
| Database icon | Shown |
| Echo notifications | Forced |
| Execute on save | Disabled |
| Save location | `stdpath("data")/db_ui` |
