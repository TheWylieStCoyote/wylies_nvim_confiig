-- 99 — ThePrimeagen's agentic AI workflow for Neovim
--
-- Augments hand-coding with LLM-powered search/visual-replace/work tracking.
-- Underlying provider is OpenCode (default) or Claude Code; the plugin shells
-- out to those CLIs, so they must be on $PATH.
--
-- Status: BETA — upstream API can still change. See repo for current docs:
--   https://github.com/ThePrimeagen/99
--
-- Primary entry points:
--   <leader>9s  search  — agentic project search; results land in quickfix
--   <leader>9v  visual  — replace visual selection with LLM output
--   <leader>9b  vibe    — agentic multi-file edit
--   <leader>9o  open    — re-open the last interaction's results
--   <leader>9x  stop    — kill all in-flight requests
--   <leader>9l  logs    — view debug logs
--   <leader>9c  clear   — clear previous request history

-- Line-anchored vibe marker.
-- 99's built-in throbber lives in the top-right; this drops a virtual-text
-- marker on the line where vibe was triggered so we can see "the request was
-- launched from here" in long-running sessions. Cleared on the first
-- CursorMoved/CursorMovedI in the originating buffer.
local request_ns = vim.api.nvim_create_namespace("_99_request_marker")

local function vibe_with_line_marker()
  local bufnr = vim.api.nvim_get_current_buf()
  local line = vim.api.nvim_win_get_cursor(0)[1] - 1

  vim.api.nvim_buf_clear_namespace(bufnr, request_ns, 0, -1)

  vim.api.nvim_buf_set_extmark(bufnr, request_ns, line, 0, {
    virt_text = { { "  [99 vibe pending…]", "Comment" } },
    virt_text_pos = "eol",
    hl_mode = "combine",
  })

  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    buffer = bufnr,
    once = true,
    callback = function()
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_buf_clear_namespace(bufnr, request_ns, 0, -1)
      end
    end,
  })

  require("99").vibe()
end

return {
  {
    "ThePrimeagen/99",
    keys = {
      {
        "<leader>9s",
        function()
          require("99").search()
        end,
        mode = "n",
        desc = "99: Search (agentic)",
      },
      {
        "<leader>9v",
        function()
          require("99").visual()
        end,
        mode = "v",
        desc = "99: Replace Visual Selection",
      },
      {
        "<leader>9b",
        vibe_with_line_marker,
        mode = "n",
        desc = "99: Vibe (agentic edit)",
      },
      {
        "<leader>9o",
        function()
          require("99").open()
        end,
        mode = "n",
        desc = "99: Open Last Result",
      },
      {
        "<leader>9x",
        function()
          require("99").stop_all_requests()
        end,
        mode = "n",
        desc = "99: Stop All Requests",
      },
      {
        "<leader>9l",
        function()
          require("99").view_logs()
        end,
        mode = "n",
        desc = "99: View Logs",
      },
      {
        "<leader>9c",
        function()
          require("99").clear_previous_requests()
        end,
        mode = "n",
        desc = "99: Clear Previous Requests",
      },
      {
        "<leader>9m",
        function()
          require("99.extensions.telescope").select_model()
        end,
        mode = "n",
        desc = "99: Select Model",
      },
      {
        "<leader>9p",
        function()
          require("99.extensions.telescope").select_provider()
        end,
        mode = "n",
        desc = "99: Select Provider",
      },
    },
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      local _99 = require("99")
      local cwd = vim.uv.cwd() or "nvim"
      local basename = vim.fs.basename(cwd)

      _99.setup({
        -- Provider: OpenCodeProvider (default) or ClaudeCodeProvider.
        -- Both `opencode` and `claude` CLIs must be on $PATH for the chosen one.
        -- Using ClaudeCodeProvider because `claude` is already authed; OpenCode
        -- on this machine only has GitHub Copilot OAuth, which doesn't expose
        -- the default `claude-sonnet-4-5` model.
        provider = _99.Providers.ClaudeCodeProvider,
        -- Logs go to a per-project file so multiple nvim sessions don't clobber.
        logger = {
          level = _99.INFO,
          path = "/tmp/" .. basename .. ".99.log",
          print_on_error = true,
        },

        -- Must live inside CWD or the underlying CLI will refuse permissions.
        tmp_dir = "./tmp",

        -- Auto-pull AGENT.md from project root upward when present.
        md_files = { "AGENT.md" },

        completion = {
          source = "blink", -- LazyVim ships blink.cmp
        },
      })
    end,
  },
}
