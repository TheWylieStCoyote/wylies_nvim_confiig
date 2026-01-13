-- Database UI Configuration
-- Visual database browser and query executor using vim-dadbod

return {
  -- Core database interaction
  {
    "tpope/vim-dadbod",
    cmd = "DB",
    keys = {
      { "<leader>Sq", "<cmd>DB<cr>", desc = "Execute Query" },
    },
  },

  -- Database UI browser
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    keys = {
      { "<leader>SD", "<cmd>DBUIToggle<cr>", desc = "Toggle DB UI" },
      { "<leader>SA", "<cmd>DBUIAddConnection<cr>", desc = "Add DB Connection" },
      { "<leader>SF", "<cmd>DBUIFindBuffer<cr>", desc = "Find DB Buffer" },
    },
    init = function()
      -- UI Configuration
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_force_echo_notifications = 1

      -- Save location for queries
      vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"

      -- File type mappings
      vim.g.db_ui_execute_on_save = false

      -- Table helpers
      vim.g.db_ui_table_helpers = {
        postgresql = {
          Count = "SELECT COUNT(*) FROM {table}",
          List = "SELECT * FROM {table} LIMIT 100",
          Schema = "\\d+ {table}",
          Indexes = "SELECT * FROM pg_indexes WHERE tablename = '{table}'",
        },
        mysql = {
          Count = "SELECT COUNT(*) FROM {table}",
          List = "SELECT * FROM {table} LIMIT 100",
          Schema = "DESCRIBE {table}",
          Indexes = "SHOW INDEX FROM {table}",
        },
        sqlite = {
          Count = "SELECT COUNT(*) FROM {table}",
          List = "SELECT * FROM {table} LIMIT 100",
          Schema = ".schema {table}",
        },
      }
    end,
  },

  -- SQL Completion (integrates with existing completion setup)
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = { "tpope/vim-dadbod" },
    ft = { "sql", "mysql", "plsql" },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          -- Try to add dadbod completion source if using blink.cmp
          local ok, cmp = pcall(require, "cmp")
          if ok then
            cmp.setup.buffer({
              sources = {
                { name = "vim-dadbod-completion" },
                { name = "buffer" },
              },
            })
          end
        end,
      })
    end,
  },
}
