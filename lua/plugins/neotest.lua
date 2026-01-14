-- Neotest Configuration
-- Unified test runner for multiple languages

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    -- Only load on test-related keybindings or commands
    cmd = { "Neotest" },
    keys = {
      -- Run tests
      {
        "<leader>tt",
        function()
          require("neotest").run.run()
        end,
        desc = "Run Nearest Test",
      },
      {
        "<leader>tT",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run Current File",
      },
      {
        "<leader>ta",
        function()
          require("neotest").run.run(vim.fn.getcwd())
        end,
        desc = "Run All Tests",
      },
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run Last Test",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run({ suite = false })
        end,
        desc = "Run Failed Tests",
      },

      -- Debug tests
      {
        "<leader>td",
        function()
          require("neotest").run.run({ strategy = "dap" })
        end,
        desc = "Debug Nearest Test",
      },
      {
        "<leader>tD",
        function()
          require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
        end,
        desc = "Debug Current File",
      },

      -- Stop tests
      {
        "<leader>ts",
        function()
          require("neotest").run.stop()
        end,
        desc = "Stop Tests",
      },

      -- Watch tests
      {
        "<leader>tw",
        function()
          require("neotest").watch.toggle(vim.fn.expand("%"))
        end,
        desc = "Toggle Watch",
      },

      -- Output
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true, auto_close = true })
        end,
        desc = "Show Output",
      },
      {
        "<leader>tO",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle Output Panel",
      },

      -- Summary
      {
        "<leader>tS",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle Summary",
      },

      -- Navigation
      {
        "[t",
        function()
          require("neotest").jump.prev({ status = "failed" })
        end,
        desc = "Previous Failed Test",
      },
      {
        "]t",
        function()
          require("neotest").jump.next({ status = "failed" })
        end,
        desc = "Next Failed Test",
      },

      -- Marks
      {
        "<leader>tm",
        function()
          require("neotest").summary.mark()
        end,
        desc = "Mark Test",
      },
      {
        "<leader>tM",
        function()
          require("neotest").run.run_marked()
        end,
        desc = "Run Marked Tests",
      },
    },
    config = function()
      -- Build adapters list dynamically based on what's available
      local adapters = {}

      -- Helper to check if any of the given files exist in the project
      local function has_project_file(...)
        local files = { ... }
        for _, file in ipairs(files) do
          if vim.fn.filereadable(file) == 1 or vim.fn.glob(file) ~= "" then
            return true
          end
        end
        return false
      end

      -- Helper to safely load an adapter with project detection
      local function try_adapter(name, config, project_files)
        -- Skip if project files specified and none exist
        if project_files and not has_project_file(unpack(project_files)) then
          return
        end
        local ok, adapter = pcall(require, name)
        if ok then
          if config then
            table.insert(adapters, adapter(config))
          else
            table.insert(adapters, adapter)
          end
        end
      end

      -- Python (pytest.ini, pyproject.toml, setup.py, setup.cfg, or test files)
      try_adapter("neotest-python", {
        dap = { justMyCode = false },
        runner = "pytest",
        python = function()
          local venv = os.getenv("VIRTUAL_ENV")
          if venv then
            return venv .. "/bin/python"
          end
          return "python3"
        end,
      }, { "pytest.ini", "pyproject.toml", "setup.py", "setup.cfg", "tests/*.py", "test_*.py" })

      -- Go (go.mod)
      try_adapter("neotest-go", {
        experimental = { test_table = true },
        args = { "-count=1", "-timeout=60s" },
      }, { "go.mod" })

      -- Rust (Cargo.toml)
      try_adapter("neotest-rust", {
        args = { "--no-capture" },
        dap_adapter = "codelldb",
      }, { "Cargo.toml" })

      -- Vitest (vitest.config.* or vite.config.* with vitest)
      try_adapter("neotest-vitest", {
        vitestCommand = "npx vitest",
      }, { "vitest.config.ts", "vitest.config.js", "vitest.config.mts" })

      -- Jest (jest.config.* or package.json with jest)
      try_adapter("neotest-jest", {
        jestCommand = "npm test --",
        env = { CI = true },
        cwd = function()
          return vim.fn.getcwd()
        end,
      }, { "jest.config.js", "jest.config.ts", "jest.config.mjs" })

      -- Elixir (mix.exs)
      try_adapter("neotest-elixir", nil, { "mix.exs" })

      -- Haskell (stack.yaml or *.cabal)
      try_adapter("neotest-haskell", {
        build_tools = { "stack", "cabal" },
        frameworks = { "hspec", "tasty" },
      }, { "stack.yaml", "*.cabal", "cabal.project" })

      -- Java (pom.xml or build.gradle)
      try_adapter("neotest-java", {
        junit_jar = nil,
      }, { "pom.xml", "build.gradle", "build.gradle.kts" })

      -- C# / .NET (*.csproj or *.sln)
      try_adapter("neotest-dotnet", {
        dap = { justMyCode = false },
      }, { "*.csproj", "*.sln" })

      -- Ruby RSpec (spec/ directory or .rspec)
      try_adapter("neotest-rspec", {
        rspec_cmd = function()
          return { "bundle", "exec", "rspec" }
        end,
      }, { ".rspec", "spec/*.rb" })

      -- Ruby Minitest (test/ directory with minitest)
      try_adapter("neotest-minitest", nil, { "test/*.rb", "test/test_*.rb" })

      -- Zig (build.zig)
      try_adapter("neotest-zig", nil, { "build.zig" })

      require("neotest").setup({
        adapters = adapters,

        discovery = {
          enabled = true,
          concurrent = 1,
        },

        running = {
          concurrent = true,
        },

        summary = {
          enabled = true,
          animated = true,
          follow = true,
          expand_errors = true,
          open = "botright vsplit | vertical resize 50",
        },

        output = {
          enabled = true,
          open_on_run = "short",
        },

        output_panel = {
          enabled = true,
          open = "botright split | resize 15",
        },

        quickfix = {
          enabled = true,
          open = false,
        },

        status = {
          enabled = true,
          virtual_text = true,
          signs = true,
        },

        icons = {
          child_indent = "│",
          child_prefix = "├",
          collapsed = "─",
          expanded = "╮",
          failed = "",
          final_child_indent = " ",
          final_child_prefix = "╰",
          non_collapsible = "─",
          passed = "",
          running = "",
          running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
          skipped = "",
          unknown = "",
          watching = "",
        },

        floating = {
          border = "rounded",
          max_height = 0.6,
          max_width = 0.6,
        },

        diagnostic = {
          enabled = true,
          severity = vim.diagnostic.severity.ERROR,
        },
      })
    end,
  },

  -- Adapters as optional dependencies (loaded on demand)
  { "nvim-neotest/neotest-python", lazy = true },
  { "nvim-neotest/neotest-go", lazy = true },
  { "rouge8/neotest-rust", lazy = true },
  { "marilari88/neotest-vitest", lazy = true },
  { "nvim-neotest/neotest-jest", lazy = true },
  { "jfpedroza/neotest-elixir", lazy = true },
  { "mrcjkb/neotest-haskell", lazy = true },
  { "rcasia/neotest-java", lazy = true },
  { "Issafalcon/neotest-dotnet", lazy = true },
  { "olimorris/neotest-rspec", lazy = true },
  { "zidhuss/neotest-minitest", lazy = true },
  { "lawrence-laz/neotest-zig", lazy = true },
}
