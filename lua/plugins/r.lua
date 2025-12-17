-- R Development Configuration
-- LSP (r-languageserver), linting (lintr), and RStudio-like features

-- Skip entire R config if R languageserver is not installed
-- (R may be installed but languageserver requires manual setup in R)
local function has_r_languageserver()
  if vim.fn.executable("R") ~= 1 then return false end
  local result = vim.fn.system("R --slave -e 'packageVersion(\"languageserver\")' 2>/dev/null")
  return result:match("%d+%.%d+") ~= nil
end

if not has_r_languageserver() then
  return {}
end

return {
  -- TreeSitter parsers for R
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "r",
        "rnoweb",
        "rmd",
      })
    end,
  },

  -- Mason: ensure R tools are installed
  -- Note: Requires R. Install in R: install.packages("languageserver")
  -- {
  --   "mason-org/mason.nvim",
  --   opts = function(_, opts)
  --     vim.list_extend(opts.ensure_installed or {}, {
  --       "r-languageserver",
  --     })
  --   end,
  -- },

  -- R language server configuration (only if R is available)
  -- Completely skip this config if R is not installed to prevent mason-lspconfig auto-install
  vim.fn.executable("R") == 1 and {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        r_language_server = {
          cmd = { "R", "--slave", "-e", "languageserver::run()" },
          filetypes = { "r", "rmd" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.root_pattern(
              ".Rproj.user",
              "*.Rproj",
              "DESCRIPTION",
              ".git"
            )(fname) or vim.fn.getcwd()
          end,
          settings = {
            r = {
              lsp = {
                rich_documentation = true,
                diagnostics = true,
              },
            },
          },
        },
      },
    },
  } or nil,

  -- Code formatting with styler
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        r = { "styler" },
        rmd = { "styler" },
      },
      formatters = {
        styler = {
          command = "R",
          args = {
            "--slave",
            "-e",
            "con <- file('stdin'); styler::style_text(readLines(con)); close(con)",
          },
          stdin = true,
        },
      },
    },
  },

  -- Linting with lintr
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        r = { "lintr" },
        rmd = { "lintr" },
      },
    },
  },

  -- R.nvim for enhanced R support (REPL, object browser, etc.)
  {
    "R-nvim/R.nvim",
    ft = { "r", "rmd", "rnoweb", "quarto" },
    config = function()
      local opts = {
        -- R executable
        R_app = "R",
        R_args = { "--quiet", "--no-save" },

        -- Terminal settings
        rconsole_width = 0, -- 0 means determine automatically
        rconsole_height = 15,

        -- Object browser
        objbr_place = "RIGHT",
        objbr_opendf = true,

        -- Assignment operator
        assignment_keymap = "<M-->", -- Alt+-

        -- Pipe operator
        pipe_keymap = "<M-m>", -- Alt+m for |>
        pipe_version = "native", -- Use |> instead of %>%

        -- Help
        nvimpager = "tab",

        -- Hooks
        hook = {
          on_filetype = function()
            -- Set keymaps when R file is opened
            vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
            vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
          end,
        },
      }
      require("r").setup(opts)
    end,
  },

  -- cmp-r for R-specific completions (disabled - using blink.cmp instead)
  {
    "R-nvim/cmp-r",
    enabled = false, -- Only works with nvim-cmp, not blink.cmp
    ft = { "r", "rmd", "rnoweb", "quarto" },
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      require("cmp_r").setup({})
    end,
  },

  -- R-specific keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "r", "rmd", "rnoweb" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "R: " .. desc })
          end
          local vmap = function(keys, func, desc)
            vim.keymap.set("v", keys, func, { buffer = event.buf, desc = "R: " .. desc })
          end

          -- Start/Stop R
          map("<leader>rs", function()
            vim.cmd("RStart")
          end, "Start R")

          map("<leader>rq", function()
            vim.cmd("RStop")
          end, "Stop R")

          map("<leader>rQ", function()
            vim.cmd("RKill")
          end, "Kill R")

          -- Send code
          map("<leader>rl", function()
            vim.cmd("RSendLine")
          end, "Send Line")

          map("<leader>rp", function()
            vim.cmd("RSendParagraph")
          end, "Send Paragraph")

          map("<leader>rf", function()
            vim.cmd("RSendFile")
          end, "Send File")

          map("<leader>rb", function()
            vim.cmd("RSendAboveLines")
          end, "Send Above Lines")

          vmap("<leader>rs", function()
            vim.cmd("RSendSelection")
          end, "Send Selection")

          map("<leader>rc", function()
            vim.cmd("RSendChunk")
          end, "Send Chunk (Rmd)")

          -- Object browser
          map("<leader>ro", function()
            vim.cmd("RObjectBrowser")
          end, "Object Browser")

          map("<leader>rO", function()
            vim.cmd("RClearAll")
          end, "Clear Objects")

          -- Help and documentation
          map("<leader>rh", function()
            vim.cmd("RHelp " .. vim.fn.expand("<cword>"))
          end, "Help (word)")

          map("<leader>rH", function()
            local word = vim.fn.input("Help topic: ")
            if word ~= "" then
              vim.cmd("RHelp " .. word)
            end
          end, "Help (input)")

          map("<leader>re", function()
            vim.cmd("RShowEx " .. vim.fn.expand("<cword>"))
          end, "Show Example")

          map("<leader>ra", function()
            vim.cmd("RShowArgs " .. vim.fn.expand("<cword>"))
          end, "Show Arguments")

          -- Data viewing
          map("<leader>rv", function()
            vim.cmd("RViewDF " .. vim.fn.expand("<cword>"))
          end, "View Data Frame")

          map("<leader>rV", function()
            vim.cmd("RDputObj " .. vim.fn.expand("<cword>"))
          end, "Dput Object")

          -- Packages
          map("<leader>ri", function()
            local pkg = vim.fn.input("Package: ")
            if pkg ~= "" then
              vim.cmd("RSend install.packages('" .. pkg .. "')")
            end
          end, "Install Package")

          map("<leader>rL", function()
            local pkg = vim.fn.input("Library: ")
            if pkg ~= "" then
              vim.cmd("RSend library(" .. pkg .. ")")
            end
          end, "Load Library")

          -- Working directory
          map("<leader>rw", function()
            vim.cmd("RSetwd")
          end, "Set Working Dir")

          map("<leader>rW", function()
            vim.cmd("RSend getwd()")
          end, "Get Working Dir")

          -- Rmarkdown/Quarto
          map("<leader>rk", function()
            vim.cmd("RKnit")
          end, "Knit Document")

          map("<leader>rK", function()
            vim.cmd("RMakeAll")
          end, "Make All (PDF)")

          map("<leader>rm", function()
            vim.cmd("RMakePDF")
          end, "Make PDF")

          -- Plots
          map("<leader>rpd", function()
            vim.cmd("RSend dev.off()")
          end, "Close Plot Device")

          map("<leader>rps", function()
            local file = vim.fn.input("Save plot to: ", "plot.png")
            if file ~= "" then
              vim.cmd("RSend ggsave('" .. file .. "')")
            end
          end, "Save Plot")

          -- Console
          map("<leader>rCc", function()
            vim.cmd("RSend cat('\\014')")
          end, "Clear Console")

          map("<leader>rCh", function()
            vim.cmd("RSend history()")
          end, "Show History")

          -- Session
          map("<leader>rSs", function()
            vim.cmd("RSend save.image()")
          end, "Save Session")

          map("<leader>rSl", function()
            vim.cmd("RSend load('.RData')")
          end, "Load Session")

          -- Code actions
          map("<leader>raa", function()
            vim.lsp.buf.code_action()
          end, "Code Actions")

          -- Debugging
          map("<leader>rdd", function()
            vim.cmd("RSend debug(" .. vim.fn.expand("<cword>") .. ")")
          end, "Debug Function")

          map("<leader>rdu", function()
            vim.cmd("RSend undebug(" .. vim.fn.expand("<cword>") .. ")")
          end, "Undebug Function")

          map("<leader>rdt", function()
            vim.cmd("RSend traceback()")
          end, "Traceback")
        end,
      })
    end,
  },
}
