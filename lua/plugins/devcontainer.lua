-- Devcontainer Configuration
-- VSCode-like devcontainer support for Neovim

return {
  {
    "esensar/nvim-dev-container",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = {
      "DevcontainerStart",
      "DevcontainerAttach",
      "DevcontainerExec",
      "DevcontainerStop",
      "DevcontainerStopAll",
      "DevcontainerRemoveAll",
      "DevcontainerLogs",
      "DevcontainerEditNearestConfig",
      "DevcontainerComposeUp",
      "DevcontainerComposeDown",
      "DevcontainerComposeRm",
    },
    config = function()
      require("devcontainer").setup({
        -- Generate devcontainer.json commands
        generate_commands = true,

        -- Terminal handler for attaching
        terminal_handler = function(command)
          -- Open in new terminal buffer
          vim.cmd("tabnew")
          vim.fn.termopen(command)
          vim.cmd("startinsert")
        end,

        -- Neovim installation in container
        nvim_installation = {
          -- How to install nvim: "download" or "build"
          method = "download",
          -- Install as root or regular user
          prefer_root_user = false,
        },

        -- Container runtime: "docker" or "podman"
        container_runtime = "docker",

        -- Docker compose command: "docker-compose" or "docker compose"
        compose_command = "docker compose",

        -- Mount local Neovim directories into container
        attach_mounts = {
          -- Mount neovim config
          neovim_config = {
            enabled = true,
            options = { "readonly" },
          },
          -- Mount neovim data (plugins, etc.)
          neovim_data = {
            enabled = true,
            options = {},
          },
          -- Mount neovim state
          neovim_state = {
            enabled = false,
            options = {},
          },
          -- Custom mounts
          custom_mounts = {
            -- Mount SSH keys for git authentication
            {
              type = "bind",
              source = vim.fn.expand("$HOME/.ssh"),
              target = "/home/vscode/.ssh",
              options = { "readonly" },
            },
            -- Also mount to root in case container runs as root
            {
              type = "bind",
              source = vim.fn.expand("$HOME/.ssh"),
              target = "/root/.ssh",
              options = { "readonly" },
            },
            -- Mount git config
            {
              type = "bind",
              source = vim.fn.expand("$HOME/.gitconfig"),
              target = "/home/vscode/.gitconfig",
              options = { "readonly" },
            },
          },
        },

        -- Automatic features
        autocommands = {
          -- Auto-initialize container when opening devcontainer project
          init = false,
          -- Auto-cleanup when vim exits
          clean = false,
          -- Auto-update container when config changes
          update = false,
        },

        -- Search for devcontainer.json recursively
        config_search_start = function()
          -- Start search from git root or cwd
          local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
          if vim.v.shell_error == 0 and git_root ~= "" then
            return git_root
          end
          return vim.fn.getcwd()
        end,

        -- Log level: "trace", "debug", "info", "warn", "error"
        log_level = "info",

        -- Cache directory for container images
        cache_images = true,

        -- Container environment variables
        container_env = {
          -- TERM = "xterm-256color",
        },

        -- Default image when creating new devcontainer.json
        default_image = "mcr.microsoft.com/devcontainers/base:ubuntu",

        -- Workspace folder inside container
        workspace_folder_provider = function()
          return "/workspaces/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        end,
      })
    end,

    keys = {
      -- Start/Attach
      { "<leader>Vs", "<cmd>DevcontainerStart<cr>", desc = "Devcontainer: Start" },
      { "<leader>Va", "<cmd>DevcontainerAttach<cr>", desc = "Devcontainer: Attach" },
      { "<leader>Ve", "<cmd>DevcontainerExec<cr>", desc = "Devcontainer: Execute" },

      -- Stop/Remove
      { "<leader>Vx", "<cmd>DevcontainerStop<cr>", desc = "Devcontainer: Stop" },
      { "<leader>VX", "<cmd>DevcontainerStopAll<cr>", desc = "Devcontainer: Stop All" },
      { "<leader>VR", "<cmd>DevcontainerRemoveAll<cr>", desc = "Devcontainer: Remove All" },

      -- Logs
      { "<leader>Vl", "<cmd>DevcontainerLogs<cr>", desc = "Devcontainer: Logs" },

      -- Config
      { "<leader>Vc", "<cmd>DevcontainerEditNearestConfig<cr>", desc = "Devcontainer: Edit Config" },

      -- Compose
      { "<leader>Vu", "<cmd>DevcontainerComposeUp<cr>", desc = "Devcontainer: Compose Up" },
      { "<leader>Vd", "<cmd>DevcontainerComposeDown<cr>", desc = "Devcontainer: Compose Down" },
      { "<leader>Vr", "<cmd>DevcontainerComposeRm<cr>", desc = "Devcontainer: Compose Remove" },
    },
  },
}
