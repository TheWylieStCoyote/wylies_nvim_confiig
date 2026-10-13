-- Mason Configuration
-- Language files add tools via `ensure_installed`. config/deps.lua filters the
-- final list so packages whose toolchain (npm, pip, go, cargo, ...) is missing
-- are skipped instead of failing on every startup; `:checkhealth config` lists
-- what was skipped. Use :Mason to install packages manually.

return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
}
