-- Java Development Configuration
-- LSP (jdtls via nvim-jdtls), debugging, and test runner

return {
  -- TreeSitter parsers for Java
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "java",
      })
    end,
  },

  -- Mason: ensure Java tools are installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "jdtls",
        "java-debug-adapter",
        "java-test",
        "google-java-format",
      })
    end,
  },

  -- nvim-jdtls: Specialized Java plugin (better than raw lspconfig)
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    opts = function()
      local mason_registry = require("mason-registry")

      -- Paths
      local jdtls_path = mason_registry.get_package("jdtls"):get_install_path()
      local java_debug_path = mason_registry.get_package("java-debug-adapter"):get_install_path()
      local java_test_path = mason_registry.get_package("java-test"):get_install_path()

      -- Find lombok jar if present
      local lombok_path = jdtls_path .. "/lombok.jar"

      -- Bundles for debugging and testing
      local bundles = {}

      -- Add java-debug-adapter
      local java_debug_bundle = vim.split(
        vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
        "\n"
      )
      if java_debug_bundle[1] ~= "" then
        vim.list_extend(bundles, java_debug_bundle)
      end

      -- Add java-test
      local java_test_bundle = vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", true), "\n")
      if java_test_bundle[1] ~= "" then
        vim.list_extend(bundles, java_test_bundle)
      end

      return {
        -- Command to start jdtls
        cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-Xmx1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
          "-javaagent:" .. lombok_path,
          "-jar",
          vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
          "-configuration",
          jdtls_path .. "/config_linux",
          "-data",
          vim.fn.stdpath("cache") .. "/jdtls/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
        },

        root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

        settings = {
          java = {
            eclipse = { downloadSources = true },
            configuration = { updateBuildConfiguration = "interactive" },
            maven = { downloadSources = true },
            implementationsCodeLens = { enabled = true },
            referencesCodeLens = { enabled = true },
            references = { includeDecompiledSources = true },
            inlayHints = {
              parameterNames = { enabled = "all" },
            },
            format = {
              enabled = true,
            },
            signatureHelp = { enabled = true },
            completion = {
              favoriteStaticMembers = {
                "org.junit.Assert.*",
                "org.junit.Assume.*",
                "org.junit.jupiter.api.Assertions.*",
                "org.junit.jupiter.api.Assumptions.*",
                "org.junit.jupiter.api.DynamicContainer.*",
                "org.junit.jupiter.api.DynamicTest.*",
                "org.mockito.Mockito.*",
                "org.mockito.ArgumentMatchers.*",
                "org.mockito.Answers.*",
              },
              importOrder = {
                "java",
                "javax",
                "com",
                "org",
              },
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
            codeGeneration = {
              toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
              },
              useBlocks = true,
            },
          },
        },

        init_options = {
          bundles = bundles,
        },
      }
    end,
    config = function(_, opts)
      -- Setup autocmd to start jdtls
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          require("jdtls").start_or_attach(opts)

          -- Setup DAP after jdtls attaches
          vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if client and client.name == "jdtls" then
                require("jdtls").setup_dap({ hotcodereplace = "auto" })
                require("jdtls.dap").setup_dap_main_class_configs()
              end
            end,
            once = true,
          })
        end,
      })

      -- Java-specific keybindings
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "Java: " .. desc })
          end
          local vmap = function(keys, func, desc)
            vim.keymap.set("v", keys, func, { buffer = event.buf, desc = "Java: " .. desc })
          end

          -- Code actions
          map("<leader>jo", function() require("jdtls").organize_imports() end, "Organize Imports")
          map("<leader>jv", function() require("jdtls").extract_variable() end, "Extract Variable")
          vmap("<leader>jv", function() require("jdtls").extract_variable(true) end, "Extract Variable")
          map("<leader>jc", function() require("jdtls").extract_constant() end, "Extract Constant")
          vmap("<leader>jc", function() require("jdtls").extract_constant(true) end, "Extract Constant")
          vmap("<leader>jm", function() require("jdtls").extract_method(true) end, "Extract Method")

          -- Test commands
          map("<leader>jt", function() require("jdtls").test_nearest_method() end, "Test Nearest Method")
          map("<leader>jT", function() require("jdtls").test_class() end, "Test Class")
          map("<leader>jd", function()
            require("jdtls").test_nearest_method({ config = { noDebug = false } })
          end, "Debug Nearest Test")
          map("<leader>jD", function()
            require("jdtls").test_class({ config = { noDebug = false } })
          end, "Debug Test Class")

          -- Project commands
          map("<leader>ju", function() require("jdtls").update_project_config() end, "Update Project Config")
          map("<leader>jb", function()
            require("jdtls").compile("full")
            vim.notify("Building project...", vim.log.levels.INFO)
          end, "Build Project")

          -- Run main class
          map("<leader>jr", function()
            require("jdtls.dap").setup_dap_main_class_configs()
            vim.cmd("DapContinue")
          end, "Run Main")

          -- Generate
          map("<leader>jg", function()
            vim.lsp.buf.code_action({
              context = { only = { "source.generate" } },
            })
          end, "Generate...")

          -- Debug keymaps
          map("<F5>", function() require("dap").continue() end, "Debug: Start/Continue")
          map("<F9>", function() require("dap").toggle_breakpoint() end, "Debug: Toggle Breakpoint")
          map("<F10>", function() require("dap").step_over() end, "Debug: Step Over")
          map("<F11>", function() require("dap").step_into() end, "Debug: Step Into")
          map("<S-F11>", function() require("dap").step_out() end, "Debug: Step Out")
        end,
      })
    end,
  },

  -- Code formatting with google-java-format (optional, jdtls can also format)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        java = { "google-java-format" },
      },
    },
  },
}
