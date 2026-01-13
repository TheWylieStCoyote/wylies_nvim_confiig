# Database UI

Visual database browser and query executor using vim-dadbod.

## Quick Reference

| Feature | Tool |
|---------|------|
| Database Client | vim-dadbod |
| UI Browser | vim-dadbod-ui |
| Completion | vim-dadbod-completion |

## Keybindings

| Key | Action |
|-----|--------|
| `<leader>SD` | Toggle database UI sidebar |
| `<leader>SA` | Add new database connection |
| `<leader>SF` | Find database buffer |
| `<leader>Sq` | Execute query |

## Connection URL Formats

### PostgreSQL
```
postgresql://user:password@localhost:5432/database
postgresql://user@localhost/database
postgres:///database  # Local socket
```

### MySQL
```
mysql://user:password@localhost:3306/database
mysql://user@localhost/database
```

### SQLite
```
sqlite:///absolute/path/to/database.db
sqlite:database.db  # Relative path
sqlite::memory:     # In-memory database
```

### SQL Server
```
sqlserver://user:password@localhost:1433/database
```

## UI Navigation

When you open the database UI with `<leader>SD`, you'll see a sidebar:

```
Connections
  > mydb (postgresql)
    > Tables
        users
        posts
        comments
    > Views
    > Saved Queries
```

### Sidebar Keys

| Key | Action |
|-----|--------|
| `<CR>` | Expand/collapse or execute |
| `o` | Open item |
| `R` | Refresh |
| `d` | Delete saved query |
| `S` | Save query |
| `q` | Close UI |

## Table Helpers

When you expand a table, quick actions are available:

### PostgreSQL Helpers
| Helper | Query |
|--------|-------|
| Count | `SELECT COUNT(*) FROM {table}` |
| List | `SELECT * FROM {table} LIMIT 100` |
| Schema | `\d+ {table}` |
| Indexes | `SELECT * FROM pg_indexes WHERE tablename = '{table}'` |

### MySQL Helpers
| Helper | Query |
|--------|-------|
| Count | `SELECT COUNT(*) FROM {table}` |
| List | `SELECT * FROM {table} LIMIT 100` |
| Schema | `DESCRIBE {table}` |
| Indexes | `SHOW INDEX FROM {table}` |

### SQLite Helpers
| Helper | Query |
|--------|-------|
| Count | `SELECT COUNT(*) FROM {table}` |
| List | `SELECT * FROM {table} LIMIT 100` |
| Schema | `.schema {table}` |

## Example Workflow

### 1. Add a Connection

```
1. Press <leader>SA
2. Enter connection URL:
   sqlite:myproject.db
3. Press Enter
```

### 2. Browse Tables

```
1. Press <leader>SD to open sidebar
2. Navigate to your connection
3. Expand "Tables"
4. Select a table and press Enter on "List"
5. View results in split window
```

### 3. Write Custom Query

```
1. Open a new .sql file or query buffer
2. Write your SQL:

   SELECT u.name, COUNT(p.id) as post_count
   FROM users u
   LEFT JOIN posts p ON p.user_id = u.id
   GROUP BY u.id
   ORDER BY post_count DESC
   LIMIT 10;

3. Select the query (or place cursor on it)
4. Press <leader>Sq to execute
5. Results appear in split window
```

### 4. Save a Query

```
1. Write your query in a buffer
2. Press S in the DBUI sidebar
3. Enter a name for the query
4. Find it under "Saved Queries" later
```

## Completion

SQL completion is automatically enabled in `.sql`, `.mysql`, and `.plsql` files when connected to a database.

Completions include:
- Table names
- Column names
- SQL keywords
- Database-specific functions

## Configuration

Queries are saved in:
```
~/.local/share/nvim/db_ui/
```

## Troubleshooting

### Connection Failed
- Verify the connection URL format
- Check that the database server is running
- Ensure credentials are correct
- For PostgreSQL, check `pg_hba.conf` allows connections

### No Tables Showing
- Press `R` to refresh
- Verify you have permissions on the database
- Check you're connected to the correct database

### Completion Not Working
- Ensure you have a valid connection
- Check that the filetype is `sql`, `mysql`, or `plsql`
- Try `:set ft=sql` to force the filetype
