-- Custom health check for this Neovim configuration
-- Run with :checkhealth config

local M = {}

-- Helper to check if executable exists
local function check_executable(name, optional)
  if vim.fn.executable(name) == 1 then
    vim.health.ok(name .. " found")
    return true
  else
    if optional then
      vim.health.warn(name .. " not found (optional)")
    else
      vim.health.error(name .. " not found")
    end
    return false
  end
end

-- Helper to check if a Lua module can be loaded
local function check_module(name)
  local ok, _ = pcall(require, name)
  if ok then
    vim.health.ok("Module '" .. name .. "' loaded")
    return true
  else
    vim.health.warn("Module '" .. name .. "' not available")
    return false
  end
end

M.check = function()
  -- Core dependencies
  vim.health.start("Core Dependencies")
  check_executable("git")
  check_executable("rg", false) -- ripgrep
  check_executable("fd", false)
  check_executable("node", true) -- for Copilot, LSPs
  check_executable("npm", true)

  -- Python
  vim.health.start("Python Environment")
  local has_python = check_executable("python3", true) or check_executable("python", true)
  if has_python then
    check_executable("pip", true)
  end

  -- Language toolchains (optional)
  vim.health.start("Language Toolchains (optional)")
  check_executable("go", true)
  check_executable("cargo", true)
  check_executable("rustc", true)
  check_executable("gcc", true)
  check_executable("clang", true)
  check_executable("java", true)
  check_executable("ruby", true)
  check_executable("elixir", true)
  check_executable("zig", true)
  check_executable("julia", true)
  check_executable("dotnet", true)
  check_executable("ghcup", true)
  check_executable("opam", true)
  check_executable("R", true)
  check_executable("docker", true)
  check_executable("terraform", true)

  -- AI tools
  vim.health.start("AI Tools (optional)")
  check_executable("ollama", true)

  -- Neovim version
  vim.health.start("Neovim Version")
  local v = vim.version()
  local version_str = string.format("%d.%d.%d", v.major, v.minor, v.patch)
  if v.major >= 0 and v.minor >= 10 then
    vim.health.ok("Neovim " .. version_str .. " (recommended)")
  elseif v.major >= 0 and v.minor >= 9 then
    vim.health.warn("Neovim " .. version_str .. " (0.10+ recommended)")
  else
    vim.health.error("Neovim " .. version_str .. " (0.9+ required)")
  end

  -- Configuration
  vim.health.start("Configuration")
  local config_path = vim.fn.stdpath("config")
  if vim.fn.isdirectory(config_path .. "/lua/config") == 1 then
    vim.health.ok("Config directory found: " .. config_path)
  else
    vim.health.error("Config directory not found")
  end

  if vim.fn.isdirectory(config_path .. "/lua/plugins") == 1 then
    vim.health.ok("Plugins directory found")
  else
    vim.health.error("Plugins directory not found")
  end

  -- Lazy.nvim
  vim.health.start("Plugin Manager")
  local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if vim.fn.isdirectory(lazy_path) == 1 then
    vim.health.ok("lazy.nvim installed")
  else
    vim.health.error("lazy.nvim not found at " .. lazy_path)
  end

  -- Mason
  vim.health.start("Mason (LSP/DAP/Linter Manager)")
  local mason_path = vim.fn.stdpath("data") .. "/mason"
  if vim.fn.isdirectory(mason_path) == 1 then
    vim.health.ok("Mason directory found")
    local mason_bin = mason_path .. "/bin"
    if vim.fn.isdirectory(mason_bin) == 1 then
      local handle = io.popen("ls -1 " .. mason_bin .. " 2>/dev/null | wc -l")
      if handle then
        local count = handle:read("*a"):gsub("%s+", "")
        handle:close()
        vim.health.ok(count .. " tools installed via Mason")
      end
    end
  else
    vim.health.warn("Mason not yet initialized (run :Mason)")
  end

  -- TreeSitter
  vim.health.start("TreeSitter")
  if check_module("nvim-treesitter") then
    local parsers = require("nvim-treesitter.info").installed_parsers()
    vim.health.ok(#parsers .. " parsers installed")
  end
end

return M
