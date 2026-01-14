-- Kotlin Development Configuration
-- LSP (kotlin-language-server), debugging, and Gradle/Android support

-- Skip entire Kotlin config if Kotlin is not installed
if vim.fn.executable("kotlin") ~= 1 and vim.fn.executable("kotlinc") ~= 1 then
  return {}
end

return {
  -- TreeSitter parsers for Kotlin
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "kotlin",
      })
    end,
  },

  -- Mason: ensure Kotlin tools are installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "kotlin-language-server",
        "ktlint",
        "kotlin-debug-adapter",
      })
    end,
  },

  -- kotlin-language-server configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        kotlin_language_server = {
          filetypes = { "kotlin" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.root_pattern(
              "settings.gradle",
              "settings.gradle.kts",
              "build.gradle",
              "build.gradle.kts",
              "pom.xml",
              ".git"
            )(fname)
          end,
          settings = {
            kotlin = {
              compiler = {
                jvm = {
                  target = "17",
                },
              },
              hints = {
                typeHints = true,
                parameterHints = true,
                chaineHints = true,
              },
              completion = {
                snippets = {
                  enabled = true,
                },
              },
              linting = {
                debounceTime = 250,
              },
              indexing = {
                enabled = true,
              },
              externalSources = {
                useKlsScheme = true,
                autoConvertToKotlin = true,
              },
            },
          },
        },
      },
    },
  },

  -- Code formatting with ktlint
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        kotlin = { "ktlint" },
      },
      formatters = {
        ktlint = {
          command = "ktlint",
          args = { "--stdin", "--format" },
          stdin = true,
        },
      },
    },
  },

  -- Linting with ktlint
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        kotlin = { "ktlint" },
      },
    },
  },

  -- Kotlin debugging
  {
    "mfussenegger/nvim-dap",
    optional = true,
    ft = { "kotlin" },
    opts = function()
      local dap = require("dap")

      dap.adapters.kotlin = {
        type = "executable",
        command = "kotlin-debug-adapter",
        options = {
          auto_continue_if_many_stopped = false,
        },
      }

      dap.configurations.kotlin = {
        {
          type = "kotlin",
          request = "launch",
          name = "Launch Kotlin Program",
          projectRoot = "${workspaceFolder}",
          mainClass = function()
            return vim.fn.input("Main class: ", "MainKt")
          end,
        },
        {
          type = "kotlin",
          request = "attach",
          name = "Attach to Process",
          hostName = "localhost",
          port = 5005,
          timeout = 10000,
        },
      }
    end,
  },

  -- Kotlin-specific keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "kotlin" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "Kotlin: " .. desc })
          end

          -- Run Kotlin
          map("<leader>kr", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal kotlinc -script " .. file)
          end, "Run Script")

          map("<leader>kR", function()
            local file = vim.fn.expand("%")
            local out = vim.fn.expand("%:r")
            vim.cmd("split | terminal kotlinc " .. file .. " -include-runtime -d " .. out .. ".jar && java -jar " .. out .. ".jar")
          end, "Compile & Run")

          map("<leader>ki", function()
            vim.cmd("split | terminal kotlinc")
          end, "Kotlin REPL")

          -- Gradle commands
          map("<leader>kb", function()
            vim.cmd("split | terminal ./gradlew build")
          end, "Gradle Build")

          map("<leader>kB", function()
            vim.cmd("split | terminal ./gradlew build --refresh-dependencies")
          end, "Gradle Build (refresh)")

          map("<leader>kc", function()
            vim.cmd("split | terminal ./gradlew clean")
          end, "Gradle Clean")

          map("<leader>kt", function()
            vim.cmd("split | terminal ./gradlew test")
          end, "Gradle Test")

          map("<leader>kT", function()
            local test = vim.fn.input("Test filter: ")
            if test ~= "" then
              vim.cmd("split | terminal ./gradlew test --tests '" .. test .. "'")
            end
          end, "Gradle Test (filtered)")

          map("<leader>kx", function()
            vim.cmd("split | terminal ./gradlew run")
          end, "Gradle Run")

          map("<leader>kd", function()
            vim.cmd("split | terminal ./gradlew dependencies")
          end, "Gradle Dependencies")

          map("<leader>kD", function()
            vim.cmd("split | terminal ./gradlew tasks")
          end, "Gradle Tasks")

          -- Android (if applicable)
          map("<leader>kaa", function()
            vim.cmd("split | terminal ./gradlew assembleDebug")
          end, "Android Assemble Debug")

          map("<leader>kar", function()
            vim.cmd("split | terminal ./gradlew assembleRelease")
          end, "Android Assemble Release")

          map("<leader>kai", function()
            vim.cmd("split | terminal ./gradlew installDebug")
          end, "Android Install Debug")

          map("<leader>kat", function()
            vim.cmd("split | terminal ./gradlew connectedAndroidTest")
          end, "Android Connected Tests")

          -- Maven (alternative)
          map("<leader>kmb", function()
            vim.cmd("split | terminal mvn compile")
          end, "Maven Compile")

          map("<leader>kmt", function()
            vim.cmd("split | terminal mvn test")
          end, "Maven Test")

          map("<leader>kmx", function()
            vim.cmd("split | terminal mvn exec:java")
          end, "Maven Exec")

          -- Formatting
          map("<leader>kf", function()
            vim.cmd("split | terminal ktlint --format " .. vim.fn.expand("%"))
            vim.cmd("e!")
          end, "Format (ktlint)")

          map("<leader>kF", function()
            vim.cmd("split | terminal ktlint --format '**/*.kt'")
          end, "Format All")

          -- Code actions
          map("<leader>ka", function()
            vim.lsp.buf.code_action()
          end, "Code Actions")

          map("<leader>kh", function()
            vim.lsp.buf.hover()
          end, "Hover Info")

          -- New project
          map("<leader>kn", function()
            local name = vim.fn.input("Project name: ")
            if name ~= "" then
              vim.cmd("split | terminal gradle init --type kotlin-application --dsl kotlin --project-name " .. name)
            end
          end, "New Gradle Project")
        end,
      })
    end,
  },
}
