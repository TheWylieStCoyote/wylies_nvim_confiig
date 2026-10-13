-- codemmet: Emmet-style abbreviation expansion for code.
-- Requires the `codemmet` binary on PATH (cargo install codemmet). The plugin
-- tracks tagged releases so its Lua side stays in step with the installed binary.

-- Skip codemmet config if the binary is not installed
if vim.fn.executable("codemmet") ~= 1 then
  return {}
end

return {
  "TheWylieStCoyote/codemmet",
  version = "*",
  ft = {
    "rust",
    "python",
    "c",
    "cpp",
    "javascript",
    "javascriptreact",
    "go",
  },
  opts = {
    keymaps = {
      expand = "<A-e>", -- insert & normal: expand the abbreviation before the cursor
      wrap = "<leader>cw", -- visual: wrap the selection in an abbreviation
      snippets = "<leader>ccl", -- normal: browse snippets in a picker, expand the picked one
      context = "<leader>ccv", -- normal: show scopes + in-scope collections at the cursor
    },
    preview = {
      enabled = true, -- default true when a table is given
      debounce_ms = 100, -- typing-pause before the server is queried (default 60)
    },
  },
}
