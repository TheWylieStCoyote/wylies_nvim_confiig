-- Neogen Configuration
-- Auto-generate docstrings and annotations from function signatures

return {
  {
    "danymat/neogen",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Neogen",
    keys = {
      {
        "<leader>cg",
        function()
          require("neogen").generate()
        end,
        desc = "Generate Docstring",
      },
      {
        "<leader>cgf",
        function()
          require("neogen").generate({ type = "func" })
        end,
        desc = "Generate Function Doc",
      },
      {
        "<leader>cgc",
        function()
          require("neogen").generate({ type = "class" })
        end,
        desc = "Generate Class Doc",
      },
      {
        "<leader>cgt",
        function()
          require("neogen").generate({ type = "type" })
        end,
        desc = "Generate Type Doc",
      },
      {
        "<leader>cgF",
        function()
          require("neogen").generate({ type = "file" })
        end,
        desc = "Generate File Doc",
      },
    },
    opts = {
      snippet_engine = "nvim",
      languages = {
        python = { template = { annotation_convention = "google_docstrings" } },
        javascript = { template = { annotation_convention = "jsdoc" } },
        typescript = { template = { annotation_convention = "tsdoc" } },
        lua = { template = { annotation_convention = "emmylua" } },
        rust = { template = { annotation_convention = "rustdoc" } },
        go = { template = { annotation_convention = "godoc" } },
        java = { template = { annotation_convention = "javadoc" } },
        c = { template = { annotation_convention = "doxygen" } },
        cpp = { template = { annotation_convention = "doxygen" } },
      },
    },
  },
}
