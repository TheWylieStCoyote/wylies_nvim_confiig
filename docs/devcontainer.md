# Devcontainer - Container Development

> VSCode-like devcontainer support for Neovim

## Quick Reference

| Component | Tool |
|-----------|------|
| Plugin | esensar/nvim-dev-container |
| Runtime | Docker or Podman |
| Config | .devcontainer/devcontainer.json |

## Features

- **Container Management** - Start, attach, stop, remove containers
- **devcontainer.json Support** - Full compatibility with VSCode devcontainers
- **Docker Compose** - Support for multi-container setups
- **Config Mounting** - Mount local Neovim config into container
- **Neovim Installation** - Auto-installs Neovim in containers

## Requirements

- Neovim >= 0.12.0
- Docker or Podman
- nvim-treesitter with jsonc parser

### Install jsonc Parser

```vim
:TSInstall jsonc
```

## Keybindings (`<leader>D...`)

### Container Lifecycle

| Key | Action |
|-----|--------|
| `<leader>Ds` | Start container |
| `<leader>Da` | Attach to container |
| `<leader>De` | Execute command in container |
| `<leader>Dx` | Stop container |
| `<leader>DX` | Stop all containers |
| `<leader>DR` | Remove all containers |

### Docker Compose

| Key | Action |
|-----|--------|
| `<leader>Du` | Compose up |
| `<leader>Dd` | Compose down |
| `<leader>Dr` | Compose remove |

### Other

| Key | Action |
|-----|--------|
| `<leader>Dl` | View logs |
| `<leader>Dc` | Edit devcontainer.json |

## Commands

| Command | Description |
|---------|-------------|
| `:DevcontainerStart` | Start container from devcontainer.json |
| `:DevcontainerAttach` | Attach to running container |
| `:DevcontainerExec` | Run single command in container |
| `:DevcontainerStop` | Stop current container |
| `:DevcontainerStopAll` | Stop all project containers |
| `:DevcontainerRemoveAll` | Remove all project containers |
| `:DevcontainerLogs` | View container logs |
| `:DevcontainerEditNearestConfig` | Open/create devcontainer.json |
| `:DevcontainerComposeUp` | Start compose services |
| `:DevcontainerComposeDown` | Stop compose services |
| `:DevcontainerComposeRm` | Remove compose services |

## Usage Examples

### Basic Workflow

```vim
" 1. Open a project with .devcontainer/devcontainer.json
:cd ~/my-project

" 2. Start the container
<leader>Ds           " or :DevcontainerStart

" 3. Wait for container to build and start
" 4. Attach to the container
<leader>Da           " Opens terminal connected to container

" 5. Work inside container
" 6. When done, stop container
<leader>Dx           " or :DevcontainerStop
```

### Create New devcontainer.json

```vim
" In project root
<leader>Dc           " or :DevcontainerEditNearestConfig

" Creates .devcontainer/devcontainer.json with template
" Edit as needed
```

### Execute Single Command

```vim
<leader>De           " Prompts for command
" Enter: npm install
" Runs in container and returns
```

### Using Docker Compose

For multi-container projects:

```vim
" Start all services
<leader>Du           " or :DevcontainerComposeUp

" Stop services
<leader>Dd           " or :DevcontainerComposeDown

" Remove services and volumes
<leader>Dr           " or :DevcontainerComposeRm
```

## devcontainer.json Examples

### Basic Ubuntu Container

```json
{
  "name": "Ubuntu Dev",
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "customizations": {
    "vscode": {
      "extensions": []
    }
  }
}
```

### Node.js Development

```json
{
  "name": "Node.js",
  "image": "mcr.microsoft.com/devcontainers/javascript-node:20",
  "postCreateCommand": "npm install",
  "forwardPorts": [3000]
}
```

### Python Development

```json
{
  "name": "Python",
  "image": "mcr.microsoft.com/devcontainers/python:3.11",
  "postCreateCommand": "pip install -r requirements.txt",
  "forwardPorts": [8000]
}
```

### Rust Development

```json
{
  "name": "Rust",
  "image": "mcr.microsoft.com/devcontainers/rust:latest",
  "postCreateCommand": "cargo build"
}
```

### Docker Compose

```json
{
  "name": "Full Stack",
  "dockerComposeFile": "docker-compose.yml",
  "service": "app",
  "workspaceFolder": "/workspace"
}
```

## Configuration

### Using Podman Instead of Docker

Edit `lua/plugins/devcontainer.lua`:

```lua
container_runtime = "podman",
compose_command = "podman-compose",
```

### Mount SSH Keys

```lua
attach_mounts = {
  custom_mounts = {
    {
      type = "bind",
      source = vim.fn.expand("$HOME/.ssh"),
      target = "/home/vscode/.ssh",
      options = { "readonly" },
    },
  },
},
```

### Mount Git Config

```lua
attach_mounts = {
  custom_mounts = {
    {
      type = "bind",
      source = vim.fn.expand("$HOME/.gitconfig"),
      target = "/home/vscode/.gitconfig",
      options = { "readonly" },
    },
  },
},
```

### Auto-Start Containers

```lua
autocommands = {
  init = true,   -- Auto-start when opening devcontainer project
  clean = true,  -- Auto-cleanup on exit
  update = true, -- Auto-rebuild when config changes
},
```

### Custom Terminal Handler

```lua
terminal_handler = function(command)
  -- Use toggleterm instead of built-in terminal
  require("toggleterm").exec(command)
end,
```

## Project Structure

```
my-project/
├── .devcontainer/
│   ├── devcontainer.json    # Main config
│   ├── Dockerfile           # Optional custom image
│   └── docker-compose.yml   # Optional compose file
├── src/
└── ...
```

## Troubleshooting

### Container Won't Start

```vim
:DevcontainerLogs    " Check logs for errors
```

Common issues:
- Docker daemon not running
- Invalid devcontainer.json syntax
- Missing base image

### Neovim Config Not Available in Container

Ensure mounts are enabled:

```lua
attach_mounts = {
  neovim_config = { enabled = true },
  neovim_data = { enabled = true },
},
```

### Slow Container Builds

Enable image caching:

```lua
cache_images = true,
```

### Permission Issues

Try running as root:

```lua
nvim_installation = {
  prefer_root_user = true,
},
```

### jsonc Parser Not Found

```vim
:TSInstall jsonc
```

## Comparison with remote-nvim.nvim

| Feature | nvim-dev-container | remote-nvim.nvim |
|---------|-------------------|------------------|
| devcontainer.json | Native support | Via devpod |
| SSH connections | No | Yes |
| Docker support | Native | Via devpod |
| Config mounting | Built-in | Manual |
| Compose support | Native | Limited |

Use **nvim-dev-container** for:
- Projects with existing devcontainer.json
- Docker Compose workflows
- Local container development

Use **remote-nvim.nvim** for:
- SSH connections to remote servers
- Mixed SSH/Docker workflows
- devpod-based workflows

## Tips

### Keep Containers Small

Use multi-stage builds and minimal base images.

### Share Credentials

Mount credential helpers:

```json
{
  "mounts": [
    "source=${localEnv:HOME}/.aws,target=/home/vscode/.aws,type=bind"
  ]
}
```

### Port Forwarding

Ports in `forwardPorts` are automatically accessible on localhost.

### Rebuild Container

After changing Dockerfile:

```vim
:DevcontainerRemoveAll
:DevcontainerStart
```

## See Also

- [nvim-dev-container Repository](https://codeberg.org/esensar/nvim-dev-container)
- [Dev Containers Specification](https://containers.dev/)
- [Microsoft Dev Containers](https://github.com/devcontainers)
- [remote-nvim.nvim](remote-nvim.md) - Alternative for SSH/devpod
