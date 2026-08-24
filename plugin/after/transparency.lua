-- Use the terminal (system) background everywhere: clear the background of the
-- groups below and let whatever is behind the terminal show through.
--
-- Re-applied on every ColorScheme event so it survives `:colorscheme`, LazyVim's
-- colorscheme load and the omarchy theme hotreload (see plugins/omarchy-theme-hotreload.lua).

local groups = {
  -- editor
  "Normal",
  "NormalFloat",
  "FloatBorder",
  "Pmenu",
  "Terminal",
  "EndOfBuffer",
  "FoldColumn",
  "Folded",
  "SignColumn",
  "NormalNC",
  "WhichKeyFloat",
  "TelescopeBorder",
  "TelescopeNormal",
  "TelescopePromptBorder",
  "TelescopePromptTitle",

  -- neotree
  "NeoTreeNormal",
  "NeoTreeNormalNC",
  "NeoTreeVertSplit",
  "NeoTreeWinSeparator",
  "NeoTreeEndOfBuffer",

  -- nvim-tree
  "NvimTreeNormal",
  "NvimTreeVertSplit",
  "NvimTreeEndOfBuffer",

  -- notify
  "NotifyINFOBody",
  "NotifyERRORBody",
  "NotifyWARNBody",
  "NotifyTRACEBody",
  "NotifyDEBUGBody",
  "NotifyINFOTitle",
  "NotifyERRORTitle",
  "NotifyWARNTitle",
  "NotifyTRACETitle",
  "NotifyDEBUGTitle",
  "NotifyINFOBorder",
  "NotifyERRORBorder",
  "NotifyWARNBorder",
  "NotifyTRACEBorder",
  "NotifyDEBUGBorder",
}

local function clear_bg(group)
  -- Resolve links so we copy the effective attributes, then drop only the
  -- background: nvim_set_hl replaces the whole definition, so re-setting
  -- `{ bg = "none" }` alone would also throw away the theme's foreground.
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
  if not ok then
    return
  end

  hl.bg = nil
  hl.ctermbg = nil
  hl.blend = nil
  vim.api.nvim_set_hl(0, group, hl)
end

local function apply()
  for _, group in ipairs(groups) do
    clear_bg(group)
  end
end

local augroup = vim.api.nvim_create_augroup("transparency", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup,
  callback = function()
    apply()
    -- Some plugins install their own ColorScheme handlers after this one and
    -- repaint their backgrounds; run once more after they have had their turn.
    vim.schedule(apply)
  end,
})

apply()
