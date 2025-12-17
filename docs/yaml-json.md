# YAML/JSON/TOML Development

> LSP: yamlls, jsonls, taplo | Formatter: prettier | Linter: yamllint

## Quick Reference

| Component | Tool |
|-----------|------|
| YAML LSP | yaml-language-server |
| JSON LSP | json-lsp |
| TOML LSP | taplo |
| Formatter | prettier (YAML/JSON), taplo (TOML) |
| Linter | yamllint, jsonlint |
| TreeSitter | yaml, json, json5, jsonc, toml |

## Features

- Schema validation (SchemaStore)
- Auto-detect schemas for common files
- Docker Compose support
- Kubernetes manifests
- GitHub Actions
- CloudFormation
- jq/yq integration

## Keybindings

### YAML (`<leader>y...`)

| Key | Action |
|-----|--------|
| `<leader>yv` | Show Diagnostics |
| `<leader>yl` | Lint (yamllint) |
| `<leader>ys` | Set Schema |
| `<leader>yj` | Convert to JSON |
| `<leader>yt` | Convert to TOML |
| `<leader>yf` | Format |
| `<leader>yz` | Fold All |
| `<leader>yZ` | Unfold All |
| `<leader>ya` | Code Actions |
| `<leader>yh` | Hover Info |

### Docker Compose

| Key | Action |
|-----|--------|
| `<leader>ydc` | Config Validate |
| `<leader>ydu` | Compose Up |
| `<leader>ydd` | Compose Down |

### Kubernetes

| Key | Action |
|-----|--------|
| `<leader>yka` | kubectl Apply |
| `<leader>ykd` | kubectl Delete |
| `<leader>ykv` | kubectl Validate |

### JSON (`<leader>j...`)

| Key | Action |
|-----|--------|
| `<leader>jv` | Show Diagnostics |
| `<leader>jl` | Lint (jsonlint) |
| `<leader>jf` | Format (pretty) |
| `<leader>jm` | Minify |
| `<leader>jF` | Format (jq) |
| `<leader>jq` | jq Query |
| `<leader>jQ` | jq Query (preview) |
| `<leader>jy` | Convert to YAML |
| `<leader>jp` | List All Paths |
| `<leader>jk` | List Keys |
| `<leader>js` | Sort Keys |
| `<leader>ja` | Code Actions |
| `<leader>jh` | Hover Info |

### TOML (`<leader>t...`)

| Key | Action |
|-----|--------|
| `<leader>tf` | Format |
| `<leader>tF` | Format (taplo) |
| `<leader>tv` | Validate |
| `<leader>tj` | Convert to JSON |
| `<leader>ty` | Convert to YAML |
| `<leader>ta` | Code Actions |
| `<leader>th` | Hover Info |

## Installation

### Mason Packages
```vim
:MasonInstall yaml-language-server json-lsp prettier yamllint jsonlint taplo
```

### System Requirements

```bash
# Arch
sudo pacman -S yq jq

# npm tools
npm install -g prettier
```

## Schema Detection

Auto-detected schemas:
- `.github/workflows/*` → GitHub Workflow
- `docker-compose*.yml` → Docker Compose
- `/.gitlab-ci.yml` → GitLab CI
- `Chart.yml` → Helm Chart
- `kustomization.yml` → Kustomize
- And many more from SchemaStore

## Usage Examples

### Kubernetes
1. Write manifest
2. `<leader>ykv` - Validate dry-run
3. `<leader>yka` - Apply to cluster

### Docker Compose
1. Edit `docker-compose.yml`
2. `<leader>ydc` - Validate config
3. `<leader>ydu` - Start services

### JSON Processing
1. Open JSON file
2. `<leader>jq` - Run jq query
3. `<leader>jy` - Convert to YAML
