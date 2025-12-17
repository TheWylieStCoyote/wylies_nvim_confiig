-- Protocol Buffers (Protobuf) Development Configuration
-- LSP (buf-ls/pbls), linting (buf), and code generation

return {
  -- TreeSitter parsers for Protobuf
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "proto",
      })
    end,
  },

  -- Mason: ensure Protobuf tools are installed
  -- Note: Install manually with :MasonInstall buf protolint
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "buf",
        -- "buf-language-server", -- May not be available, use bufls
        "protolint",
      })
    end,
  },

  -- Buf language server configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bufls = {
          cmd = { "bufls", "serve" },
          filetypes = { "proto" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.root_pattern(
              "buf.yaml",
              "buf.gen.yaml",
              ".git"
            )(fname) or vim.fn.getcwd()
          end,
        },
        -- Alternative: pbls (Protocol Buffers Language Server)
        -- pbls = {
        --   cmd = { "pbls" },
        --   filetypes = { "proto" },
        -- },
      },
    },
  },

  -- Code formatting with buf
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        proto = { "buf" },
      },
      formatters = {
        buf = {
          command = "buf",
          args = { "format", "-w", "$FILENAME" },
          stdin = false,
        },
      },
    },
  },

  -- Linting with buf and protolint
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        proto = { "buf_lint", "protolint" },
      },
    },
  },

  -- Protobuf-specific keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "proto" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "Protobuf: " .. desc })
          end

          -- Buf commands
          map("<leader>pb", function()
            vim.cmd("split | terminal buf build")
          end, "Buf Build")

          map("<leader>pl", function()
            vim.cmd("split | terminal buf lint")
          end, "Buf Lint")

          map("<leader>pL", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal buf lint " .. file)
          end, "Buf Lint (file)")

          map("<leader>pf", function()
            vim.cmd("split | terminal buf format -w")
          end, "Buf Format")

          map("<leader>pF", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal buf format -w " .. file)
          end, "Buf Format (file)")

          -- Breaking change detection
          map("<leader>pB", function()
            vim.cmd("split | terminal buf breaking --against '.git#branch=main'")
          end, "Breaking Changes (vs main)")

          map("<leader>pBt", function()
            local tag = vim.fn.input("Compare against tag: ")
            if tag ~= "" then
              vim.cmd("split | terminal buf breaking --against '.git#tag=" .. tag .. "'")
            end
          end, "Breaking Changes (vs tag)")

          -- Code generation
          map("<leader>pg", function()
            vim.cmd("split | terminal buf generate")
          end, "Generate Code")

          map("<leader>pG", function()
            local template = vim.fn.input("Template: ", "buf.gen.yaml")
            vim.cmd("split | terminal buf generate --template " .. template)
          end, "Generate (template)")

          -- Protoc (if not using buf)
          map("<leader>ppc", function()
            local file = vim.fn.expand("%")
            local out = vim.fn.input("Output dir: ", "./gen")
            vim.cmd("split | terminal protoc --go_out=" .. out .. " --go-grpc_out=" .. out .. " " .. file)
          end, "Protoc (Go)")

          map("<leader>ppp", function()
            local file = vim.fn.expand("%")
            local out = vim.fn.input("Output dir: ", "./gen")
            vim.cmd("split | terminal protoc --python_out=" .. out .. " --grpc_python_out=" .. out .. " " .. file)
          end, "Protoc (Python)")

          map("<leader>ppj", function()
            local file = vim.fn.expand("%")
            local out = vim.fn.input("Output dir: ", "./gen")
            vim.cmd("split | terminal protoc --js_out=import_style=commonjs:" .. out .. " --grpc-web_out=import_style=commonjs,mode=grpcwebtext:" .. out .. " " .. file)
          end, "Protoc (JS)")

          map("<leader>ppr", function()
            local file = vim.fn.expand("%")
            local out = vim.fn.input("Output dir: ", "./gen")
            vim.cmd("split | terminal protoc --rust_out=" .. out .. " " .. file)
          end, "Protoc (Rust)")

          -- Protolint
          map("<leader>pll", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal protolint lint " .. file)
          end, "Protolint")

          map("<leader>plf", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal protolint lint --fix " .. file)
            vim.cmd("e!")
          end, "Protolint Fix")

          -- BSR (Buf Schema Registry)
          map("<leader>prp", function()
            vim.cmd("split | terminal buf push")
          end, "Push to BSR")

          map("<leader>prd", function()
            local module = vim.fn.input("Module: ")
            if module ~= "" then
              vim.cmd("split | terminal buf mod update " .. module)
            end
          end, "Update Dependency")

          -- Init/Config
          map("<leader>pi", function()
            vim.cmd("split | terminal buf mod init")
          end, "Init Module")

          map("<leader>pI", function()
            local template = [[
# buf.yaml
version: v1
name: buf.build/your-org/your-repo
deps: []
lint:
  use:
    - DEFAULT
  except:
    - PACKAGE_VERSION_SUFFIX
breaking:
  use:
    - FILE
]]
            local file = io.open("buf.yaml", "w")
            if file then
              file:write(template)
              file:close()
              vim.cmd("edit buf.yaml")
              vim.notify("Created buf.yaml", vim.log.levels.INFO)
            end
          end, "Create buf.yaml")

          map("<leader>pIG", function()
            local template = [[
# buf.gen.yaml
version: v1
managed:
  enabled: true
  go_package_prefix:
    default: github.com/your-org/your-repo/gen
plugins:
  # Go
  - plugin: buf.build/protocolbuffers/go
    out: gen/go
    opt: paths=source_relative
  - plugin: buf.build/grpc/go
    out: gen/go
    opt: paths=source_relative
  # Python
  # - plugin: buf.build/protocolbuffers/python
  #   out: gen/python
  # TypeScript
  # - plugin: buf.build/bufbuild/es
  #   out: gen/ts
]]
            local file = io.open("buf.gen.yaml", "w")
            if file then
              file:write(template)
              file:close()
              vim.cmd("edit buf.gen.yaml")
              vim.notify("Created buf.gen.yaml", vim.log.levels.INFO)
            end
          end, "Create buf.gen.yaml")

          -- Templates
          map("<leader>pn", function()
            local name = vim.fn.input("Service name: ")
            if name ~= "" then
              local template = string.format([[
syntax = "proto3";

package %s.v1;

option go_package = "github.com/your-org/your-repo/gen/%s/v1;%sv1";

// %sService provides ...
service %sService {
  // Get retrieves a %s by ID
  rpc Get%s(Get%sRequest) returns (Get%sResponse) {}

  // List retrieves all %ss
  rpc List%ss(List%ssRequest) returns (List%ssResponse) {}

  // Create creates a new %s
  rpc Create%s(Create%sRequest) returns (Create%sResponse) {}

  // Update updates an existing %s
  rpc Update%s(Update%sRequest) returns (Update%sResponse) {}

  // Delete removes a %s
  rpc Delete%s(Delete%sRequest) returns (Delete%sResponse) {}
}

// %s represents ...
message %s {
  string id = 1;
  string name = 2;
  // Add more fields
}

message Get%sRequest {
  string id = 1;
}

message Get%sResponse {
  %s %s = 1;
}

message List%ssRequest {
  int32 page_size = 1;
  string page_token = 2;
}

message List%ssResponse {
  repeated %s %ss = 1;
  string next_page_token = 2;
}

message Create%sRequest {
  %s %s = 1;
}

message Create%sResponse {
  %s %s = 1;
}

message Update%sRequest {
  %s %s = 1;
}

message Update%sResponse {
  %s %s = 1;
}

message Delete%sRequest {
  string id = 1;
}

message Delete%sResponse {}
]],
                name:lower(), name:lower(), name:lower(),
                name, name, name:lower(),
                name, name, name,
                name:lower(), name, name, name,
                name:lower(), name, name, name,
                name:lower(), name, name, name,
                name:lower(), name, name, name,
                name, name,
                name, name, name, name:lower(),
                name, name, name, name:lower(),
                name, name, name:lower(),
                name, name, name:lower(),
                name, name, name:lower(),
                name, name, name:lower(),
                name, name)

              local filename = name:lower() .. ".proto"
              local file = io.open(filename, "w")
              if file then
                file:write(template)
                file:close()
                vim.cmd("edit " .. filename)
                vim.notify("Created " .. filename, vim.log.levels.INFO)
              end
            end
          end, "New Service")

          -- Code actions
          map("<leader>pa", function()
            vim.lsp.buf.code_action()
          end, "Code Actions")

          map("<leader>ph", function()
            vim.lsp.buf.hover()
          end, "Hover Info")
        end,
      })
    end,
  },
}
