-- Dependency gating for tools that LazyVim installs automatically.
--
-- The per-language files gate on their *language* toolchain, but mason.nvim,
-- mason-lspconfig and nvim-treesitter collect `ensure_installed` across every
-- file and install on each startup. A package often needs a *different*
-- toolchain than its language (yamlls is npm, sqls is Go, svls is cargo), so a
-- machine without that toolchain reports install errors on every startup.
--
-- These specs are merged after `{ import = "plugins" }` (see config/lazy.lua)
-- so they see the final lists and drop entries whose toolchain is missing.
-- Anything skipped is listed by `:checkhealth config`.

local M = {}

---@type string[] "<item> (needs <tool>)" entries, shown by :checkhealth config
M.skipped = {}

local function has(...)
  for _, name in ipairs({ ... }) do
    if vim.fn.executable(name) == 1 then
      return true
    end
  end
  return false
end

local function skip(what, missing)
  M.skipped[#M.skipped + 1] = ("%s (needs %s)"):format(what, missing)
end

-- mason source type (the `pkg:<type>/` prefix of a package's purl) -> installer present?
-- github / generic / openvsx sources are plain downloads and need nothing beyond mason itself.
local installers = {
  npm = function()
    return has("npm") and has("node")
  end,
  pypi = function()
    return has("python3", "python")
  end,
  golang = function()
    return has("go")
  end,
  cargo = function()
    return has("cargo")
  end,
  gem = function()
    return has("gem")
  end,
  nuget = function()
    return has("dotnet")
  end,
  opam = function()
    return has("opam")
  end,
  luarocks = function()
    return has("luarocks")
  end,
  composer = function()
    return has("composer")
  end,
}

-- interpreter prefix in a package's `bin` entries (e.g. "node:out/index.js") -> runtime present?
local runtimes = {
  node = function()
    return has("node")
  end,
  python = function()
    return has("python3", "python")
  end,
  java = function()
    return has("java")
  end,
}

--- Whether mason can install *and run* a package on this machine.
--- Unknown packages pass through so mason reports them itself.
---@param name string mason package name
---@return boolean ok
---@return string? missing the toolchain that is missing
function M.can_install(name)
  local ok, pkg = pcall(require("mason-registry").get_package, name)
  if not ok then
    return true
  end
  local source = pkg.spec.source.id:match("^pkg:([%w_]+)/")
  if source and installers[source] and not installers[source]() then
    return false, source
  end
  for _, bin in pairs(pkg.spec.bin or {}) do
    local prefix = type(bin) == "string" and bin:match("^(%a+):") or nil
    if prefix and runtimes[prefix] and not runtimes[prefix]() then
      return false, prefix
    end
  end
  return true
end

-- nvim-treesitter `main` compiles parsers from source: it needs a C compiler, tar and
-- curl (LazyVim installs the tree-sitter CLI itself). Mirrors LazyVim.treesitter.check().
local function can_build_parsers()
  local have_cc = vim.env.CC ~= nil or has("cc") or (vim.fn.has("win32") == 1 and has("cl", "gcc"))
  return have_cc and has("tar") and has("curl")
end

-- A linter binary mason installed is on PATH only once mason.setup() has run, which can
-- be after the first lint event; look in mason's bin dir directly as well.
local function linter_available(cmd)
  if type(cmd) ~= "string" then
    return true
  end
  return has(cmd) or (vim.uv or vim.loop).fs_stat(vim.fn.stdpath("data") .. "/mason/bin/" .. cmd) ~= nil
end

M.specs = {
  -- Mason tools: LazyVim's own mason config, plus the toolchain filter. The registry is
  -- only available after setup(), so this has to live in config rather than opts.
  {
    "mason-org/mason.nvim",
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed or {}) do
          local ok, p = pcall(mr.get_package, tool)
          if not ok then
            LazyVim.warn(("Unknown mason package `%s`"):format(tool), { title = "config.deps" })
          elseif not p:is_installed() then
            local can, missing = M.can_install(tool)
            if can then
              p:install()
            else
              skip(tool, missing)
            end
          end
        end
      end)
    end,
  },

  -- LSP servers: LazyVim hands every server in `opts.servers` to mason-lspconfig for
  -- installation unless `mason = false`. Servers whose package can't be installed here
  -- are either left to a manually installed binary or disabled outright.
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local ok, mlc = pcall(require, "mason-lspconfig")
      if not ok then
        return
      end
      local to_package = mlc.get_mappings().lspconfig_to_package
      for server, sopts in pairs(opts.servers or {}) do
        if sopts == true then
          sopts = {}
          opts.servers[server] = sopts
        end
        local package = to_package[server]
        if type(sopts) == "table" and sopts.enabled ~= false and sopts.mason ~= false and package then
          local can, missing = M.can_install(package)
          if not can then
            local cfg_ok, cfg = pcall(function()
              return vim.lsp.config[server]
            end)
            local cmd = sopts.cmd or (cfg_ok and type(cfg) == "table" and cfg.cmd) or nil
            local bin = type(cmd) == "table" and cmd[1] or nil
            if type(bin) == "string" and not has(bin) then
              sopts.enabled = false
              skip(server, missing)
            else
              sopts.mason = false -- binary exists (or cmd is dynamic): use it without mason
            end
          end
        end
      end
    end,
  },

  -- Treesitter parsers: without build tools, don't ask LazyVim to install any. Parsers
  -- already present keep working; missing ones just leave their filetype unhighlighted.
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" and #opts.ensure_installed > 0 and not can_build_parsers() then
        skip(("%d treesitter parsers"):format(#opts.ensure_installed), "a C compiler, tar and curl")
        opts.ensure_installed = {}
      end
    end,
  },

  -- Linters: nvim-lint raises an ERROR on every lint event when a linter binary is
  -- missing. Add a `condition` so missing linters are quietly skipped instead.
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      local lint = require("lint")
      opts.linters = opts.linters or {}
      local wrapped = {}
      for _, names in pairs(opts.linters_by_ft or {}) do
        for _, name in ipairs(names) do
          local user = opts.linters[name]
          local def = user ~= nil and user or lint.linters[name]
          -- only linters defined as tables can carry a condition; unknown names are
          -- left for LazyVim to warn about
          if not wrapped[name] and type(def) == "table" then
            wrapped[name] = true
            user = type(user) == "table" and user or {}
            opts.linters[name] = user
            local prev = user.condition
            user.condition = function(ctx)
              local cmd = lint.linters[name].cmd
              if type(cmd) == "function" then
                cmd = cmd()
              end
              if not linter_available(cmd) then
                return false
              end
              return prev == nil or prev(ctx)
            end
          end
        end
      end
    end,
  },
}

return M
