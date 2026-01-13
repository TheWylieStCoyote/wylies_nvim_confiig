-- Refactoring.nvim Configuration
-- Code refactoring support (extract function, extract variable, etc.)

return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      prompt_func_return_type = {
        go = true,
        cpp = true,
        c = true,
        java = true,
      },
      prompt_func_param_type = {
        go = true,
        cpp = true,
        c = true,
        java = true,
      },
      printf_statements = {},
      print_var_statements = {},
      show_success_message = true,
    },
    keys = {
      -- Extract refactorings (visual mode)
      {
        "<leader>ee",
        function() require("refactoring").refactor("Extract Function") end,
        mode = "x",
        desc = "Extract Function",
      },
      {
        "<leader>ef",
        function() require("refactoring").refactor("Extract Function To File") end,
        mode = "x",
        desc = "Extract Function To File",
      },
      {
        "<leader>ev",
        function() require("refactoring").refactor("Extract Variable") end,
        mode = "x",
        desc = "Extract Variable",
      },

      -- Inline refactorings
      {
        "<leader>eI",
        function() require("refactoring").refactor("Inline Function") end,
        mode = "n",
        desc = "Inline Function",
      },
      {
        "<leader>ei",
        function() require("refactoring").refactor("Inline Variable") end,
        mode = { "n", "x" },
        desc = "Inline Variable",
      },

      -- Extract block (normal mode)
      {
        "<leader>eb",
        function() require("refactoring").refactor("Extract Block") end,
        mode = "n",
        desc = "Extract Block",
      },
      {
        "<leader>eB",
        function() require("refactoring").refactor("Extract Block To File") end,
        mode = "n",
        desc = "Extract Block To File",
      },

      -- Refactor menu (Telescope)
      {
        "<leader>er",
        function() require("telescope").extensions.refactoring.refactors() end,
        mode = { "n", "x" },
        desc = "Refactoring Menu",
      },

      -- Debug print statements
      {
        "<leader>ep",
        function() require("refactoring").debug.printf({ below = true }) end,
        mode = "n",
        desc = "Debug Print Below",
      },
      {
        "<leader>eP",
        function() require("refactoring").debug.printf({ below = false }) end,
        mode = "n",
        desc = "Debug Print Above",
      },
      {
        "<leader>edv",
        function() require("refactoring").debug.print_var() end,
        mode = { "x", "n" },
        desc = "Debug Print Variable",
      },
      {
        "<leader>ec",
        function() require("refactoring").debug.cleanup({}) end,
        mode = "n",
        desc = "Debug Cleanup",
      },
    },
    config = function(_, opts)
      require("refactoring").setup(opts)
      -- Load Telescope extension
      pcall(function()
        require("telescope").load_extension("refactoring")
      end)
    end,
  },
}
