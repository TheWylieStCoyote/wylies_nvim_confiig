-- SQL Development Configuration
-- LSP (sqls), formatting, and database client support

return {
  -- TreeSitter parsers for SQL
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "sql",
      })
    end,
  },

  -- Mason: ensure SQL tools are installed
  -- Note: sqls may fail to install. Use :MasonInstall sqls manually if needed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        -- "sqls", -- May fail, install manually
        "sqlfluff",
        "sql-formatter",
      })
    end,
  },

  -- sqls.nvim for enhanced SQL features (requires sqls LSP - needs Go installed)
  { "nanotee/sqls.nvim", enabled = vim.fn.executable("sqls") == 1, lazy = true },

  -- sqls configuration (with sqls.nvim on_attach when available)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        sqls = {
          cmd = { "sqls" },
          filetypes = { "sql", "mysql", "plsql" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.root_pattern(".sqls.yaml", ".git")(fname) or vim.fn.getcwd()
          end,
          on_attach = function(client, bufnr)
            local ok, sqls = pcall(require, "sqls")
            if ok then
              sqls.on_attach(client, bufnr)
            end
          end,
          settings = {
            sqls = {
              connections = {
                -- Connections are typically configured in .sqls.yaml
                -- Example:
                -- {
                --   driver = "postgresql",
                --   dataSourceName = "host=localhost port=5432 user=postgres password=pass dbname=mydb sslmode=disable",
                -- },
              },
            },
          },
        },
      },
    },
  },

  -- Code formatting with sql-formatter
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        sql = { "sql_formatter" },
        mysql = { "sql_formatter" },
        plsql = { "sql_formatter" },
      },
      formatters = {
        sql_formatter = {
          command = "sql-formatter",
          args = {
            "--language",
            "postgresql",
            "--config",
            vim.fn.expand("~/.config/sql-formatter.json"),
          },
          stdin = true,
        },
      },
    },
  },

  -- Linting with sqlfluff
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        sql = { "sqlfluff" },
        mysql = { "sqlfluff" },
        plsql = { "sqlfluff" },
      },
    },
  },

  -- SQL-specific keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "SQL: " .. desc })
          end
          local vmap = function(keys, func, desc)
            vim.keymap.set("v", keys, func, { buffer = event.buf, desc = "SQL: " .. desc })
          end

          -- sqls commands (requires sqls.nvim)
          map("<leader>Sq", function()
            vim.cmd("SqlsExecuteQuery")
          end, "Execute Query")

          vmap("<leader>Sq", function()
            vim.cmd("SqlsExecuteQueryVertical")
          end, "Execute Selection")

          map("<leader>Ss", function()
            vim.cmd("SqlsShowDatabases")
          end, "Show Databases")

          map("<leader>St", function()
            vim.cmd("SqlsShowTables")
          end, "Show Tables")

          map("<leader>Sc", function()
            vim.cmd("SqlsShowConnections")
          end, "Show Connections")

          map("<leader>SC", function()
            vim.cmd("SqlsSwitchConnection")
          end, "Switch Connection")

          map("<leader>Sd", function()
            vim.cmd("SqlsSwitchDatabase")
          end, "Switch Database")

          map("<leader>Se", function()
            vim.cmd("SqlsDescribeTable")
          end, "Describe Table")

          -- PostgreSQL CLI
          map("<leader>Spp", function()
            local db = vim.fn.input("Database: ", "postgres")
            vim.cmd("split | terminal psql -d " .. db)
          end, "psql Connect")

          map("<leader>Spf", function()
            local file = vim.fn.expand("%")
            local db = vim.fn.input("Database: ", "postgres")
            vim.cmd("split | terminal psql -d " .. db .. " -f " .. file)
          end, "psql Execute File")

          -- MySQL CLI
          map("<leader>Smp", function()
            local db = vim.fn.input("Database: ")
            if db ~= "" then
              vim.cmd("split | terminal mysql -u root -p " .. db)
            else
              vim.cmd("split | terminal mysql -u root -p")
            end
          end, "mysql Connect")

          map("<leader>Smf", function()
            local file = vim.fn.expand("%")
            local db = vim.fn.input("Database: ")
            vim.cmd("split | terminal mysql -u root -p " .. db .. " < " .. file)
          end, "mysql Execute File")

          -- SQLite
          map("<leader>Slp", function()
            local db = vim.fn.input("SQLite file: ", vim.fn.getcwd() .. "/", "file")
            if db ~= "" then
              vim.cmd("split | terminal sqlite3 " .. db)
            end
          end, "sqlite3 Connect")

          map("<leader>Slf", function()
            local file = vim.fn.expand("%")
            local db = vim.fn.input("SQLite file: ", vim.fn.getcwd() .. "/", "file")
            vim.cmd("split | terminal sqlite3 " .. db .. " < " .. file)
          end, "sqlite3 Execute File")

          -- Formatting
          map("<leader>Sf", function()
            vim.lsp.buf.format()
          end, "Format Buffer")

          -- Linting
          map("<leader>Sx", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal sqlfluff lint " .. file)
          end, "Lint File")

          map("<leader>SL", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal sqlfluff fix " .. file)
            vim.cmd("e!")
          end, "Lint & Fix")

          -- Generate config files
          map("<leader>Si", function()
            local template = [[
# .sqls.yaml - SQL Language Server configuration
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
]]
            local file = io.open(".sqls.yaml", "w")
            if file then
              file:write(template)
              file:close()
              vim.cmd("edit .sqls.yaml")
              vim.notify("Created .sqls.yaml", vim.log.levels.INFO)
            end
          end, "Init .sqls.yaml")

          -- SQL templates
          map("<leader>Sn", function()
            local table_name = vim.fn.input("Table name: ")
            if table_name ~= "" then
              local template = string.format([[
-- Create table: %s
CREATE TABLE IF NOT EXISTS %s (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create index
CREATE INDEX idx_%s_created_at ON %s(created_at);

-- Add comment
COMMENT ON TABLE %s IS 'Description of %s table';
]], table_name, table_name, table_name, table_name, table_name, table_name)

              local lines = vim.split(template, "\n")
              vim.api.nvim_buf_set_lines(event.buf, -1, -1, false, lines)
            end
          end, "Insert CREATE TABLE")

          map("<leader>SN", function()
            local table_name = vim.fn.input("Table name: ")
            if table_name ~= "" then
              local template = string.format([[
-- Select from %s
SELECT *
FROM %s
WHERE 1=1
ORDER BY created_at DESC
LIMIT 100;
]], table_name, table_name)

              local lines = vim.split(template, "\n")
              vim.api.nvim_buf_set_lines(event.buf, -1, -1, false, lines)
            end
          end, "Insert SELECT")

          -- Code actions
          map("<leader>Sa", function()
            vim.lsp.buf.code_action()
          end, "Code Actions")

          map("<leader>Sh", function()
            vim.lsp.buf.hover()
          end, "Hover Info")
        end,
      })
    end,
  },
}
