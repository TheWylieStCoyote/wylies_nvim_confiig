-- Avante.nvim Configuration
-- Cursor-style AI coding assistant with multi-provider support
--
-- Requirements:
--   Set API keys as environment variables:
--   - ANTHROPIC_API_KEY for Claude
--   - OPENAI_API_KEY for OpenAI
--   - Or use Ollama for local models (no key needed)

return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Use latest
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        -- Image pasting support
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
          },
        },
      },
      {
        -- Render markdown in avante windows
        "MeanderingProgrammer/render-markdown.nvim",
        optional = true,
        opts = function(_, opts)
          opts.file_types = opts.file_types or {}
          vim.list_extend(opts.file_types, { "Avante" })
        end,
        ft = { "Avante" },
      },
    },
    keys = {
      { "<leader>Aa", "<cmd>AvanteAsk<cr>", mode = { "n", "v" }, desc = "Avante: Ask" },
      { "<leader>Ae", "<cmd>AvanteEdit<cr>", mode = "v", desc = "Avante: Edit Selection" },
      { "<leader>Ar", "<cmd>AvanteRefresh<cr>", desc = "Avante: Refresh" },
      { "<leader>At", "<cmd>AvanteToggle<cr>", desc = "Avante: Toggle" },
      { "<leader>Af", "<cmd>AvanteFocus<cr>", desc = "Avante: Focus" },
      { "<leader>Ap", "<cmd>AvanteSwitchProvider<cr>", desc = "Avante: Switch Provider" },
      { "<leader>Ac", "<cmd>AvanteChat<cr>", desc = "Avante: New Chat" },
      { "<leader>As", "<cmd>AvanteStop<cr>", desc = "Avante: Stop" },
      { "<leader>Ah", "<cmd>AvanteHistory<cr>", desc = "Avante: Chat History" },
    },
    opts = {
      -- Default provider (change to "openai", "ollama", "copilot", etc.)
      provider = "claude",
      -- Provider configurations (new format)
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-sonnet-4-20250514",
          api_key_name = "ANTHROPIC_API_KEY",
          extra_request_body = {
            temperature = 0,
            max_tokens = 4096,
          },
        },
        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "gpt-4o",
          api_key_name = "OPENAI_API_KEY",
          extra_request_body = {
            temperature = 0,
            max_completion_tokens = 4096,
          },
        },
        ollama = {
          endpoint = "http://127.0.0.1:11434",
          model = "codellama:13b",
          extra_request_body = {
            options = {
              temperature = 0.75,
              num_ctx = 20480,
            },
          },
        },
      },
      -- Behavior
      behaviour = {
        auto_suggestions = false, -- Don't conflict with copilot
        auto_set_highlight_group = true,
        auto_set_keymaps = false, -- We define our own
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = true,
      },
      -- Keybindings within avante windows
      mappings = {
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
      },
      -- Window configuration
      windows = {
        position = "right",
        wrap = true,
        width = 30,
        sidebar_header = {
          enabled = true,
          align = "center",
          rounded = true,
        },
      },
      -- Highlight groups
      highlights = {
        diff = {
          current = "DiffText",
          incoming = "DiffAdd",
        },
      },
    },
  },
}
