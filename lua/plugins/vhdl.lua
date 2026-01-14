-- VHDL Development Configuration
-- LSP (vhdl_ls/rust_hdl), linting (ghdl), and simulation support

-- Skip entire VHDL config if GHDL is not installed
if vim.fn.executable("ghdl") ~= 1 then
  return {}
end

return {
  -- TreeSitter parsers for VHDL
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "vhdl",
      })
    end,
  },

  -- Note: vhdl_ls is not available in Mason
  -- Install manually: cargo install vhdl_ls
  -- Or via package manager: yay -S rust_hdl

  -- vhdl_ls (rust_hdl) configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vhdl_ls = {
          cmd = { "vhdl_ls" },
          filetypes = { "vhdl" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.root_pattern(
              "vhdl_ls.toml",
              ".vhdl_ls.toml",
              "hdl-prj.json",
              ".git"
            )(fname) or vim.fn.getcwd()
          end,
          settings = {},
          -- Note: vhdl_ls requires a vhdl_ls.toml config file
          -- Example vhdl_ls.toml:
          -- [libraries]
          -- lib_name.files = ["src/*.vhd"]
          -- lib_name.standard = "2008"
        },
      },
    },
  },

  -- Code formatting with VHDL Style Guide (vsg)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        vhdl = { "vsg" },
      },
      formatters = {
        vsg = {
          command = "vsg",
          args = {
            "-f",
            "$FILENAME",
            "--output_format",
            "stdout",
          },
          stdin = false,
        },
      },
    },
  },

  -- Linting with GHDL
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        vhdl = { "ghdl" },
      },
      linters = {
        ghdl = {
          cmd = "ghdl",
          args = {
            "-s",
            "--std=08",
            "--ieee=synopsys",
          },
          stream = "stderr",
          ignore_exitcode = true,
        },
      },
    },
  },

  -- VHDL-specific keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "vhdl" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "VHDL: " .. desc })
          end

          -- GHDL Analysis/Compilation
          map("<leader>Va", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal ghdl -a --std=08 " .. file)
          end, "Analyze (ghdl -a)")

          map("<leader>VA", function()
            vim.cmd("split | terminal ghdl -a --std=08 *.vhd")
          end, "Analyze All")

          map("<leader>Ve", function()
            local unit = vim.fn.input("Top-level unit: ", vim.fn.expand("%:r"))
            if unit ~= "" then
              vim.cmd("split | terminal ghdl -e --std=08 " .. unit)
            end
          end, "Elaborate (ghdl -e)")

          map("<leader>Vr", function()
            local unit = vim.fn.input("Unit to run: ", vim.fn.expand("%:r"))
            if unit ~= "" then
              vim.cmd("split | terminal ghdl -r --std=08 " .. unit .. " --wave=" .. unit .. ".ghw")
            end
          end, "Run Simulation")

          map("<leader>VR", function()
            local unit = vim.fn.input("Unit to run: ", vim.fn.expand("%:r"))
            local time = vim.fn.input("Stop time (e.g., 100ns): ", "1us")
            if unit ~= "" then
              vim.cmd("split | terminal ghdl -r --std=08 " .. unit .. " --stop-time=" .. time .. " --wave=" .. unit .. ".ghw")
            end
          end, "Run Simulation (timed)")

          -- Combined analyze + elaborate + run
          map("<leader>Vx", function()
            local file = vim.fn.expand("%")
            local unit = vim.fn.expand("%:r")
            vim.cmd("split | terminal ghdl -a --std=08 " .. file .. " && ghdl -e --std=08 " .. unit .. " && ghdl -r --std=08 " .. unit .. " --wave=" .. unit .. ".ghw")
          end, "Analyze + Elaborate + Run")

          -- Syntax check only
          map("<leader>Vs", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal ghdl -s --std=08 " .. file)
          end, "Syntax Check")

          map("<leader>VS", function()
            vim.cmd("split | terminal ghdl -s --std=08 *.vhd")
          end, "Syntax Check All")

          -- Waveform viewing (GTKWave)
          map("<leader>Vw", function()
            local ghw = vim.fn.expand("%:r") .. ".ghw"
            vim.cmd("!gtkwave " .. ghw .. " &")
          end, "View Waveform (GHW)")

          map("<leader>VW", function()
            local wave = vim.fn.input("Waveform file: ", vim.fn.getcwd() .. "/", "file")
            if wave ~= "" then
              vim.cmd("!gtkwave " .. wave .. " &")
            end
          end, "View Waveform (select)")

          -- NVC (alternative simulator)
          map("<leader>Vna", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal nvc -a " .. file)
          end, "NVC Analyze")

          map("<leader>Vne", function()
            local unit = vim.fn.input("Top-level unit: ", vim.fn.expand("%:r"))
            if unit ~= "" then
              vim.cmd("split | terminal nvc -e " .. unit)
            end
          end, "NVC Elaborate")

          map("<leader>Vnr", function()
            local unit = vim.fn.input("Unit to run: ", vim.fn.expand("%:r"))
            if unit ~= "" then
              vim.cmd("split | terminal nvc -r " .. unit .. " --wave=" .. unit .. ".fst")
            end
          end, "NVC Run")

          -- Clean work directory
          map("<leader>Vc", function()
            vim.cmd("split | terminal rm -rf work-obj08.cf *.o *.ghw *.fst *.vcd")
          end, "Clean Build")

          -- Generate vhdl_ls.toml config
          map("<leader>Vi", function()
            local template = [[
# vhdl_ls.toml - VHDL Language Server configuration
# See: https://github.com/VHDL-LS/rust_hdl

[libraries]
# Library name and source files
work.files = [
  "src/*.vhd",
  "tb/*.vhd",
]

# VHDL standard: 1993, 2008, or 2019
work.standard = "2008"

# Add more libraries as needed
# ieee.files = ["path/to/ieee/*.vhd"]
]]
            local file = io.open("vhdl_ls.toml", "w")
            if file then
              file:write(template)
              file:close()
              vim.cmd("edit vhdl_ls.toml")
              vim.notify("Created vhdl_ls.toml", vim.log.levels.INFO)
            end
          end, "Init vhdl_ls.toml")

          -- Testbench generation
          map("<leader>Vt", function()
            local entity = vim.fn.input("Entity name: ", vim.fn.expand("%:r"))
            local tb_file = entity .. "_tb.vhd"
            local template = string.format([[
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity %s_tb is
end entity %s_tb;

architecture sim of %s_tb is
  -- Constants
  constant CLK_PERIOD : time := 10 ns;

  -- Signals
  signal clk     : std_logic := '0';
  signal rst_n   : std_logic := '0';
  signal running : boolean   := true;

begin

  -- Clock generation
  clk <= not clk after CLK_PERIOD / 2 when running else '0';

  -- DUT instantiation
  dut : entity work.%s
    port map (
      clk   => clk,
      rst_n => rst_n
    );

  -- Stimulus process
  stim_proc : process
  begin
    -- Reset
    rst_n <= '0';
    wait for CLK_PERIOD * 5;
    rst_n <= '1';
    wait for CLK_PERIOD * 2;

    -- Add test cases here

    -- End simulation
    wait for CLK_PERIOD * 100;
    running <= false;
    report "Simulation completed successfully" severity note;
    wait;
  end process stim_proc;

end architecture sim;
]], entity, entity, entity, entity)

            local file = io.open(tb_file, "w")
            if file then
              file:write(template)
              file:close()
              vim.cmd("edit " .. tb_file)
              vim.notify("Created testbench: " .. tb_file, vim.log.levels.INFO)
            end
          end, "Generate Testbench")

          -- Entity template
          map("<leader>Vn", function()
            local entity = vim.fn.input("Entity name: ")
            if entity ~= "" then
              local template = string.format([[
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity %s is
  generic (
    WIDTH : positive := 8
  );
  port (
    clk      : in  std_logic;
    rst_n    : in  std_logic;
    data_in  : in  std_logic_vector(WIDTH - 1 downto 0);
    data_out : out std_logic_vector(WIDTH - 1 downto 0)
  );
end entity %s;

architecture rtl of %s is
  -- Signals

begin

  -- Sequential process
  seq_proc : process(clk, rst_n)
  begin
    if rst_n = '0' then
      data_out <= (others => '0');
    elsif rising_edge(clk) then
      data_out <= data_in;
    end if;
  end process seq_proc;

  -- Combinational logic

end architecture rtl;
]], entity, entity, entity)

              local filename = entity .. ".vhd"
              local file = io.open(filename, "w")
              if file then
                file:write(template)
                file:close()
                vim.cmd("edit " .. filename)
                vim.notify("Created entity: " .. filename, vim.log.levels.INFO)
              end
            end
          end, "New Entity")

          -- Package template
          map("<leader>Vp", function()
            local pkg = vim.fn.input("Package name: ")
            if pkg ~= "" then
              local template = string.format([[
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package %s is

  -- Constants
  constant DATA_WIDTH : positive := 8;

  -- Types
  type state_t is (IDLE, RUNNING, DONE);

  -- Functions
  function log2ceil(n : positive) return natural;

  -- Components
  -- component my_component is
  --   port (...);
  -- end component;

end package %s;

package body %s is

  function log2ceil(n : positive) return natural is
    variable result : natural := 0;
    variable value  : positive := 1;
  begin
    while value < n loop
      result := result + 1;
      value  := value * 2;
    end loop;
    return result;
  end function log2ceil;

end package body %s;
]], pkg, pkg, pkg, pkg)

              local filename = pkg .. "_pkg.vhd"
              local file = io.open(filename, "w")
              if file then
                file:write(template)
                file:close()
                vim.cmd("edit " .. filename)
                vim.notify("Created package: " .. filename, vim.log.levels.INFO)
              end
            end
          end, "New Package")

          -- FPGA tools
          map("<leader>VFv", function()
            vim.cmd("split | terminal vivado -mode batch -source build.tcl")
          end, "Vivado Build")

          map("<leader>VFq", function()
            vim.cmd("split | terminal quartus_sh --flow compile " .. vim.fn.input("Project: "))
          end, "Quartus Build")

          -- Code navigation
          map("<leader>Vh", function()
            vim.lsp.buf.hover()
          end, "Hover Info")

          map("<leader>Va", function()
            vim.lsp.buf.code_action()
          end, "Code Actions")

          -- Format with emacs vhdl-mode (alternative)
          map("<leader>Vf", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal emacs --batch " .. file .. " -f vhdl-beautify-buffer -f save-buffer 2>/dev/null && echo 'Formatted with emacs vhdl-mode'")
            vim.cmd("e!")
          end, "Format (emacs)")
        end,
      })
    end,
  },
}
