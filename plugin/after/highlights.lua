-- Readability fixes for groups the current theme leaves unreadable.
--
-- The Omarchy/aether theme reuses its cream selection color (#f4eedd) as a
-- background for several groups without setting a matching foreground:
-- LspReferenceText/Read are #f4eedd on #f4eedd (contrast 1.00:1 -- the symbol
-- under the cursor disappears), while Visual, DiffText, QuickFixLine and
-- WildMenu set no foreground at all and inherit Normal's light one.
--
-- Rather than hardcode colors, give any of these groups whose contrast falls
-- below MIN_CONTRAST a foreground drawn from the theme's own palette, chosen
-- dark or light to suit the background. Groups that are already readable are
-- left untouched, so a theme that gets this right loses nothing.
--
-- Loaded before transparency.lua (plugin files are sourced alphabetically), so
-- this autocmd runs first.

local groups = {
  "Visual",
  "VisualNOS",
  "DiffText",
  "QuickFixLine",
  "WildMenu",
  "LspReferenceText",
  "LspReferenceRead",
  "LspReferenceWrite",
}

local MIN_CONTRAST = 3

-- How much of the theme's own highlight color to keep when it is too bright
-- for a dark theme; the remainder is mixed in from the theme background.
-- 1.0 leaves the theme's color untouched, 0.0 collapses it into the background.
-- Lower this to dim the selection further.
local BRIGHT_BLEND = 0.7

local function channels(rgb)
  return math.floor(rgb / 0x10000) % 0x100, math.floor(rgb / 0x100) % 0x100, rgb % 0x100
end

-- WCAG relative luminance.
local function luminance(rgb)
  local function linear(v)
    v = v / 255
    return v <= 0.03928 and v / 12.92 or ((v + 0.055) / 1.055) ^ 2.4
  end
  local r, g, b = channels(rgb)
  return 0.2126 * linear(r) + 0.7152 * linear(g) + 0.0722 * linear(b)
end

local function blend(fg, bg, amount)
  local fr, fg_, fb = channels(fg)
  local br, bg_, bb = channels(bg)
  local function mix(f, b)
    return math.floor(b + (f - b) * amount + 0.5)
  end
  return mix(fr, br) * 0x10000 + mix(fg_, bg_) * 0x100 + mix(fb, bb)
end

local function contrast(a, b)
  local x, y = luminance(a), luminance(b)
  if x < y then
    x, y = y, x
  end
  return (x + 0.05) / (y + 0.05)
end

-- Themes publish their palette as g:terminal_color_*, which transparency.lua
-- never touches -- a more reliable source for the theme's background than
-- Normal, whose background may already have been cleared by the time we run.
local function terminal_color(n, fallback)
  local value = vim.g["terminal_color_" .. n]
  local rgb = type(value) == "string" and tonumber((value:gsub("^#", "")), 16)
  return rgb or fallback
end

-- Resolved once per colorscheme, then written by every pass. Recomputing from
-- the live highlights instead would re-blend an already-blended background and
-- darken it further on each pass.
local resolved = {}

local function refresh()
  local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  local inherited = normal.fg or terminal_color(7, 0xffffff)
  -- The two candidate foregrounds: the theme's background (dark) and its
  -- foreground (light). Whichever contrasts better with a given background wins.
  local on_light = normal.bg or terminal_color(0, 0x000000)
  local on_dark = inherited
  local base = normal.bg or terminal_color(0, 0x000000)
  local dark_theme = luminance(base) < 0.5

  resolved = {}
  for _, group in ipairs(groups) do
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    -- A group with no background of its own has nothing to fix.
    if hl.bg then
      -- A near-white background over a whole selected line is glaring on a
      -- dark theme; mix it back toward the theme background.
      if dark_theme and luminance(hl.bg) > 0.5 then
        hl.bg = blend(hl.bg, base, BRIGHT_BLEND)
      end

      -- With no foreground of its own the text keeps Normal's.
      local fg = hl.fg or inherited
      if contrast(fg, hl.bg) < MIN_CONTRAST then
        -- Pick by measured contrast rather than a luminance threshold, which
        -- chooses badly for backgrounds sitting near the middle of the range.
        hl.fg = contrast(on_light, hl.bg) >= contrast(on_dark, hl.bg) and on_light or on_dark
      end

      resolved[group] = hl
    end
  end
end

local function apply()
  for group, hl in pairs(resolved) do
    vim.api.nvim_set_hl(0, group, hl)
  end
end

local augroup = vim.api.nvim_create_augroup("highlights", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup,
  callback = function()
    refresh()
    apply()
    vim.schedule(apply)
  end,
})

refresh()
apply()
