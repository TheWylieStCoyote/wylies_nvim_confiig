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
      -- General prompts (using <leader>O for Ollama to avoid conflict with OCaml's <leader>o)
      { "<leader>Oo", "<cmd>Ollama<cr>", desc = "Ollama Prompt" },
      { "<leader>OO", "<cmd>OllamaModel<cr>", desc = "Select Model" },

      -- Code actions
      {
        "<leader>Og",
        ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
        mode = { "n", "v" },
        desc = "Generate Code",
      },
      {
        "<leader>Oe",
        ":<c-u>lua require('ollama').prompt('Explain_Code')<cr>",
        mode = { "n", "v" },
        desc = "Explain Code",
      },
      {
        "<leader>Or",
        ":<c-u>lua require('ollama').prompt('Review_Code')<cr>",
        mode = { "n", "v" },
        desc = "Review Code",
      },
      {
        "<leader>Of",
        ":<c-u>lua require('ollama').prompt('Fix_Code')<cr>",
        mode = { "n", "v" },
        desc = "Fix Code",
      },
      {
        "<leader>Ot",
        ":<c-u>lua require('ollama').prompt('Add_Tests')<cr>",
        mode = { "n", "v" },
        desc = "Add Tests",
      },
      {
        "<leader>Od",
        ":<c-u>lua require('ollama').prompt('Add_Docs')<cr>",
        mode = { "n", "v" },
        desc = "Add Documentation",
      },
      {
        "<leader>Os",
        ":<c-u>lua require('ollama').prompt('Simplify_Code')<cr>",
        mode = { "n", "v" },
        desc = "Simplify Code",
      },
      -- Git commit message with integrated commit
      {
        "<leader>Om",
        function()
          vim.fn.system("curl -s --max-time 1 http://localhost:11434 2>/dev/null")
          if vim.v.shell_error ~= 0 then
            vim.notify("Ollama not running", vim.log.levels.WARN)
            return
          end

          local diff = vim.fn.system("git diff --cached")
          if diff == "" then
            vim.notify("No staged changes", vim.log.levels.WARN)
            return
          end

          -- Create output buffer
          local buf = vim.api.nvim_create_buf(false, true)
          vim.bo[buf].buftype = "nofile"
          vim.bo[buf].bufhidden = "wipe"
          vim.bo[buf].filetype = "markdown"
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Generating commit message..." })

          -- Create floating window
          local width = math.min(80, math.floor(vim.o.columns * 0.8))
          local height = math.min(20, math.floor(vim.o.lines * 0.6))
          local win = vim.api.nvim_open_win(buf, true, {
            relative = "editor",
            width = width,
            height = height,
            row = math.floor((vim.o.lines - height) / 2),
            col = math.floor((vim.o.columns - width) / 2),
            style = "minimal",
            border = "rounded",
            title = " Commit Message (Enter=commit, q/Esc=cancel) ",
            title_pos = "center",
          })

          -- Keybinding: Enter to commit
          vim.keymap.set("n", "<CR>", function()
            local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
            local msg = table.concat(lines, "\n"):gsub("^%s+", ""):gsub("%s+$", "")
            if msg == "" or msg == "Generating commit message..." then
              vim.notify("No commit message to use", vim.log.levels.WARN)
              return
            end
            vim.api.nvim_win_close(win, true)
            local result = vim.fn.system({ "git", "commit", "-m", msg })
            if vim.v.shell_error == 0 then
              vim.notify("Committed successfully!", vim.log.levels.INFO)
            else
              vim.notify("Commit failed: " .. result, vim.log.levels.ERROR)
            end
          end, { buffer = buf, desc = "Commit with this message" })

          -- Keybinding: q or Esc to close
          local close_win = function()
            vim.api.nvim_win_close(win, true)
          end
          vim.keymap.set("n", "q", close_win, { buffer = buf, desc = "Cancel" })
          vim.keymap.set("n", "<Esc>", close_win, { buffer = buf, desc = "Cancel" })

          -- Build prompt
          local prompt = "Write a concise git commit message for these changes. "
            .. "Follow conventional commits format (feat:, fix:, refactor:, docs:, etc.). "
            .. "First line under 50 chars, then blank line, then bullet points if needed. "
            .. "Only output the commit message.\n\n"
            .. diff

          -- Call Ollama API using vim.system (built-in, more reliable than plenary.curl)
          local ollama = require("ollama")
          local request_body = vim.json.encode({
            model = ollama.config.model,
            prompt = prompt,
            stream = true,
          })

          -- Use stdin to pass data (avoids E2BIG for large diffs)
          vim.system({ "curl", "-sN", ollama.config.url .. "/api/generate", "-d", "@-" }, {
            stdin = request_body,
            stdout = function(_, data)
              if not data then
                return
              end
              vim.schedule(function()
                if not vim.api.nvim_buf_is_valid(buf) then
                  return
                end
                -- Process each line (streaming JSON)
                for line in data:gmatch("[^\n]+") do
                  local ok, body = pcall(vim.json.decode, line)
                  if ok and body and body.response then
                    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
                    if lines[1] == "Generating commit message..." then
                      lines = { "" }
                    end
                    local last_line = lines[#lines] or ""
                    local new_text = last_line .. body.response
                    local new_lines = vim.split(new_text, "\n", { plain = true })
                    lines[#lines] = new_lines[1]
                    for i = 2, #new_lines do
                      table.insert(lines, new_lines[i])
                    end
                    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
                  end
                end
              end)
            end,
            stderr = function(_, data)
              if data and data ~= "" then
                vim.schedule(function()
                  vim.notify("Ollama error: " .. data, vim.log.levels.ERROR)
                end)
              end
            end,
          })
        end,
        desc = "Generate Commit Message",
      },
    },
    opts = {
      model = "codellama:13b", -- Default model (change to "deepseek-coder" or others)
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
        -- Generate_Commit uses direct API call, see <leader>om keybinding
      },
    },
  },
}
