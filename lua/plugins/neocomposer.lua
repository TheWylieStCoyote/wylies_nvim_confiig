-- NeoComposer Configuration
-- Macro management with browse, edit, and replay via telescope

-- sqlite.lua loads libsqlite3 through LuaJIT's FFI. Under the snap build of
-- Neovim the system `libsqlite3.so` needs a newer glibc than the snap ships,
-- while the versioned `libsqlite3.so.0` resolves to a compatible copy. Probe
-- for a loadable library and point sqlite.lua at it; skip NeoComposer if none.
-- (This can't be `pcall(require, "sqlite")`: that runs before lazy has
-- installed the plugin, so it never passes and the plugin never gets installed.)
local sqlite_lib
for _, lib in ipairs({ vim.g.sqlite_clib_path or "libsqlite3", "libsqlite3.so.0" }) do
  if pcall(require("ffi").load, lib) then
    sqlite_lib = lib
    break
  end
end
if not sqlite_lib then
  return {}
end
vim.g.sqlite_clib_path = sqlite_lib

return {
  {
    "ecthelionvi/NeoComposer.nvim",
    dependencies = { "kkharji/sqlite.lua" },
    event = "VeryLazy",
    opts = {
      notify = true,
      delay_timer = 150,
      queue_most_recent = false,
      window = {
        width = 60,
        height = 10,
        border = "rounded",
        winhl = {
          Normal = "ComposerNormal",
        },
      },
      colors = {
        bg = "#16161e",
        fg = "#ff9e64",
        red = "#ec5f67",
        blue = "#5fb3b3",
        green = "#99c794",
      },
      keymaps = {
        play_macro = "Q",
        yank_macro = "yq",
        stop_macro = "cq",
        toggle_record = "q",
        cycle_next = "<c-n>",
        cycle_prev = "<c-p>",
        toggle_macro_menu = "<m-q>",
      },
    },
  },
}
