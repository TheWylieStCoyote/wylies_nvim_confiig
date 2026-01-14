-- Terraform/HCL Development Configuration
-- LSP (terraform-ls), formatting, and infrastructure management

-- Skip entire Terraform config if Terraform is not installed
if vim.fn.executable("terraform") ~= 1 then
  return {}
end

return {
  -- TreeSitter parsers for Terraform/HCL
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "terraform",
        "hcl",
      })
    end,
  },

  -- Mason: ensure Terraform tools are installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "terraform-ls",
        "tflint",
        "tfsec",
      })
    end,
  },

  -- terraform-ls configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        terraformls = {
          cmd = { "terraform-ls", "serve" },
          filetypes = { "terraform", "terraform-vars", "tf" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.root_pattern(
              ".terraform",
              ".git",
              "*.tf"
            )(fname) or vim.fn.getcwd()
          end,
          settings = {
            terraform = {
              experimentalFeatures = {
                validateOnSave = true,
                prefillRequiredFields = true,
              },
            },
          },
        },
        -- Also configure tflint as LSP
        tflint = {
          cmd = { "tflint", "--langserver" },
          filetypes = { "terraform", "tf" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.root_pattern(
              ".tflint.hcl",
              ".terraform",
              ".git"
            )(fname) or vim.fn.getcwd()
          end,
        },
      },
    },
  },

  -- Code formatting with terraform fmt
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        terraform = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        hcl = { "packer_fmt" },
      },
      formatters = {
        terraform_fmt = {
          command = "terraform",
          args = { "fmt", "-" },
          stdin = true,
        },
        packer_fmt = {
          command = "packer",
          args = { "fmt", "-" },
          stdin = true,
        },
      },
    },
  },

  -- Linting with tflint
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        terraform = { "tflint", "tfsec" },
        tf = { "tflint", "tfsec" },
      },
    },
  },

  -- Terraform-specific keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "terraform", "tf", "terraform-vars", "hcl" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "Terraform: " .. desc })
          end

          -- Core Terraform commands
          map("<leader>Ti", function()
            vim.cmd("split | terminal terraform init")
          end, "Init")

          map("<leader>TI", function()
            vim.cmd("split | terminal terraform init -upgrade")
          end, "Init (upgrade)")

          map("<leader>Tv", function()
            vim.cmd("split | terminal terraform validate")
          end, "Validate")

          map("<leader>Tp", function()
            vim.cmd("split | terminal terraform plan")
          end, "Plan")

          map("<leader>TP", function()
            local out = vim.fn.input("Plan output file: ", "tfplan")
            vim.cmd("split | terminal terraform plan -out=" .. out)
          end, "Plan (save)")

          map("<leader>Ta", function()
            vim.cmd("split | terminal terraform apply")
          end, "Apply")

          map("<leader>TA", function()
            vim.cmd("split | terminal terraform apply -auto-approve")
          end, "Apply (auto-approve)")

          map("<leader>TAp", function()
            local plan = vim.fn.input("Plan file: ", "tfplan")
            vim.cmd("split | terminal terraform apply " .. plan)
          end, "Apply Plan File")

          map("<leader>Td", function()
            vim.cmd("split | terminal terraform destroy")
          end, "Destroy")

          map("<leader>TD", function()
            vim.cmd("split | terminal terraform destroy -auto-approve")
          end, "Destroy (auto-approve)")

          -- State management
          map("<leader>Tsl", function()
            vim.cmd("split | terminal terraform state list")
          end, "State List")

          map("<leader>Tss", function()
            local resource = vim.fn.input("Resource: ")
            if resource ~= "" then
              vim.cmd("split | terminal terraform state show " .. resource)
            end
          end, "State Show")

          map("<leader>Tsm", function()
            local src = vim.fn.input("Source: ")
            local dst = vim.fn.input("Destination: ")
            if src ~= "" and dst ~= "" then
              vim.cmd("split | terminal terraform state mv " .. src .. " " .. dst)
            end
          end, "State Move")

          map("<leader>Tsr", function()
            local resource = vim.fn.input("Resource to remove: ")
            if resource ~= "" then
              vim.cmd("split | terminal terraform state rm " .. resource)
            end
          end, "State Remove")

          map("<leader>Tsp", function()
            vim.cmd("split | terminal terraform state pull")
          end, "State Pull")

          -- Workspace management
          map("<leader>Twl", function()
            vim.cmd("split | terminal terraform workspace list")
          end, "Workspace List")

          map("<leader>Tws", function()
            local ws = vim.fn.input("Workspace: ")
            if ws ~= "" then
              vim.cmd("split | terminal terraform workspace select " .. ws)
            end
          end, "Workspace Select")

          map("<leader>Twn", function()
            local ws = vim.fn.input("New workspace: ")
            if ws ~= "" then
              vim.cmd("split | terminal terraform workspace new " .. ws)
            end
          end, "Workspace New")

          map("<leader>Twd", function()
            local ws = vim.fn.input("Delete workspace: ")
            if ws ~= "" then
              vim.cmd("split | terminal terraform workspace delete " .. ws)
            end
          end, "Workspace Delete")

          -- Output and info
          map("<leader>To", function()
            vim.cmd("split | terminal terraform output")
          end, "Output")

          map("<leader>TO", function()
            vim.cmd("split | terminal terraform output -json")
          end, "Output (JSON)")

          map("<leader>Tg", function()
            vim.cmd("split | terminal terraform graph | dot -Tsvg > graph.svg && echo 'Generated graph.svg'")
          end, "Generate Graph")

          map("<leader>Tr", function()
            vim.cmd("split | terminal terraform providers")
          end, "List Providers")

          -- Formatting
          map("<leader>Tf", function()
            vim.cmd("split | terminal terraform fmt")
          end, "Format Directory")

          map("<leader>TF", function()
            vim.cmd("split | terminal terraform fmt -recursive")
          end, "Format Recursive")

          -- Security scanning
          map("<leader>Ts", function()
            vim.cmd("split | terminal tfsec .")
          end, "Security Scan (tfsec)")

          map("<leader>TS", function()
            vim.cmd("split | terminal tfsec . --format json")
          end, "Security Scan (JSON)")

          -- Linting
          map("<leader>Tl", function()
            vim.cmd("split | terminal tflint")
          end, "Lint (tflint)")

          map("<leader>TL", function()
            vim.cmd("split | terminal tflint --init")
          end, "TFLint Init")

          -- Cost estimation (infracost)
          map("<leader>Tc", function()
            vim.cmd("split | terminal infracost breakdown --path .")
          end, "Cost Estimate")

          -- Generate config files
          map("<leader>Tn", function()
            local template = [[
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
]]
            local file = io.open("main.tf", "w")
            if file then
              file:write(template)
              file:close()
              vim.cmd("edit main.tf")
              vim.notify("Created main.tf", vim.log.levels.INFO)
            end
          end, "New main.tf")

          map("<leader>TN", function()
            local template = [[
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
}
]]
            local file = io.open("variables.tf", "w")
            if file then
              file:write(template)
              file:close()
              vim.cmd("edit variables.tf")
              vim.notify("Created variables.tf", vim.log.levels.INFO)
            end
          end, "New variables.tf")

          -- Code actions
          map("<leader>Th", function()
            vim.lsp.buf.hover()
          end, "Hover Info")

          map("<leader>Taa", function()
            vim.lsp.buf.code_action()
          end, "Code Actions")

          -- Import resource
          map("<leader>Tim", function()
            local addr = vim.fn.input("Resource address: ")
            local id = vim.fn.input("Resource ID: ")
            if addr ~= "" and id ~= "" then
              vim.cmd("split | terminal terraform import " .. addr .. " " .. id)
            end
          end, "Import Resource")

          -- Refresh
          map("<leader>TR", function()
            vim.cmd("split | terminal terraform refresh")
          end, "Refresh State")
        end,
      })
    end,
  },
}
