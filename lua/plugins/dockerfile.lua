-- Dockerfile Development Configuration
-- LSP (dockerls), linting (hadolint), and Docker integration

return {
  -- TreeSitter parsers for Docker
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "dockerfile",
      })
    end,
  },

  -- Mason: ensure Docker tools are installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "dockerfile-language-server",
        "hadolint",
        "docker-compose-language-service",
      })
    end,
  },

  -- Docker language server configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        dockerls = {
          cmd = { "docker-langserver", "--stdio" },
          filetypes = { "dockerfile" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.root_pattern(
              "Dockerfile",
              "dockerfile",
              ".git"
            )(fname) or vim.fn.getcwd()
          end,
          settings = {
            docker = {
              languageserver = {
                formatter = {
                  ignoreMultilineInstructions = true,
                },
              },
            },
          },
        },
        -- Docker Compose language server
        docker_compose_language_service = {
          cmd = { "docker-compose-langserver", "--stdio" },
          filetypes = { "yaml.docker-compose" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.root_pattern(
              "docker-compose.yml",
              "docker-compose.yaml",
              "compose.yml",
              "compose.yaml",
              ".git"
            )(fname) or vim.fn.getcwd()
          end,
        },
      },
    },
  },

  -- Linting with hadolint
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        dockerfile = { "hadolint" },
      },
    },
  },

  -- Dockerfile-specific keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "dockerfile" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "Docker: " .. desc })
          end

          -- Build
          map("<leader>kb", function()
            local tag = vim.fn.input("Image tag: ", vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. ":latest")
            if tag ~= "" then
              vim.cmd("split | terminal docker build -t " .. tag .. " .")
            end
          end, "Build Image")

          map("<leader>kB", function()
            local tag = vim.fn.input("Image tag: ", vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. ":latest")
            if tag ~= "" then
              vim.cmd("split | terminal docker build --no-cache -t " .. tag .. " .")
            end
          end, "Build (no cache)")

          map("<leader>kf", function()
            local file = vim.fn.expand("%")
            local tag = vim.fn.input("Image tag: ", vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. ":latest")
            if tag ~= "" then
              vim.cmd("split | terminal docker build -f " .. file .. " -t " .. tag .. " .")
            end
          end, "Build (this file)")

          -- Run
          map("<leader>kr", function()
            local image = vim.fn.input("Image: ", vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. ":latest")
            if image ~= "" then
              vim.cmd("split | terminal docker run --rm -it " .. image)
            end
          end, "Run Container")

          map("<leader>kR", function()
            local image = vim.fn.input("Image: ", vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. ":latest")
            local ports = vim.fn.input("Ports (e.g., 8080:80): ")
            if image ~= "" then
              local cmd = "docker run --rm -it"
              if ports ~= "" then
                cmd = cmd .. " -p " .. ports
              end
              vim.cmd("split | terminal " .. cmd .. " " .. image)
            end
          end, "Run (with ports)")

          map("<leader>ke", function()
            local container = vim.fn.input("Container: ")
            if container ~= "" then
              vim.cmd("split | terminal docker exec -it " .. container .. " /bin/sh")
            end
          end, "Exec Shell")

          -- Images
          map("<leader>ki", function()
            vim.cmd("split | terminal docker images")
          end, "List Images")

          map("<leader>kI", function()
            local image = vim.fn.input("Image to inspect: ")
            if image ~= "" then
              vim.cmd("split | terminal docker inspect " .. image)
            end
          end, "Inspect Image")

          map("<leader>kh", function()
            local image = vim.fn.input("Image: ")
            if image ~= "" then
              vim.cmd("split | terminal docker history " .. image)
            end
          end, "Image History")

          map("<leader>kD", function()
            local image = vim.fn.input("Image to delete: ")
            if image ~= "" then
              vim.cmd("split | terminal docker rmi " .. image)
            end
          end, "Delete Image")

          -- Containers
          map("<leader>kc", function()
            vim.cmd("split | terminal docker ps -a")
          end, "List Containers")

          map("<leader>kC", function()
            local container = vim.fn.input("Container to inspect: ")
            if container ~= "" then
              vim.cmd("split | terminal docker inspect " .. container)
            end
          end, "Inspect Container")

          map("<leader>kl", function()
            local container = vim.fn.input("Container: ")
            if container ~= "" then
              vim.cmd("split | terminal docker logs -f " .. container)
            end
          end, "Container Logs")

          map("<leader>ks", function()
            local container = vim.fn.input("Container to stop: ")
            if container ~= "" then
              vim.cmd("split | terminal docker stop " .. container)
            end
          end, "Stop Container")

          map("<leader>kS", function()
            local container = vim.fn.input("Container to start: ")
            if container ~= "" then
              vim.cmd("split | terminal docker start " .. container)
            end
          end, "Start Container")

          map("<leader>kx", function()
            local container = vim.fn.input("Container to remove: ")
            if container ~= "" then
              vim.cmd("split | terminal docker rm " .. container)
            end
          end, "Remove Container")

          -- Cleanup
          map("<leader>kp", function()
            vim.cmd("split | terminal docker system prune")
          end, "Prune System")

          map("<leader>kP", function()
            vim.cmd("split | terminal docker system prune -a --volumes")
          end, "Prune All")

          -- Registry
          map("<leader>kpp", function()
            local image = vim.fn.input("Image to push: ")
            if image ~= "" then
              vim.cmd("split | terminal docker push " .. image)
            end
          end, "Push Image")

          map("<leader>kpl", function()
            local image = vim.fn.input("Image to pull: ")
            if image ~= "" then
              vim.cmd("split | terminal docker pull " .. image)
            end
          end, "Pull Image")

          map("<leader>klo", function()
            vim.cmd("split | terminal docker login")
          end, "Docker Login")

          -- Linting
          map("<leader>kL", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal hadolint " .. file)
          end, "Lint (hadolint)")

          -- Stats
          map("<leader>kt", function()
            vim.cmd("split | terminal docker stats")
          end, "Container Stats")

          -- Network
          map("<leader>kn", function()
            vim.cmd("split | terminal docker network ls")
          end, "List Networks")

          -- Volumes
          map("<leader>kv", function()
            vim.cmd("split | terminal docker volume ls")
          end, "List Volumes")

          -- Code actions
          map("<leader>ka", function()
            vim.lsp.buf.code_action()
          end, "Code Actions")

          map("<leader>kH", function()
            vim.lsp.buf.hover()
          end, "Hover Info")

          -- Templates
          map("<leader>kN", function()
            local base = vim.fn.input("Base image: ", "alpine:latest")
            local template = string.format([[
# syntax=docker/dockerfile:1

FROM %s

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
]], base)

            local lines = vim.split(template, "\n")
            vim.api.nvim_buf_set_lines(event.buf, 0, -1, false, lines)
            vim.notify("Inserted Dockerfile template", vim.log.levels.INFO)
          end, "Insert Template")
        end,
      })

      -- Docker Compose keybindings
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { "docker-compose*.yml", "docker-compose*.yaml", "compose*.yml", "compose*.yaml" },
        callback = function(event)
          vim.bo[event.buf].filetype = "yaml.docker-compose"

          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "Compose: " .. desc })
          end

          map("<leader>Du", function()
            vim.cmd("split | terminal docker-compose up -d")
          end, "Up (detached)")

          map("<leader>DU", function()
            vim.cmd("split | terminal docker-compose up")
          end, "Up (attached)")

          map("<leader>Dd", function()
            vim.cmd("split | terminal docker-compose down")
          end, "Down")

          map("<leader>DD", function()
            vim.cmd("split | terminal docker-compose down -v --rmi all")
          end, "Down (remove all)")

          map("<leader>Dr", function()
            vim.cmd("split | terminal docker-compose restart")
          end, "Restart")

          map("<leader>Dl", function()
            vim.cmd("split | terminal docker-compose logs -f")
          end, "Logs")

          map("<leader>Dp", function()
            vim.cmd("split | terminal docker-compose ps")
          end, "PS")

          map("<leader>Db", function()
            vim.cmd("split | terminal docker-compose build")
          end, "Build")

          map("<leader>Dc", function()
            vim.cmd("split | terminal docker-compose config")
          end, "Validate Config")

          map("<leader>De", function()
            local service = vim.fn.input("Service: ")
            if service ~= "" then
              vim.cmd("split | terminal docker-compose exec " .. service .. " /bin/sh")
            end
          end, "Exec Shell")

          map("<leader>Ds", function()
            local service = vim.fn.input("Service to scale: ")
            local num = vim.fn.input("Replicas: ")
            if service ~= "" and num ~= "" then
              vim.cmd("split | terminal docker-compose up -d --scale " .. service .. "=" .. num)
            end
          end, "Scale Service")
        end,
      })
    end,
  },
}
