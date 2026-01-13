-- Which-Key Configuration
-- Keybinding hints and discovery

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- Delay before showing the popup (ms)
      delay = 300,

      -- Plugin configuration
      plugins = {
        marks = true, -- Show marks on ' and `
        registers = true, -- Show registers on " in NORMAL or <C-r> in INSERT
        spelling = {
          enabled = true, -- Show spelling suggestions with z=
          suggestions = 20,
        },
        presets = {
          operators = true, -- Adds help for operators like d, y, c
          motions = true, -- Adds help for motions
          text_objects = true, -- Help for text objects after entering operator
          windows = true, -- <c-w> bindings
          nav = true, -- Misc bindings to work with windows
          z = true, -- Bindings for folds, spelling, etc prefixed with z
          g = true, -- Bindings prefixed with g
        },
      },

      -- Icons configuration
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
        ellipsis = "…",
        mappings = true,
        rules = {},
        colors = true,
        keys = {
          Up = " ",
          Down = " ",
          Left = " ",
          Right = " ",
          C = "󰘴 ",
          M = "󰘵 ",
          D = "󰘳 ",
          S = "󰘶 ",
          CR = "󰌑 ",
          Esc = "󱊷 ",
          ScrollWheelDown = "󱕐 ",
          ScrollWheelUp = "󱕑 ",
          NL = "󰌑 ",
          BS = "󰁮",
          Space = "󱁐 ",
          Tab = "󰌒 ",
          F1 = "󱊫",
          F2 = "󱊬",
          F3 = "󱊭",
          F4 = "󱊮",
          F5 = "󱊯",
          F6 = "󱊰",
          F7 = "󱊱",
          F8 = "󱊲",
          F9 = "󱊳",
          F10 = "󱊴",
          F11 = "󱊵",
          F12 = "󱊶",
        },
      },

      -- Window configuration
      win = {
        no_overlap = true,
        border = "rounded",
        padding = { 1, 2 },
        title = true,
        title_pos = "center",
        zindex = 1000,
      },

      -- Layout configuration
      layout = {
        width = { min = 20 },
        spacing = 3,
      },

      -- Show help message in command line
      show_help = true,
      show_keys = true,

      -- Disable for certain filetypes
      disable = {
        ft = {},
        bt = {},
      },

      -- Debug mode
      debug = false,
    },

    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      -- Register key groups
      wk.add({
        -- Top-level groups
        { "<leader>a", group = "AI/Copilot" },
        { "<leader>b", group = "Buffer" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Debug" },
        { "<leader>e", group = "Extract/Refactor" },
        { "<leader>f", group = "Find/Files" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Harpoon" },
        { "<leader>j", group = "JavaScript/TS" },
        { "<leader>k", group = "Docker" },
        { "<leader>l", group = "LSP/Lua" },
        { "<leader>n", group = "Notifications/C#" },
        { "<leader>o", group = "OCaml/Ollama" },
        { "<leader>p", group = "Python/Protobuf" },
        { "<leader>q", group = "Session/Quit" },
        { "<leader>r", group = "Rust/HTTP" },
        { "<leader>s", group = "Search" },
        { "<leader>t", group = "Test" },
        { "<leader>u", group = "UI/Toggle" },
        { "<leader>w", group = "Window" },
        { "<leader>x", group = "Diagnostics/Elixir" },
        { "<leader>z", group = "Zig" },

        -- Git subgroups
        { "<leader>gd", group = "Diffview" },
        { "<leader>gh", group = "Hunk/History" },
        { "<leader>gn", group = "Neogit" },

        -- Debug subgroups
        { "<leader>da", group = "Adapters" },
        { "<leader>db", group = "Breakpoints" },

        -- Code actions
        { "<leader>ca", group = "Actions" },
        { "<leader>cf", group = "Format" },
        { "<leader>co", group = "Conflict Ours" },
        { "<leader>ct", group = "Conflict Theirs" },
        { "<leader>cb", group = "Conflict Base" },

        -- Copilot
        { "<leader>cp", group = "Copilot Chat" },

        -- Harpoon slots
        { "<leader>h1", desc = "Replace slot 1" },
        { "<leader>h2", desc = "Replace slot 2" },
        { "<leader>h3", desc = "Replace slot 3" },
        { "<leader>h4", desc = "Replace slot 4" },
        { "<leader>h5", desc = "Replace slot 5" },

        -- Quick file navigation
        { "<leader>1", desc = "Harpoon File 1" },
        { "<leader>2", desc = "Harpoon File 2" },
        { "<leader>3", desc = "Harpoon File 3" },
        { "<leader>4", desc = "Harpoon File 4" },
        { "<leader>5", desc = "Harpoon File 5" },

        -- Test subgroups
        { "<leader>tn", group = "Neotest" },
        { "<leader>td", group = "Debug Test" },

        -- Session management
        { "<leader>qS", desc = "Save Session" },
        { "<leader>qR", desc = "Restore Session" },
        { "<leader>qD", desc = "Delete Session" },
        { "<leader>qs", desc = "Search Sessions" },

        -- HTTP Client (subgroup of Rust/HTTP)
        { "<leader>rr", desc = "Run HTTP Request" },
        { "<leader>rl", desc = "Re-run Last Request" },
        { "<leader>re", desc = "Show Environment" },
        { "<leader>rE", desc = "Select Environment" },

        -- Database UI (extends SQL group)
        { "<leader>SD", desc = "Toggle DB UI" },
        { "<leader>SA", desc = "Add DB Connection" },
        { "<leader>SF", desc = "Find DB Buffer" },

        -- Search & Replace (Spectre)
        { "<leader>sr", desc = "Search & Replace" },
        { "<leader>sw", desc = "Replace Word" },
        { "<leader>sp", desc = "Replace in File" },

        -- Ollama (Local AI)
        { "<leader>oo", desc = "Ollama Prompt" },
        { "<leader>oO", desc = "Select Model" },
        { "<leader>og", desc = "Generate Code" },
        { "<leader>oe", desc = "Explain Code" },
        { "<leader>or", desc = "Review Code" },
        { "<leader>of", desc = "Fix Code" },
        { "<leader>ot", desc = "Add Tests" },
        { "<leader>od", desc = "Add Documentation" },
        { "<leader>os", desc = "Simplify Code" },

        -- Language-specific prefixes (uppercase)
        { "<leader>B", group = "Bash" },
        { "<leader>C", group = "C/C++/Compare" },
        { "<leader>G", group = "Go" },
        { "<leader>D", group = "Devcontainer" },
        { "<leader>H", group = "Haskell" },
        { "<leader>J", group = "Java/Julia" },
        { "<leader>K", group = "Kotlin" },
        { "<leader>L", group = "LaTeX" },
        { "<leader>M", group = "MATLAB" },
        { "<leader>R", group = "Remote/R" },
        { "<leader>S", group = "SQL" },
        { "<leader>T", group = "Terraform" },
        { "<leader>V", group = "VHDL" },
        { "<leader>U", desc = "Undotree" },

        -- Bracket navigation
        { "[", group = "Previous" },
        { "]", group = "Next" },
        { "[d", desc = "Previous diagnostic" },
        { "]d", desc = "Next diagnostic" },
        { "[h", desc = "Previous harpoon" },
        { "]h", desc = "Next harpoon" },
        { "[x", desc = "Previous conflict" },
        { "]x", desc = "Next conflict" },
        { "[c", desc = "Previous hunk" },
        { "]c", desc = "Next hunk" },
        { "[t", desc = "Previous test" },
        { "]t", desc = "Next test" },

        -- g prefix
        { "g", group = "Goto" },
        { "gd", desc = "Go to definition" },
        { "gD", desc = "Go to declaration" },
        { "gr", desc = "Go to references" },
        { "gI", desc = "Go to implementation" },
        { "gy", desc = "Go to type definition" },
        { "gf", desc = "Go to file" },

        -- z prefix
        { "z", group = "Fold/Scroll" },

        -- Window management
        { "<C-w>", group = "Window" },
      })
    end,
  },
}
