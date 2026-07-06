-- codemmet: Emmet-style abbreviation expansion for code.
-- Loaded from a local clone (no remote repo). The `codemmet` binary is
-- installed on PATH via `cargo install --path crates/codemmet`, so the plugin's
-- default `cmd = { "codemmet", "lsp" }` finds it; no `build`/`cmd` needed here.
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
    "typescript",
    "typescriptreact",
    "go",
  },
  opts = {
    keymaps = {
      expand = "<A-e>", -- insert & normal: expand the abbreviation before the cursor
      wrap = "<leader>cw", -- visual: wrap the selection in an abbreviation
    },
  },
}
