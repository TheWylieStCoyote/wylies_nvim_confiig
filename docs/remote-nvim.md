# Remote Neovim - Remote Development

> SSH, Docker, and devcontainer support for remote editing

## Quick Reference

| Component | Tool |
|-----------|------|
| Plugin | amitds1997/remote-nvim.nvim |
| Features | SSH connections, Docker containers, devcontainers |
| Dependencies | plenary.nvim, nui.nvim, telescope.nvim |

## Features

- **SSH Connections** - Connect to remote servers via SSH (password, key-based, or ssh_config)
- **Docker Support** - Develop inside Docker containers
- **Devcontainers** - Full devcontainer support (requires devpod)
- **Config Sync** - Automatically sync your Neovim config to remote
- **Session Management** - Reconnect to previous sessions
- **Offline Mode** - Works in air-gapped environments

## Requirements

### Local Machine

- Neovim >= 0.9.0
- OpenSSH client (`ssh`, `scp`)
- `curl` (for downloading Neovim to remote)
- `tar` (optional, for compression)
- `devpod` >= 0.5.0 (optional, for devcontainers)

### Remote Machine

- OpenSSH-compliant SSH server
- `bash` shell
- `curl` or `wget`

## Installation Check

```vim
:checkhealth remote-nvim
```

## Keybindings (`<leader>R...`)

| Key | Action |
|-----|--------|
| `<leader>Rs` | Start remote connection |
| `<leader>Rx` | Stop remote connection |
| `<leader>Ri` | View session info |
| `<leader>Rc` | Cleanup remote resources |
| `<leader>Rd` | Delete saved host config |
| `<leader>Rl` | View plugin logs |

## Commands

| Command | Description |
|---------|-------------|
| `:RemoteStart` | Start connection wizard |
| `:RemoteStop` | Stop current remote server |
| `:RemoteInfo` | Show active session info |
| `:RemoteCleanup` | Remove Neovim from remote |
| `:RemoteConfigDel` | Delete saved host configuration |
| `:RemoteLog` | Open plugin log file |

## Usage Examples

### Connect to SSH Server

```vim
<leader>Rs              " Start remote connection
" Select: SSH
" Enter hostname: myserver.com
" Enter username: myuser
" Select authentication method
" Wait for Neovim to install on remote
" New window opens connected to remote
```

### Using SSH Config

If you have hosts defined in `~/.ssh/config`:

```
# ~/.ssh/config
Host devserver
    HostName 192.168.1.100
    User developer
    IdentityFile ~/.ssh/dev_key
```

```vim
<leader>Rs              " Start remote connection
" Your SSH config hosts will appear in the list
" Select 'devserver'
```

### Connect to Docker Container

```vim
<leader>Rs              " Start remote connection
" Select: Docker container
" Choose running container from list
" Or specify image to create new container
```

### Using Devcontainers

Requires [devpod](https://devpod.sh/) installed:

```bash
# Install devpod
curl -L -o devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64"
chmod +x devpod
sudo mv devpod /usr/local/bin/
```

```vim
<leader>Rs              " Start remote connection
" Select: Devcontainer
" Choose project with .devcontainer/devcontainer.json
```

### View Active Sessions

```vim
<leader>Ri              " Show session info
" Lists all active remote connections
" Shows connection details and status
```

### Cleanup Remote

```vim
<leader>Rc              " Cleanup remote
" Removes Neovim installation from remote
" Cleans up temporary files
" Use when done with a server
```

## Connection Types

### 1. SSH (Password)

```vim
:RemoteStart
" Select SSH
" Enter: user@hostname
" Enter password when prompted
```

### 2. SSH (Key-based)

```vim
:RemoteStart
" Select SSH
" Enter: user@hostname
" Key from ssh-agent or ssh_config used automatically
```

### 3. SSH Config Host

```vim
:RemoteStart
" Select from detected SSH config hosts
" Connection uses settings from ~/.ssh/config
```

### 4. Docker Container

```vim
:RemoteStart
" Select Docker
" Choose existing container or specify image
```

### 5. Devcontainer

```vim
:RemoteStart
" Select Devcontainer
" Choose workspace with devcontainer.json
```

## Configuration Syncing

The plugin syncs your local Neovim configuration to the remote:

### Clean Mode (Default)

Only copies essential config files:
- `init.lua`
- Plugin specifications

### Full Mode

Copies entire config directory:
- All lua files
- Plugin data
- Custom configurations

Configure in `lua/plugins/remote-nvim.lua`:

```lua
neovim_user_config = {
  config_copy = "clean", -- or "full"
}
```

## Offline Mode

For air-gapped environments without GitHub access:

1. Download Neovim release locally
2. Enable offline mode in config:

```lua
offline_mode = {
  enabled = true,
  no_github = true,
  cache_dir = vim.fn.stdpath("cache") .. "/remote-nvim",
}
```

3. Place Neovim tarball in cache directory
4. Connect as normal

## Troubleshooting

### Connection Fails

```vim
:RemoteLog              " Check logs for errors
:checkhealth remote-nvim
```

### SSH Authentication Issues

1. Test SSH manually: `ssh user@host`
2. Check SSH key is loaded: `ssh-add -l`
3. Verify ssh_config permissions: `chmod 600 ~/.ssh/config`

### Neovim Won't Install on Remote

1. Ensure remote has `curl` or `wget`
2. Check remote has internet access (or use offline mode)
3. Verify `bash` is available on remote

### Docker Connection Issues

1. Ensure Docker daemon is running
2. Check user is in docker group: `groups`
3. Test Docker: `docker ps`

### Config Not Syncing

1. Check compression is enabled
2. Verify remote has `tar` installed
3. Check for permission issues on remote

## Session Persistence

Remote sessions are saved and can be reconnected:

```vim
<leader>Rs              " Shows previous sessions
" Select existing session to reconnect
" Or start new connection
```

## Advanced Configuration

### Custom SSH Options

```lua
ssh_config = {
  ssh_binary = "ssh",
  scp_binary = "scp",
  ssh_config_file_paths = {
    "$HOME/.ssh/config",
    "$HOME/.ssh/config.d/*",
  },
  ssh_prompts = {
    {
      match = "password:",
      type = "secret",
      value_type = "static",
      value = "",
    },
    {
      match = "passphrase",
      type = "secret",
      value_type = "static",
      value = "",
    },
  },
}
```

### Custom Client Callback

```lua
client_callback = function(port, workspace_config)
  -- Custom behavior when remote is ready
  -- Default opens new Neovim connected to remote
  local cmd = ("nvim --server localhost:%s --remote-ui"):format(port)
  vim.fn.jobstart(cmd, { detach = true })
end
```

## Tips

### Use SSH Keys

Password authentication works but keys are more convenient:

```bash
ssh-keygen -t ed25519 -C "nvim-remote"
ssh-copy-id user@remote-host
```

### Add Hosts to SSH Config

```
# ~/.ssh/config
Host dev
    HostName 10.0.0.50
    User developer
    IdentityFile ~/.ssh/dev_key
    ForwardAgent yes
```

### Keep Sessions Alive

Add to `~/.ssh/config`:

```
Host *
    ServerAliveInterval 60
    ServerAliveCountMax 3
```

## See Also

- [remote-nvim.nvim GitHub](https://github.com/amitds1997/remote-nvim.nvim)
- [devpod](https://devpod.sh/) - Devcontainer management
- [SSH Config Documentation](https://man.openbsd.org/ssh_config)
