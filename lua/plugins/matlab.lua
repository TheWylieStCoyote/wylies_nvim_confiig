-- MATLAB/Octave Development Configuration
-- LSP (matlab-language-server), and Octave support

return {
  -- TreeSitter parsers for MATLAB
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "matlab",
      })
    end,
  },

  -- Mason: ensure MATLAB tools are installed (if available)
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        -- matlab-language-server requires MATLAB installation
        -- "matlab-language-server",
      })
    end,
  },

  -- MATLAB language server configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        matlab_ls = {
          cmd = { "matlab-language-server", "--stdio" },
          filetypes = { "matlab" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.root_pattern(
              "*.m",
              ".git"
            )(fname) or vim.fn.getcwd()
          end,
          settings = {
            matlab = {
              indexWorkspace = true,
              installPath = "", -- Set your MATLAB installation path
              matlabConnectionTiming = "onStart",
              telemetry = false,
            },
          },
          single_file_support = true,
        },
      },
    },
  },

  -- Code formatting (basic indentation)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        matlab = { "matlab_formatter" },
        octave = { "matlab_formatter" },
      },
      formatters = {
        matlab_formatter = {
          command = "matlab",
          args = {
            "-batch",
            "text = fileread('$FILENAME'); formatted = indentcode(text); fid = fopen('$FILENAME', 'w'); fprintf(fid, '%s', formatted); fclose(fid);",
          },
          stdin = false,
        },
      },
    },
  },

  -- MATLAB/Octave-specific keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "matlab", "octave" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "MATLAB: " .. desc })
          end
          local vmap = function(keys, func, desc)
            vim.keymap.set("v", keys, func, { buffer = event.buf, desc = "MATLAB: " .. desc })
          end

          -- Detect if using MATLAB or Octave
          local use_octave = vim.fn.executable("octave") == 1 and vim.fn.executable("matlab") == 0

          -- Run scripts
          if use_octave then
            -- Octave commands
            map("<leader>mr", function()
              local file = vim.fn.expand("%")
              vim.cmd("split | terminal octave --no-gui " .. file)
            end, "Run File (Octave)")

            map("<leader>mi", function()
              vim.cmd("split | terminal octave --no-gui")
            end, "Octave CLI")

            map("<leader>mI", function()
              vim.cmd("split | terminal octave --gui")
            end, "Octave GUI")

            map("<leader>ml", function()
              local line = vim.api.nvim_get_current_line()
              vim.cmd("split | terminal octave --no-gui --eval \"" .. line:gsub('"', '\\"') .. "\"")
            end, "Run Line")

            vmap("<leader>ms", function()
              local lines = vim.fn.getline("'<", "'>")
              local code = table.concat(lines, "; ")
              vim.cmd("split | terminal octave --no-gui --eval \"" .. code:gsub('"', '\\"') .. "\"")
            end, "Run Selection")

            -- Octave package management
            map("<leader>mp", function()
              vim.cmd("split | terminal octave --no-gui --eval \"pkg list\"")
            end, "List Packages")

            map("<leader>mP", function()
              local pkg = vim.fn.input("Package: ")
              if pkg ~= "" then
                vim.cmd("split | terminal octave --no-gui --eval \"pkg install -forge " .. pkg .. "\"")
              end
            end, "Install Package")

            map("<leader>mL", function()
              local pkg = vim.fn.input("Package: ")
              if pkg ~= "" then
                vim.cmd("split | terminal octave --no-gui --eval \"pkg load " .. pkg .. "\"")
              end
            end, "Load Package")
          else
            -- MATLAB commands
            map("<leader>mr", function()
              local file = vim.fn.expand("%:r")
              vim.cmd("split | terminal matlab -batch \"run('" .. file .. "')\"")
            end, "Run File (MATLAB)")

            map("<leader>mR", function()
              local file = vim.fn.expand("%")
              vim.cmd("split | terminal matlab -nodesktop -nosplash -r \"run('" .. file .. "'); exit\"")
            end, "Run File (no desktop)")

            map("<leader>mi", function()
              vim.cmd("split | terminal matlab -nodesktop -nosplash")
            end, "MATLAB CLI")

            map("<leader>mI", function()
              vim.cmd("!matlab &")
            end, "MATLAB GUI")

            map("<leader>ml", function()
              local line = vim.api.nvim_get_current_line()
              vim.cmd("split | terminal matlab -batch \"" .. line:gsub('"', '\\"') .. "\"")
            end, "Run Line")

            vmap("<leader>ms", function()
              local lines = vim.fn.getline("'<", "'>")
              local code = table.concat(lines, "; ")
              vim.cmd("split | terminal matlab -batch \"" .. code:gsub('"', '\\"') .. "\"")
            end, "Run Selection")
          end

          -- Common commands (work for both)
          map("<leader>mc", function()
            vim.cmd("split | terminal " .. (use_octave and "octave --no-gui --eval \"clear all\"" or "matlab -batch \"clear all\""))
          end, "Clear Workspace")

          map("<leader>mw", function()
            vim.cmd("split | terminal " .. (use_octave and "octave --no-gui --eval \"whos\"" or "matlab -batch \"whos\""))
          end, "Show Workspace")

          -- Help
          map("<leader>mh", function()
            local word = vim.fn.expand("<cword>")
            if use_octave then
              vim.cmd("split | terminal octave --no-gui --eval \"help " .. word .. "\"")
            else
              vim.cmd("split | terminal matlab -batch \"help " .. word .. "\"")
            end
          end, "Help (word)")

          map("<leader>mH", function()
            local word = vim.fn.input("Help topic: ")
            if word ~= "" then
              if use_octave then
                vim.cmd("split | terminal octave --no-gui --eval \"help " .. word .. "\"")
              else
                vim.cmd("split | terminal matlab -batch \"help " .. word .. "\"")
              end
            end
          end, "Help (input)")

          map("<leader>md", function()
            local word = vim.fn.expand("<cword>")
            if use_octave then
              vim.cmd("split | terminal octave --no-gui --eval \"doc " .. word .. "\"")
            else
              vim.cmd("split | terminal matlab -batch \"doc " .. word .. "\"")
            end
          end, "Documentation")

          -- Plotting
          map("<leader>mpf", function()
            if use_octave then
              vim.cmd("split | terminal octave --no-gui --eval \"figure; " .. vim.api.nvim_get_current_line() .. "; pause\"")
            else
              vim.cmd("split | terminal matlab -batch \"figure; " .. vim.api.nvim_get_current_line() .. "; pause\"")
            end
          end, "Plot Line")

          map("<leader>mps", function()
            local file = vim.fn.input("Save figure to: ", "figure.png")
            if file ~= "" then
              if use_octave then
                vim.cmd("split | terminal octave --no-gui --eval \"print('-dpng', '" .. file .. "')\"")
              else
                vim.cmd("split | terminal matlab -batch \"saveas(gcf, '" .. file .. "')\"")
              end
            end
          end, "Save Figure")

          -- Path management
          map("<leader>mpa", function()
            local dir = vim.fn.input("Add to path: ", vim.fn.getcwd())
            if dir ~= "" then
              if use_octave then
                vim.cmd("split | terminal octave --no-gui --eval \"addpath('" .. dir .. "')\"")
              else
                vim.cmd("split | terminal matlab -batch \"addpath('" .. dir .. "')\"")
              end
            end
          end, "Add to Path")

          -- Debugging
          map("<leader>mdb", function()
            local file = vim.fn.expand("%:r")
            local line = vim.fn.line(".")
            if use_octave then
              vim.cmd("split | terminal octave --no-gui --eval \"dbstop in " .. file .. " at " .. line .. "\"")
            else
              vim.cmd("split | terminal matlab -batch \"dbstop in " .. file .. " at " .. line .. "\"")
            end
          end, "Set Breakpoint")

          map("<leader>mdc", function()
            if use_octave then
              vim.cmd("split | terminal octave --no-gui --eval \"dbclear all\"")
            else
              vim.cmd("split | terminal matlab -batch \"dbclear all\"")
            end
          end, "Clear Breakpoints")

          -- Testing (MATLAB Unit Test)
          map("<leader>mt", function()
            local file = vim.fn.expand("%:r")
            if use_octave then
              vim.cmd("split | terminal octave --no-gui --eval \"test " .. file .. "\"")
            else
              vim.cmd("split | terminal matlab -batch \"results = runtests('" .. file .. "'); disp(results)\"")
            end
          end, "Run Tests")

          -- Create function template
          map("<leader>mn", function()
            local name = vim.fn.input("Function name: ")
            if name ~= "" then
              local template = string.format([[
function [output] = %s(input)
%%  %s - Short description
%%
%%  Syntax:
%%    output = %s(input)
%%
%%  Inputs:
%%    input - Description of input
%%
%%  Outputs:
%%    output - Description of output
%%
%%  Example:
%%    output = %s(input)
%%

%% Implementation
output = input;

end
]], name, string.upper(name), name, name)

              local filename = name .. ".m"
              local file = io.open(filename, "w")
              if file then
                file:write(template)
                file:close()
                vim.cmd("edit " .. filename)
                vim.notify("Created function: " .. filename, vim.log.levels.INFO)
              end
            end
          end, "New Function")

          -- Create class template
          map("<leader>mN", function()
            local name = vim.fn.input("Class name: ")
            if name ~= "" then
              local template = string.format([[
classdef %s
    %%  %s - Short description
    %%
    %%  Example:
    %%    obj = %s()

    properties
        Property1
    end

    methods
        function obj = %s(arg1)
            %% Constructor
            if nargin > 0
                obj.Property1 = arg1;
            end
        end

        function output = method1(obj, input)
            %% Method description
            output = obj.Property1 + input;
        end
    end
end
]], name, string.upper(name), name, name)

              local filename = name .. ".m"
              local file = io.open(filename, "w")
              if file then
                file:write(template)
                file:close()
                vim.cmd("edit " .. filename)
                vim.notify("Created class: " .. filename, vim.log.levels.INFO)
              end
            end
          end, "New Class")

          -- Code actions
          map("<leader>maa", function()
            vim.lsp.buf.code_action()
          end, "Code Actions")

          map("<leader>mhh", function()
            vim.lsp.buf.hover()
          end, "Hover Info")
        end,
      })
    end,
  },
}
