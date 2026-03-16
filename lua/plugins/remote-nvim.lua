-- Remote Neovim Configuration
-- Remote development via SSH, Docker, and devcontainers

return {
  {
    "amitds1997/remote-nvim.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = {
      "RemoteStart",
      "RemoteStop",
      "RemoteInfo",
      "RemoteCleanup",
      "RemoteConfigDel",
      "RemoteLog",
    },
    config = function()
      require("remote-nvim").setup({
        -- Connection settings
        ssh_config = {
          ssh_binary = "ssh",
          scp_binary = "scp",
          ssh_config_file_paths = { "$HOME/.ssh/config" },
          ssh_prompts = {
            {
              match = "password:",
              type = "secret",
              value_type = "static",
              value = "",
            },
            {
              match = "continue connecting",
              type = "plain",
              value_type = "static",
              value = "yes",
            },
          },
        },

        -- Neovim installation on remote
        neovim_install_behavior = "prompt", -- "prompt", "auto", "manual"
        neovim_user_config = {
          -- What to copy to remote
          config_copy = "clean", -- "clean" = just init.lua, "full" = entire config
          -- Use local config only (don't sync plugins)
          local_neovim_only = false,
        },

        -- Remote workspace settings
        remote = {
          -- Copy directories to remote (relative to stdpath("config"))
          copy_dirs = {
            config = {
              base = vim.fn.stdpath("config"),
              dirs = "*", -- Copy all config
              compression = {
                enabled = true,
                additional_opts = { "--exclude-vcs" },
              },
            },
            data = {
              base = vim.fn.stdpath("data"),
              dirs = { "lazy" }, -- Copy lazy plugin manager data
              compression = {
                enabled = true,
              },
            },
            cache = {
              base = vim.fn.stdpath("cache"),
              dirs = {},
            },
            state = {
              base = vim.fn.stdpath("state"),
              dirs = {},
            },
          },
        },

        -- Devcontainer/Docker settings (requires devpod)
        devpod = {
          binary = "devpod",
          docker_binary = "docker",
          -- Add any devpod-specific settings here
        },

        -- Offline mode (for air-gapped environments)
        offline_mode = {
          enabled = false,
          no_github = false,
          -- cache_dir = vim.fn.stdpath("cache") .. "/remote-nvim",
        },

        -- Progress viewer settings
        progress_view = {
          type = "popup", -- "popup" or "split"
        },

        -- Log level
        log = {
          level = "info", -- "trace", "debug", "info", "warn", "error"
        },

        -- Client callbacks
        client_callback = function(port, _workspace_config)
          -- Called when remote server is ready
          -- Opens a new Neovim instance connected to the remote
          local cmd = ("nvim --server localhost:%s --remote-ui"):format(port)
          vim.fn.jobstart(cmd, {
            detach = true,
            on_exit = function(_, exit_code)
              if exit_code ~= 0 then
                vim.notify("Remote Neovim client exited with code " .. exit_code, vim.log.levels.WARN)
              end
            end,
          })
        end,
      })
    end,

    keys = {
      -- Start remote connection
      { "<leader>Rs", "<cmd>RemoteStart<cr>", desc = "Remote: Start" },

      -- Stop remote connection
      { "<leader>Rx", "<cmd>RemoteStop<cr>", desc = "Remote: Stop" },

      -- Session info
      { "<leader>Ri", "<cmd>RemoteInfo<cr>", desc = "Remote: Info" },

      -- Cleanup remote resources
      { "<leader>Rc", "<cmd>RemoteCleanup<cr>", desc = "Remote: Cleanup" },

      -- Delete saved config
      { "<leader>Rd", "<cmd>RemoteConfigDel<cr>", desc = "Remote: Delete Config" },

      -- View logs
      { "<leader>Rl", "<cmd>RemoteLog<cr>", desc = "Remote: Logs" },
    },
  },
}
