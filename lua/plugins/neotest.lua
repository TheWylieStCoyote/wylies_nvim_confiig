-- Neotest Configuration
-- Unified test runner for multiple languages

-- Tracks failed test positions and (optionally) reloads coverage after a run.
-- Registered as a neotest consumer so it can hook the client's results events
-- without async code in keymaps.
local tracker = {
  failed = {}, -- position id -> adapter id
  coverage_pending = false,
}

local function tracker_consumer(client)
  client.listeners.results = function(adapter_id, results, partial)
    if partial then
      return
    end
    for pos_id, result in pairs(results) do
      local node = client:get_position(pos_id, { adapter = adapter_id })
      if node and node:data().type == "test" then
        if result.status == "failed" then
          tracker.failed[pos_id] = adapter_id
        else
          tracker.failed[pos_id] = nil
        end
      end
    end

    if tracker.coverage_pending then
      tracker.coverage_pending = false
      vim.schedule(function()
        local ok, coverage = pcall(require, "coverage")
        if ok then
          coverage.load(true)
        else
          vim.notify("nvim-coverage is not available", vim.log.levels.WARN)
        end
      end)
    end
  end
  return {}
end

-- Re-run every test that failed in a previous run.
local function run_failed()
  local neotest = require("neotest")
  local count = 0
  for pos_id, adapter_id in pairs(tracker.failed) do
    neotest.run.run({ pos_id, adapter = adapter_id })
    count = count + 1
  end
  if count == 0 then
    vim.notify("No failed tests to re-run", vim.log.levels.INFO)
  else
    vim.notify(("Re-running %d failed test(s)"):format(count), vim.log.levels.INFO)
  end
end

-- Per-filetype flags that make the test runner emit the coverage file that
-- nvim-coverage is configured to read (see coverage.lua).
local coverage_args = {
  python = { "--cov" },
  go = { "-coverprofile=coverage.out" },
  javascript = { "--coverage", "--coverageReporters=lcov" },
  typescript = { "--coverage", "--coverageReporters=lcov" },
  javascriptreact = { "--coverage", "--coverageReporters=lcov" },
  typescriptreact = { "--coverage", "--coverageReporters=lcov" },
}

-- Run the current file with coverage flags, then load and show the report.
local function run_file_with_coverage()
  local ft = vim.bo.filetype
  local args = coverage_args[ft]
  if not args then
    if ft == "rust" then
      vim.notify(
        "Rust coverage needs a separate pass:\n  cargo llvm-cov --lcov --output-path target/coverage/lcov.info\nthen <leader>tcl to load it.",
        vim.log.levels.INFO
      )
    else
      vim.notify("No coverage flags configured for filetype: " .. ft, vim.log.levels.WARN)
    end
    return
  end
  tracker.coverage_pending = true
  require("neotest").run.run({ vim.fn.expand("%"), extra_args = args })
end

-- Locate a project interpreter: active venv, then common in-repo venv dirs,
-- then whatever python3 is on PATH.
local function python_path()
  local venv = os.getenv("VIRTUAL_ENV")
  if venv and vim.fn.executable(venv .. "/bin/python") == 1 then
    return venv .. "/bin/python"
  end
  local root = (package.loaded["lazyvim.util"] and LazyVim.root()) or vim.fn.getcwd()
  for _, dir in ipairs({ ".venv", "venv", ".env" }) do
    local candidate = root .. "/" .. dir .. "/bin/python"
    if vim.fn.executable(candidate) == 1 then
      return candidate
    end
  end
  return "python3"
end

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
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
      { "<leader>tf", run_failed, desc = "Re-run Failed Tests" },
      { "<leader>tcr", run_file_with_coverage, desc = "Run File with Coverage" },

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

      -- Control running tests
      {
        "<leader>ts",
        function()
          require("neotest").run.stop()
        end,
        desc = "Stop Tests",
      },
      {
        "<leader>tA",
        function()
          require("neotest").run.attach()
        end,
        desc = "Attach to Running Test",
      },

      -- Watch tests
      {
        "<leader>tw",
        function()
          require("neotest").watch.toggle(vim.fn.expand("%"))
        end,
        desc = "Watch Current File",
      },
      {
        "<leader>tW",
        function()
          require("neotest").watch.toggle()
        end,
        desc = "Watch Nearest Test",
      },

      -- Output
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true, auto_close = true })
        end,
        desc = "Show Output (nearest)",
      },
      {
        "<leader>tL",
        function()
          require("neotest").output.open({ enter = true, auto_close = true, last_run = true })
        end,
        desc = "Show Output (last run)",
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
      -- Every adapter does its own root detection (Cargo.toml, go.mod, ...),
      -- so they are all registered and simply stay inactive in projects they
      -- don't recognise. Gating on files relative to the startup cwd meant
      -- adapters were silently missing when a project was opened later.
      local adapters = {}
      local function try_adapter(name, config)
        local ok, adapter = pcall(require, name)
        if not ok then
          return
        end
        if config then
          table.insert(adapters, adapter(config))
        else
          table.insert(adapters, adapter)
        end
      end

      -- Python (pytest)
      try_adapter("neotest-python", {
        dap = { justMyCode = false },
        runner = "pytest",
        python = python_path,
      })

      -- Go (neotest-golang; the original neotest-go is unmaintained)
      try_adapter("neotest-golang", {
        go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
        dap_mode = "dap-go", -- debug through nvim-dap-go (delve)
      })

      -- Rust via rustaceanvim: discovery through rust-analyzer, nextest aware,
      -- debugging through the codelldb adapter configured in rust.lua.
      try_adapter("rustaceanvim.neotest")

      -- Vitest
      try_adapter("neotest-vitest", {
        vitestCommand = "npx vitest",
      })

      -- Jest
      try_adapter("neotest-jest", {
        jestCommand = "npm test --",
        env = { CI = true },
        cwd = function()
          return vim.fn.getcwd()
        end,
      })

      -- Elixir
      try_adapter("neotest-elixir")

      -- Haskell
      try_adapter("neotest-haskell", {
        build_tools = { "stack", "cabal" },
        frameworks = { "hspec", "tasty" },
      })

      -- Java
      try_adapter("neotest-java", {
        junit_jar = nil,
      })

      -- C# / .NET
      try_adapter("neotest-dotnet", {
        dap = { justMyCode = false },
      })

      -- Ruby
      try_adapter("neotest-rspec", {
        rspec_cmd = function()
          return { "bundle", "exec", "rspec" }
        end,
      })
      try_adapter("neotest-minitest")

      -- Zig
      try_adapter("neotest-zig")

      -- Lua (plenary busted-style specs, e.g. for this config or plugins)
      try_adapter("neotest-plenary")

      require("neotest").setup({
        adapters = adapters,

        consumers = {
          tracker = tracker_consumer,
        },

        discovery = {
          enabled = true,
          concurrent = 3,
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
  { "fredrikaverpil/neotest-golang", lazy = true, dependencies = { "leoluz/nvim-dap-go" } },
  { "marilari88/neotest-vitest", lazy = true },
  { "nvim-neotest/neotest-jest", lazy = true },
  { "jfpedroza/neotest-elixir", lazy = true },
  { "mrcjkb/neotest-haskell", lazy = true },
  { "rcasia/neotest-java", lazy = true },
  { "Issafalcon/neotest-dotnet", lazy = true },
  { "olimorris/neotest-rspec", lazy = true },
  { "zidhuss/neotest-minitest", lazy = true },
  { "lawrence-laz/neotest-zig", lazy = true },
  { "nvim-neotest/neotest-plenary", lazy = true },
}
