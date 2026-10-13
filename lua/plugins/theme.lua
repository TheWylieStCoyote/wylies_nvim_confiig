-- Theme loader.
--
-- On Omarchy, the active theme ships its own lazy spec at
-- ~/.local/state/omarchy/current/theme/neovim.lua (a symlink Omarchy swaps on
-- theme change; omarchy-theme-hotreload.lua watches it). Load that when it
-- exists; otherwise fall back to monokai-pro so other machines still get a
-- colorscheme instead of a "Failed to load plugins.theme" error.

local omarchy_theme = vim.fn.expand("~/.local/state/omarchy/current/theme/neovim.lua")
if (vim.uv or vim.loop).fs_stat(omarchy_theme) then
  return dofile(omarchy_theme)
end

return {
  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup({
        filter = "ristretto",
        override = function()
          return {
            NonText = { fg = "#948a8b" },
            MiniIconsGrey = { fg = "#948a8b" },
            MiniIconsRed = { fg = "#fd6883" },
            MiniIconsBlue = { fg = "#85dacc" },
            MiniIconsGreen = { fg = "#adda78" },
            MiniIconsYellow = { fg = "#f9cc6c" },
            MiniIconsOrange = { fg = "#f38d70" },
            MiniIconsPurple = { fg = "#a8a9eb" },
            MiniIconsAzure = { fg = "#a8a9eb" },
            MiniIconsCyan = { fg = "#85dacc" }, -- same value as MiniIconsBlue for consistency
          }
        end,
      })
      vim.cmd([[colorscheme monokai-pro]])
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "monokai-pro",
    },
  },
}
