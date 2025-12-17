# Terraform/HCL Development

> LSP: terraform-ls, tflint | Formatter: terraform fmt | Linter: tflint, tfsec

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | terraform-ls |
| Linter LSP | tflint (langserver mode) |
| Formatter | terraform fmt |
| Linter | tflint, tfsec |
| TreeSitter | terraform, hcl |

## Features

- terraform-ls language server
- tflint integration
- tfsec security scanning
- Workspace management
- State management
- Infracost integration
- HCL/Packer support

## Keybindings

### Core Commands (`<leader>T...`)

| Key | Action |
|-----|--------|
| `<leader>Ti` | Init |
| `<leader>TI` | Init (upgrade) |
| `<leader>Tv` | Validate |
| `<leader>Tp` | Plan |
| `<leader>TP` | Plan (save to file) |
| `<leader>Ta` | Apply |
| `<leader>TA` | Apply (auto-approve) |
| `<leader>TAp` | Apply Plan File |
| `<leader>Td` | Destroy |
| `<leader>TD` | Destroy (auto-approve) |

### State Management

| Key | Action |
|-----|--------|
| `<leader>Tsl` | State List |
| `<leader>Tss` | State Show |
| `<leader>Tsm` | State Move |
| `<leader>Tsr` | State Remove |
| `<leader>Tsp` | State Pull |

### Workspace Management

| Key | Action |
|-----|--------|
| `<leader>Twl` | Workspace List |
| `<leader>Tws` | Workspace Select |
| `<leader>Twn` | Workspace New |
| `<leader>Twd` | Workspace Delete |

### Output & Info

| Key | Action |
|-----|--------|
| `<leader>To` | Output |
| `<leader>TO` | Output (JSON) |
| `<leader>Tg` | Generate Graph |
| `<leader>Tr` | List Providers |

### Formatting & Linting

| Key | Action |
|-----|--------|
| `<leader>Tf` | Format Directory |
| `<leader>TF` | Format Recursive |
| `<leader>Tl` | Lint (tflint) |
| `<leader>TL` | TFLint Init |

### Security

| Key | Action |
|-----|--------|
| `<leader>Ts` | Security Scan (tfsec) |
| `<leader>TS` | Security Scan (JSON) |
| `<leader>Tc` | Cost Estimate (infracost) |

### Templates

| Key | Action |
|-----|--------|
| `<leader>Tn` | New main.tf |
| `<leader>TN` | New variables.tf |

### Other

| Key | Action |
|-----|--------|
| `<leader>Tim` | Import Resource |
| `<leader>TR` | Refresh State |
| `<leader>Th` | Hover Info |
| `<leader>Taa` | Code Actions |

## Installation

### Mason Packages
```vim
:MasonInstall terraform-ls tflint tfsec
```

### System Requirements

```bash
# Arch
sudo pacman -S terraform

# Optional: infracost
yay -S infracost

# Optional: graphviz for graph generation
sudo pacman -S graphviz
```

## Configuration

### .tflint.hcl

```hcl
plugin "aws" {
  enabled = true
  version = "0.27.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

rule "terraform_naming_convention" {
  enabled = true
}
```

### terraform-ls Settings

- Experimental features enabled
- Validate on save
- Prefill required fields

## main.tf Template

Generated with `<leader>Tn`:
```hcl
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state"
    key    = "state.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}
```

## Usage Examples

### Infrastructure Workflow
1. `<leader>Ti` - Initialize
2. `<leader>Tv` - Validate
3. `<leader>Tp` - Plan
4. `<leader>Ta` - Apply

### Security Check
1. `<leader>Tl` - Lint with tflint
2. `<leader>Ts` - Security scan with tfsec
3. `<leader>Tc` - Cost estimate

### State Operations
1. `<leader>Tsl` - List resources
2. `<leader>Tss` - Show specific resource
3. `<leader>Tim` - Import existing resource
