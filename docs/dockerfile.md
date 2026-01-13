# Dockerfile Development

> LSP: dockerls | Linter: hadolint | Compose: docker-compose-language-service

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | dockerfile-language-server |
| Compose LSP | docker-compose-language-service |
| Linter | hadolint |
| TreeSitter | dockerfile |

## Features

- Docker language server
- Docker Compose language server
- Hadolint linting
- Image build/run commands
- Container management
- Registry operations
- Dockerfile templates

## Keybindings

### Build (`<leader>k...`)

| Key | Action |
|-----|--------|
| `<leader>kb` | Build Image |
| `<leader>kB` | Build (no cache) |
| `<leader>kf` | Build (this file) |

### Run

| Key | Action |
|-----|--------|
| `<leader>kr` | Run Container |
| `<leader>kR` | Run (with ports) |
| `<leader>ke` | Exec Shell |

### Images

| Key | Action |
|-----|--------|
| `<leader>ki` | List Images |
| `<leader>kI` | Inspect Image |
| `<leader>kh` | Image History |
| `<leader>kD` | Delete Image |

### Containers

| Key | Action |
|-----|--------|
| `<leader>kc` | List Containers |
| `<leader>kC` | Inspect Container |
| `<leader>kl` | Container Logs |
| `<leader>ks` | Stop Container |
| `<leader>kS` | Start Container |
| `<leader>kx` | Remove Container |
| `<leader>kt` | Container Stats |

### Registry

| Key | Action |
|-----|--------|
| `<leader>kpp` | Push Image |
| `<leader>kpl` | Pull Image |
| `<leader>klo` | Docker Login |

### Cleanup

| Key | Action |
|-----|--------|
| `<leader>kp` | Prune System |
| `<leader>kP` | Prune All |

### Network & Volumes

| Key | Action |
|-----|--------|
| `<leader>kn` | List Networks |
| `<leader>kv` | List Volumes |

### Other

| Key | Action |
|-----|--------|
| `<leader>kL` | Lint (hadolint) |
| `<leader>kN` | Insert Template |
| `<leader>ka` | Code Actions |
| `<leader>kH` | Hover Info |

### Docker Compose (`<leader>D...`)

| Key | Action |
|-----|--------|
| `<leader>Du` | Up (detached) |
| `<leader>DU` | Up (attached) |
| `<leader>Dd` | Down |
| `<leader>DD` | Down (remove all) |
| `<leader>Dr` | Restart |
| `<leader>Dl` | Logs |
| `<leader>Dp` | PS |
| `<leader>Db` | Build |
| `<leader>Dc` | Validate Config |
| `<leader>De` | Exec Shell |
| `<leader>Ds` | Scale Service |

## Installation

### Mason Packages
```vim
:MasonInstall dockerfile-language-server hadolint docker-compose-language-service
```

### System Requirements

```bash
# Arch
sudo pacman -S docker docker-compose

# Enable docker service
sudo systemctl enable --now docker

# Add user to docker group
sudo usermod -aG docker $USER
```

## Configuration

### dockerls Settings

- Formatter: ignoreMultilineInstructions
- Auto root detection

### .hadolint.yaml

```yaml
ignored:
  - DL3008  # Pin versions in apt-get
  - DL3013  # Pin versions in pip

trustedRegistries:
  - docker.io
  - gcr.io

override:
  error:
    - DL3001  # Command does not make sense in container
```

## Dockerfile Template

Generated with `<leader>kN`:
```dockerfile
# syntax=docker/dockerfile:1

FROM alpine:latest

# Labels
LABEL maintainer="your@email.com"
LABEL version="1.0"

# Environment variables
ENV APP_HOME=/app

# Create app directory
WORKDIR $APP_HOME

# Install dependencies
RUN apk add --no-cache \
    && rm -rf /var/cache/apk/*

# Copy application files
COPY . .

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
    CMD wget --quiet --tries=1 --spider http://localhost:8080/ || exit 1

# Run as non-root user
RUN adduser -D appuser
USER appuser

# Start application
CMD ["./app"]
```

## Usage Examples

### Build & Run
1. Write Dockerfile
2. `<leader>kL` - Lint with hadolint
3. `<leader>kb` - Build image
4. `<leader>kr` - Run container

### Docker Compose
1. Edit `docker-compose.yml`
2. `<leader>Dc` - Validate config
3. `<leader>Du` - Start services
4. `<leader>Dl` - View logs

### Debug Container
1. `<leader>kc` - List containers
2. `<leader>ke` - Exec shell
3. `<leader>kl` - View logs
