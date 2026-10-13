-- HTTP Client Configuration
-- Execute HTTP requests from .http files using rest.nvim

-- rest.nvim is a luarocks package: lazy.nvim needs `luarocks`, or python3 plus a
-- C compiler and make to bootstrap one through hererocks. Requests run via curl.
local has_rocks = vim.fn.executable("luarocks") == 1
  or (
    (vim.fn.executable("python3") == 1 or vim.fn.executable("python") == 1)
    and vim.fn.executable("cc") == 1
    and vim.fn.executable("make") == 1
  )
if vim.fn.executable("curl") ~= 1 or not has_rocks then
  return {}
end

return {
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>rr", "<cmd>Rest run<cr>", desc = "Run HTTP Request", ft = "http" },
      { "<leader>rl", "<cmd>Rest run last<cr>", desc = "Re-run Last Request" },
      { "<leader>re", "<cmd>Rest env show<cr>", desc = "Show Environment", ft = "http" },
      { "<leader>rE", "<cmd>Rest env select<cr>", desc = "Select Environment", ft = "http" },
    },
    opts = {
      -- Response result display
      result = {
        split = {
          horizontal = false,
          in_place = false,
        },
        behavior = {
          decode_url = true,
          show_info = {
            url = true,
            headers = true,
            http_info = true,
            curl_command = true,
          },
          formatters = {
            json = "jq",
            html = function(body)
              if vim.fn.executable("tidy") ~= 1 then
                return body
              end
              return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
            end,
          },
        },
      },
      -- Highlighting
      highlight = {
        enable = true,
        timeout = 150,
      },
      -- Environment files
      env = {
        enable = true,
        pattern = "%.env.*",
      },
    },
    config = function(_, opts)
      require("rest-nvim").setup(opts)

      -- Set up HTTP file keybindings
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "http",
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "HTTP: " .. desc })
          end

          map("<CR>", "<cmd>Rest run<cr>", "Run Request Under Cursor")
          map("<leader>rp", "<cmd>Rest run preview<cr>", "Preview Request")
        end,
      })
    end,
  },

  -- TreeSitter for HTTP files
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "http",
        "json",
      })
    end,
  },
}
