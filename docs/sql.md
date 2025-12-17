# SQL Development

> LSP: sqls | Formatter: sql-formatter | Linter: sqlfluff

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | sqls |
| Formatter | sql-formatter |
| Linter | sqlfluff |
| TreeSitter | sql |

## Features

- sqls language server
- sqls.nvim integration
- Multi-database support (PostgreSQL, MySQL, SQLite)
- Query execution
- Schema browsing
- sqlfluff linting

## Keybindings

### sqls Commands (`<leader>S...`)

| Key | Action |
|-----|--------|
| `<leader>Sq` | Execute Query |
| `<leader>Sq` (visual) | Execute Selection |
| `<leader>Ss` | Show Databases |
| `<leader>St` | Show Tables |
| `<leader>Sc` | Show Connections |
| `<leader>SC` | Switch Connection |
| `<leader>Sd` | Switch Database |
| `<leader>SD` | Describe Table |

### PostgreSQL

| Key | Action |
|-----|--------|
| `<leader>Spp` | psql Connect |
| `<leader>Spf` | psql Execute File |

### MySQL

| Key | Action |
|-----|--------|
| `<leader>Smp` | mysql Connect |
| `<leader>Smf` | mysql Execute File |

### SQLite

| Key | Action |
|-----|--------|
| `<leader>Slp` | sqlite3 Connect |
| `<leader>Slf` | sqlite3 Execute File |

### Formatting & Linting

| Key | Action |
|-----|--------|
| `<leader>Sf` | Format Buffer |
| `<leader>Sl` | Lint File |
| `<leader>SL` | Lint & Fix |

### Templates

| Key | Action |
|-----|--------|
| `<leader>Si` | Init .sqls.yaml |
| `<leader>Sn` | Insert CREATE TABLE |
| `<leader>SN` | Insert SELECT |

### LSP

| Key | Action |
|-----|--------|
| `<leader>Sa` | Code Actions |
| `<leader>Sh` | Hover Info |

## Installation

### Mason Packages
```vim
:MasonInstall sqls sqlfluff sql-formatter
```

### System Requirements

```bash
# Arch - PostgreSQL
sudo pacman -S postgresql

# Arch - MySQL/MariaDB
sudo pacman -S mariadb

# Arch - SQLite
sudo pacman -S sqlite

# Python tools
pip install sqlfluff
```

## Configuration

### .sqls.yaml

```yaml
# SQL Language Server configuration
lowercaseKeywords: false
connections:
  - alias: "postgres_local"
    driver: "postgresql"
    proto: "tcp"
    user: "postgres"
    passwd: "password"
    host: "localhost"
    port: 5432
    dbName: "postgres"
    params: {}
  - alias: "mysql_local"
    driver: "mysql"
    proto: "tcp"
    user: "root"
    passwd: "password"
    host: "localhost"
    port: 3306
    dbName: "mysql"
    params: {}
  - alias: "sqlite_local"
    driver: "sqlite3"
    dataSourceName: "./database.db"
```

### sql-formatter.json

```json
{
  "language": "postgresql",
  "tabWidth": 2,
  "keywordCase": "upper",
  "linesBetweenQueries": 2
}
```

### .sqlfluff

```ini
[sqlfluff]
dialect = postgres
templater = raw
max_line_length = 120

[sqlfluff:rules]
comma_style = trailing
```

## SQL Templates

### CREATE TABLE
Generated with `<leader>Sn`:
```sql
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_users_created_at ON users(created_at);

COMMENT ON TABLE users IS 'Description of users table';
```

### SELECT
Generated with `<leader>SN`:
```sql
SELECT *
FROM users
WHERE 1=1
ORDER BY created_at DESC
LIMIT 100;
```

## Usage Examples

### Query Development
1. Open SQL file
2. `<leader>Si` - Init connection config
3. `<leader>SC` - Select connection
4. Write query
5. `<leader>Sq` - Execute

### Database Exploration
1. `<leader>Ss` - List databases
2. `<leader>Sd` - Switch database
3. `<leader>St` - List tables
4. `<leader>SD` - Describe table

### Code Quality
1. `<leader>Sl` - Lint file
2. `<leader>SL` - Auto-fix issues
3. `<leader>Sf` - Format
