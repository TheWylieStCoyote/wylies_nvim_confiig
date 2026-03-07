-- Tiny Inline Diagnostic Configuration
-- Non-disruptive inline diagnostic display with multiline support

return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000,
    config = function()
      -- Disable default virtual text diagnostics since this plugin replaces them
      vim.diagnostic.config({ virtual_text = false })

      require("tiny-inline-diagnostic").setup({
        preset = "modern",
        transparent_bg = false,
        hi = {
          error = "DiagnosticError",
          warn = "DiagnosticWarn",
          info = "DiagnosticInfo",
          hint = "DiagnosticHint",
          arrow = "NonText",
          background = "CursorLine",
          mixing_color = "None",
        },
        options = {
          show_source = true,
          multilines = {
            enabled = true,
            always_show = false,
          },
          show_all_diags_on_cursorline = true,
          enable_on_insert = false,
          throttle = 100,
          softwrap = 30,
          overflow = {
            mode = "wrap",
          },
        },
      })
    end,
  },
}
