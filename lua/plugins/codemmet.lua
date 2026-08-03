-- codemmet: Emmet-style abbreviation expansion for code.
-- Loaded from a local clone (no remote repo). TESTING feat/nvim-dot-repeat
-- (master + wrap-as-operator + dot-repeat for wrap/expand; the existing
-- expand/wrap keymaps below gain the new behavior automatically — no new
-- bindings needed). `cmd` points at the branch-built release binary because
-- the snippet browser/context viewer need server commands the PATH-installed
-- binary predates. Rebuild after switching branches:
--   cargo build --release -p codemmet
-- To return to the installed binary, delete `cmd` (default: codemmet on PATH).
return {
  dir = "/home/wylie/Documents/projects/codetools/codemmet",
  name = "codemmet",
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
    cmd = { "/home/wylie/Documents/projects/codetools/codemmet/target/release/codemmet", "lsp" },
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
