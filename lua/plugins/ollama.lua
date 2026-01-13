-- Ollama.nvim Configuration
-- Local LLM integration for code generation and explanation
--
-- Requirements:
--   1. Install Ollama: curl -fsSL https://ollama.com/install.sh | sh
--   2. Pull a model: ollama pull codellama
--   3. Start server: ollama serve (or it auto-starts)

return {
  {
    "nomnivore/ollama.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
    keys = {
      -- General prompts
      { "<leader>oo", "<cmd>Ollama<cr>", desc = "Ollama Prompt" },
      { "<leader>oO", "<cmd>OllamaModel<cr>", desc = "Select Model" },

      -- Code actions
      {
        "<leader>og",
        ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
        mode = { "n", "v" },
        desc = "Generate Code",
      },
      {
        "<leader>oe",
        ":<c-u>lua require('ollama').prompt('Explain_Code')<cr>",
        mode = { "n", "v" },
        desc = "Explain Code",
      },
      {
        "<leader>or",
        ":<c-u>lua require('ollama').prompt('Review_Code')<cr>",
        mode = { "n", "v" },
        desc = "Review Code",
      },
      {
        "<leader>of",
        ":<c-u>lua require('ollama').prompt('Fix_Code')<cr>",
        mode = { "n", "v" },
        desc = "Fix Code",
      },
      {
        "<leader>ot",
        ":<c-u>lua require('ollama').prompt('Add_Tests')<cr>",
        mode = { "n", "v" },
        desc = "Add Tests",
      },
      {
        "<leader>od",
        ":<c-u>lua require('ollama').prompt('Add_Docs')<cr>",
        mode = { "n", "v" },
        desc = "Add Documentation",
      },
      {
        "<leader>os",
        ":<c-u>lua require('ollama').prompt('Simplify_Code')<cr>",
        mode = { "n", "v" },
        desc = "Simplify Code",
      },
    },
    opts = {
      model = "codellama", -- Default model (change to "deepseek-coder" or others)
      url = "http://127.0.0.1:11434",
      serve = {
        on_start = false,
        command = "ollama",
        args = { "serve" },
        stop_command = "pkill",
        stop_args = { "-SIGTERM", "ollama" },
      },
      prompts = {
        Generate_Code = {
          prompt = "Generate code for the following description. Only output the code, no explanations:\n\n$sel",
          action = "display",
        },
        Explain_Code = {
          prompt = "Explain the following code in detail. What does it do and how does it work?\n\n```$ftype\n$sel\n```",
          action = "display",
        },
        Review_Code = {
          prompt = "Review the following code for bugs, performance issues, and best practices. Suggest improvements:\n\n```$ftype\n$sel\n```",
          action = "display",
        },
        Fix_Code = {
          prompt = "Fix any bugs or issues in the following code. Only output the corrected code:\n\n```$ftype\n$sel\n```",
          action = "display",
        },
        Add_Tests = {
          prompt = "Write unit tests for the following code using appropriate testing framework for $ftype:\n\n```$ftype\n$sel\n```",
          action = "display",
        },
        Add_Docs = {
          prompt = "Add comprehensive documentation/comments to the following code. Include docstrings, parameter descriptions, and return values:\n\n```$ftype\n$sel\n```",
          action = "display",
        },
        Simplify_Code = {
          prompt = "Simplify and refactor the following code to be more readable and maintainable. Only output the improved code:\n\n```$ftype\n$sel\n```",
          action = "display",
        },
      },
    },
  },
}
