-- nvim-coverage Configuration
-- Display test coverage in the sign column

return {
  {
    "andythigpen/nvim-coverage",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = {
      "Coverage",
      "CoverageLoad",
      "CoverageLoadLcov",
      "CoverageShow",
      "CoverageHide",
      "CoverageToggle",
      "CoverageSummary",
      "CoverageClear",
    },
    opts = {
      auto_reload = true,
      auto_reload_timeout_ms = 500,

      commands = true,

      highlights = {
        covered = { fg = "#a6e3a1" }, -- Green for covered
        uncovered = { fg = "#f38ba8" }, -- Red for uncovered
        partial = { fg = "#f9e2af" }, -- Yellow for partial
      },

      signs = {
        covered = { hl = "CoverageCovered", text = "▎" },
        uncovered = { hl = "CoverageUncovered", text = "▎" },
        partial = { hl = "CoveragePartial", text = "▎" },
      },

      sign_group = "coverage",

      summary = {
        min_coverage = 80.0, -- Highlight below this threshold
      },

      lang = {
        -- Python (coverage.py)
        python = {
          coverage_file = ".coverage",
          coverage_command = "coverage json -o coverage.json -q",
        },

        -- Go (go test -coverprofile)
        go = {
          coverage_file = "coverage.out",
        },

        -- Rust (cargo-tarpaulin or llvm-cov)
        rust = {
          coverage_file = "target/coverage/lcov.info",
        },

        -- JavaScript/TypeScript (c8, nyc, jest --coverage)
        javascript = {
          coverage_file = "coverage/lcov.info",
        },
        typescript = {
          coverage_file = "coverage/lcov.info",
        },

        -- Ruby (simplecov)
        ruby = {
          coverage_file = "coverage/coverage.json",
        },

        -- Elixir (excoveralls)
        elixir = {
          coverage_file = "cover/excoveralls.json",
        },

        -- Java (jacoco)
        java = {
          coverage_file = "target/site/jacoco/jacoco.xml",
        },

        -- C/C++ (gcov/lcov)
        cpp = {
          coverage_file = "coverage/lcov.info",
        },
        c = {
          coverage_file = "coverage/lcov.info",
        },
      },
    },

    keys = {
      { "<leader>tcl", "<cmd>CoverageLoad<cr>", desc = "Load Coverage" },
      { "<leader>tcc", "<cmd>CoverageToggle<cr>", desc = "Toggle Coverage" },
      { "<leader>tcs", "<cmd>CoverageSummary<cr>", desc = "Coverage Summary" },
      { "<leader>tcC", "<cmd>CoverageClear<cr>", desc = "Clear Coverage" },
      {
        "<leader>tcL",
        function()
          local file = vim.fn.input("LCOV file: ", "coverage/lcov.info", "file")
          if file ~= "" then
            vim.cmd("CoverageLoadLcov " .. file)
          end
        end,
        desc = "Load LCOV File",
      },
    },
  },
}
