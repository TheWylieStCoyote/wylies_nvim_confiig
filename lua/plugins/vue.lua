-- Vue Development Configuration
-- LSP (vue_ls / Volar in hybrid mode + @vue/typescript-plugin via vtsls),
-- formatting (prettier), and linting (eslint).
--
-- Hybrid mode: vue_ls handles the Vue-specific parts of a .vue file while the
-- @vue/typescript-plugin is injected into vtsls so TypeScript works inside the
-- <script> block. This relies on the vtsls config in typescript.lua.

-- Skip entire Vue config if Node.js is not installed
if vim.fn.executable("node") ~= 1 then
  return {}
end

-- Path to the @vue/language-server bundled with the Mason vue-language-server package.
-- The @vue/typescript-plugin ships inside this package's dependency tree.
local vue_language_server_path = vim.fn.stdpath("data")
  .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_language_server_path,
  languages = { "vue" },
  configNamespace = "typescript",
}

return {
  -- TreeSitter parser for Vue (css/html/scss already pulled in by other configs)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "vue",
        "css",
        "scss",
        "html",
      })
    end,
  },

  -- Mason: ensure the Vue language server is installed
  -- (prettier / eslint_d are already requested by typescript.lua)
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "vue-language-server",
      })
    end,
  },

  -- LSP: enable vue_ls and wire the Vue TS plugin into vtsls (hybrid mode)
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      -- vue_ls (Volar) runs in hybrid mode by default in Volar 2.x
      opts.servers.vue_ls = opts.servers.vue_ls or {}

      -- Inject @vue/typescript-plugin into the existing vtsls config so that
      -- TypeScript inside <script setup> / <script lang="ts"> resolves correctly.
      local vtsls = opts.servers.vtsls or {}

      -- Make vtsls attach to .vue files
      vtsls.filetypes = vtsls.filetypes or {}
      if not vim.tbl_contains(vtsls.filetypes, "vue") then
        table.insert(vtsls.filetypes, "vue")
      end

      -- Register the global plugin
      vtsls.settings = vtsls.settings or {}
      vtsls.settings.vtsls = vtsls.settings.vtsls or {}
      vtsls.settings.vtsls.tsserver = vtsls.settings.vtsls.tsserver or {}
      local plugins = vtsls.settings.vtsls.tsserver.globalPlugins or {}
      local has_vue_plugin = false
      for _, p in ipairs(plugins) do
        if p.name == "@vue/typescript-plugin" then
          has_vue_plugin = true
          break
        end
      end
      if not has_vue_plugin then
        table.insert(plugins, vue_plugin)
      end
      vtsls.settings.vtsls.tsserver.globalPlugins = plugins

      opts.servers.vtsls = vtsls
    end,
  },

  -- Vue-specific keymaps (reuse the <leader>j JavaScript/TS group)
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "vue" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "Vue: " .. desc })
          end

          -- Import management (handled by the vue typescript plugin via vtsls)
          map("<leader>jI", function()
            vim.lsp.buf.code_action({
              apply = true,
              context = { only = { "source.organizeImports" }, diagnostics = {} },
            })
          end, "Organize Imports")

          map("<leader>ji", function()
            vim.lsp.buf.code_action({
              apply = true,
              context = { only = { "source.addMissingImports" }, diagnostics = {} },
            })
          end, "Add Missing Imports")

          map("<leader>ju", function()
            vim.lsp.buf.code_action({
              apply = true,
              context = { only = { "source.removeUnused" }, diagnostics = {} },
            })
          end, "Remove Unused Imports")

          map("<leader>jf", function()
            vim.lsp.buf.code_action({
              apply = true,
              context = { only = { "source.fixAll" }, diagnostics = {} },
            })
          end, "Fix All")

          map("<leader>jl", function()
            vim.lsp.buf.code_action({
              apply = true,
              context = { only = { "source.fixAll.eslint" }, diagnostics = {} },
            })
          end, "ESLint Fix All")

          -- Package management
          map("<leader>jn", "<cmd>split | terminal npm run<cr>", "npm run")
          map("<leader>jd", "<cmd>split | terminal npm run dev<cr>", "npm dev")
          map("<leader>jb", "<cmd>split | terminal npm run build<cr>", "npm build")
        end,
      })
    end,
  },

  -- Code formatting with prettier
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        vue = { "prettier" },
      },
    },
  },

  -- Linting with ESLint
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        vue = { "eslint_d" },
      },
    },
  },
}
