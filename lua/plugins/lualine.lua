-- Lualine Enhancements
-- Additional statusline components

return {
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      -- Macro recording indicator
      local function macro_recording()
        local reg = vim.fn.reg_recording()
        if reg ~= "" then
          return "Recording @" .. reg
        end
        return ""
      end

      -- Search count indicator
      local function search_count()
        if vim.v.hlsearch == 0 then
          return ""
        end
        local ok, result = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 500 })
        if not ok or next(result) == nil then
          return ""
        end
        local denominator = math.min(result.total, result.maxcount)
        return string.format("[%d/%d]", result.current, denominator)
      end

      opts.sections = opts.sections or {}
      opts.sections.lualine_x = opts.sections.lualine_x or {}

      -- Add macro recording indicator (high visibility)
      table.insert(opts.sections.lualine_x, 1, {
        macro_recording,
        cond = function()
          return vim.fn.reg_recording() ~= ""
        end,
        color = { fg = "DiagnosticError", gui = "bold" },
      })

      -- Add search count indicator
      table.insert(opts.sections.lualine_x, 2, {
        search_count,
        cond = function()
          return vim.v.hlsearch == 1
        end,
        color = { fg = "DiagnosticOk" },
      })
    end,
  },
}
