-- GitHub Copilot Configuration
-- AI-powered code completion and chat

return {
  -- Copilot core plugin (Lua implementation)
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<M-l>",           -- Alt+l to accept
          accept_word = "<M-k>",      -- Alt+k to accept word
          accept_line = "<M-j>",      -- Alt+j to accept line
          next = "<M-]>",             -- Alt+] for next suggestion
          prev = "<M-[>",             -- Alt+[ for previous suggestion
          dismiss = "<C-]>",          -- Ctrl+] to dismiss
        },
      },
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>",            -- Alt+Enter to open panel
        },
        layout = {
          position = "bottom",        -- "bottom" | "top" | "left" | "right"
          ratio = 0.4,
        },
      },
      filetypes = {
        yaml = true,
        markdown = true,
        help = false,
        gitcommit = true,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,                -- Disable for files without extension
      },
      copilot_node_command = "node",  -- Node.js version must be > 18.x
      server_opts_overrides = {},
    },
  },

  -- Disable copilot-cmp (not compatible with blink.cmp)
  -- Inline suggestions work without it
  {
    "zbirenbaum/copilot-cmp",
    enabled = false,
  },

  -- Copilot Chat for AI conversations
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",  -- Only on MacOS or Linux
    opts = {
      debug = false,
      model = "gpt-4o",       -- Default model
      temperature = 0.1,
      context = "buffers",    -- "buffers" | "buffer" | nil
      show_help = true,
      window = {
        layout = "vertical",  -- "vertical" | "horizontal" | "float" | "replace"
        width = 0.5,
        height = 0.5,
        border = "single",
        title = "Copilot Chat",
      },
      mappings = {
        complete = {
          detail = "Use @<Tab> or /<Tab> for options.",
          insert = "<Tab>",
        },
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        reset = {
          normal = "<C-r>",
          insert = "<C-r>",
        },
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        accept_diff = {
          normal = "<C-y>",
          insert = "<C-y>",
        },
        yank_diff = {
          normal = "gy",
        },
        show_diff = {
          normal = "gd",
        },
        show_system_prompt = {
          normal = "gp",
        },
        show_user_selection = {
          normal = "gs",
        },
      },
    },
    keys = {
      -- Chat commands
      { "<leader>aa", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Chat" },
      { "<leader>ax", "<cmd>CopilotChatReset<cr>", desc = "Reset Chat" },
      { "<leader>as", "<cmd>CopilotChatStop<cr>", desc = "Stop Output" },

      -- Quick actions
      { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Explain Code", mode = { "n", "v" } },
      { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "Review Code", mode = { "n", "v" } },
      { "<leader>af", "<cmd>CopilotChatFix<cr>", desc = "Fix Code", mode = { "n", "v" } },
      { "<leader>ao", "<cmd>CopilotChatOptimize<cr>", desc = "Optimize Code", mode = { "n", "v" } },
      { "<leader>ad", "<cmd>CopilotChatDocs<cr>", desc = "Generate Docs", mode = { "n", "v" } },
      { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "Generate Tests", mode = { "n", "v" } },

      -- Diagnostics
      { "<leader>aD", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "Fix Diagnostic" },

      -- Commit messages
      { "<leader>ac", "<cmd>CopilotChatCommit<cr>", desc = "Generate Commit Message" },
      { "<leader>aC", "<cmd>CopilotChatCommitStaged<cr>", desc = "Commit Staged Changes" },

      -- Custom prompts
      {
        "<leader>aq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            vim.cmd("CopilotChat " .. input)
          end
        end,
        desc = "Quick Chat",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "Prompt Actions",
        mode = { "n", "v" },
      },

      -- Help
      { "<leader>ah", "<cmd>CopilotChatModels<cr>", desc = "Select Model" },
    },
  },

  -- Copilot status in lualine (optional)
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      local function copilot_status()
        local ok, copilot = pcall(require, "copilot.client")
        if not ok then
          return ""
        end
        local status = copilot.is_disabled() and "" or ""
        return status
      end

      -- Add to lualine sections
      opts.sections = opts.sections or {}
      opts.sections.lualine_x = opts.sections.lualine_x or {}
      table.insert(opts.sections.lualine_x, 1, {
        copilot_status,
        cond = function()
          local ok, copilot = pcall(require, "copilot.client")
          return ok and copilot.buf_is_attached(0)
        end,
        color = { fg = "#6CC644" },
      })
    end,
  },

  -- Keybindings for Copilot management
  {
    "zbirenbaum/copilot.lua",
    keys = {
      { "<leader>cpe", "<cmd>Copilot enable<cr>", desc = "Enable Copilot" },
      { "<leader>cpd", "<cmd>Copilot disable<cr>", desc = "Disable Copilot" },
      { "<leader>cps", "<cmd>Copilot status<cr>", desc = "Copilot Status" },
      { "<leader>cpp", "<cmd>Copilot panel<cr>", desc = "Copilot Panel" },
      {
        "<leader>cpt",
        function()
          local copilot = require("copilot.suggestion")
          if copilot.is_visible() then
            copilot.dismiss()
            vim.notify("Copilot suggestions hidden", vim.log.levels.INFO)
          else
            copilot.next()
            vim.notify("Copilot suggestions shown", vim.log.levels.INFO)
          end
        end,
        desc = "Toggle Suggestions",
      },
    },
  },
}
