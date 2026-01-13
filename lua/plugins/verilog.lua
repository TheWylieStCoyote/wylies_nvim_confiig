-- Verilog/SystemVerilog Development Configuration
-- LSP (verible), linting (verilator), and simulation (iverilog) support

return {
  -- TreeSitter parsers for Verilog
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "systemverilog", -- Note: "verilog" parser doesn't exist, use systemverilog
      })
    end,
  },

  -- Mason: ensure Verilog tools are installed
  -- Note: svls may fail. Install manually: cargo install svls
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "verible",
        -- "svls", -- May fail, install with cargo instead
      })
    end,
  },

  -- Verible LSP configuration (Google's Verilog toolchain)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        verible = {
          cmd = { "verible-verilog-ls" },
          filetypes = { "verilog", "systemverilog" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.root_pattern(
              "verible.filelist",
              ".git",
              "*.sv",
              "*.v"
            )(fname) or vim.fn.getcwd()
          end,
          settings = {},
        },
        -- Alternative: svls (SystemVerilog Language Server)
        svls = {
          cmd = { "svls" },
          filetypes = { "verilog", "systemverilog" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.root_pattern(
              ".svls.toml",
              ".git"
            )(fname) or vim.fn.getcwd()
          end,
          settings = {},
        },
      },
    },
  },

  -- Code formatting with verible-verilog-format
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        verilog = { "verible_verilog_format" },
        systemverilog = { "verible_verilog_format" },
      },
      formatters = {
        verible_verilog_format = {
          command = "verible-verilog-format",
          args = {
            "--inplace",
            "--indentation_spaces=2",
            "--column_limit=100",
            "$FILENAME",
          },
          stdin = false,
        },
      },
    },
  },

  -- Linting with verilator and verible-verilog-lint
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        verilog = { "verilator" },
        systemverilog = { "verilator" },
      },
      linters = {
        verilator = {
          cmd = "verilator",
          args = {
            "--lint-only",
            "-Wall",
            "--quiet-exit",
            "--error-limit",
            "100",
          },
          stream = "stderr",
          ignore_exitcode = true,
        },
      },
    },
  },

  -- Verilog-specific keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "verilog", "systemverilog" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "Verilog: " .. desc })
          end

          -- Simulation with Icarus Verilog
          map("<leader>vc", function()
            local file = vim.fn.expand("%")
            local out = vim.fn.expand("%:r")
            vim.cmd("split | terminal iverilog -o " .. out .. ".vvp " .. file)
          end, "Compile (iverilog)")

          map("<leader>vC", function()
            local file = vim.fn.expand("%")
            local out = vim.fn.expand("%:r")
            vim.cmd("split | terminal iverilog -g2012 -o " .. out .. ".vvp " .. file)
          end, "Compile (SV 2012)")

          map("<leader>vr", function()
            local vvp = vim.fn.expand("%:r") .. ".vvp"
            vim.cmd("split | terminal vvp " .. vvp)
          end, "Run Simulation")

          map("<leader>vR", function()
            local file = vim.fn.expand("%")
            local out = vim.fn.expand("%:r")
            vim.cmd("split | terminal iverilog -o " .. out .. ".vvp " .. file .. " && vvp " .. out .. ".vvp")
          end, "Compile & Run")

          -- Waveform viewing (GTKWave)
          map("<leader>vw", function()
            local vcd = vim.fn.expand("%:r") .. ".vcd"
            vim.cmd("!gtkwave " .. vcd .. " &")
          end, "View Waveform (VCD)")

          map("<leader>vW", function()
            local vcd = vim.fn.input("VCD file: ", vim.fn.getcwd() .. "/", "file")
            if vcd ~= "" then
              vim.cmd("!gtkwave " .. vcd .. " &")
            end
          end, "View Waveform (select)")

          -- Verilator
          map("<leader>vl", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal verilator --lint-only -Wall " .. file)
          end, "Lint (verilator)")

          map("<leader>vL", function()
            vim.cmd("split | terminal verilator --lint-only -Wall *.v *.sv 2>&1 | head -100")
          end, "Lint All Files")

          map("<leader>vv", function()
            local file = vim.fn.expand("%")
            local out = vim.fn.expand("%:r")
            vim.cmd("split | terminal verilator --cc --exe --build -j 0 " .. file)
          end, "Verilator Build")

          map("<leader>vV", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal verilator --cc --exe --build --trace -j 0 " .. file)
          end, "Verilator Build (trace)")

          -- Verible tools
          map("<leader>vf", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal verible-verilog-format --inplace " .. file)
            vim.cmd("e!") -- Reload file
          end, "Format (verible)")

          map("<leader>vs", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal verible-verilog-syntax " .. file)
          end, "Syntax Check (verible)")

          map("<leader>vS", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal verible-verilog-lint " .. file)
          end, "Lint (verible)")

          -- Yosys synthesis
          map("<leader>vy", function()
            local file = vim.fn.expand("%")
            local out = vim.fn.expand("%:r")
            vim.cmd("split | terminal yosys -p 'read_verilog " .. file .. "; synth; write_json " .. out .. ".json'")
          end, "Synthesize (yosys)")

          map("<leader>yY", function()
            local script = vim.fn.input("Yosys script: ", vim.fn.getcwd() .. "/", "file")
            if script ~= "" then
              vim.cmd("split | terminal yosys -s " .. script)
            end
          end, "Yosys Script")

          -- Testbench generation
          map("<leader>vt", function()
            local module = vim.fn.input("Module name: ", vim.fn.expand("%:r"))
            local tb_file = module .. "_tb.v"
            local template = string.format([[
`timescale 1ns/1ps

module %s_tb;

  // Parameters

  // Signals
  reg clk;
  reg rst_n;

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 100MHz clock
  end

  // Reset generation
  initial begin
    rst_n = 0;
    #20 rst_n = 1;
  end

  // DUT instantiation
  %s dut (
    .clk(clk),
    .rst_n(rst_n)
  );

  // Test stimulus
  initial begin
    $dumpfile("%s.vcd");
    $dumpvars(0, %s_tb);

    // Wait for reset
    @(posedge rst_n);
    @(posedge clk);

    // Add test cases here

    #1000;
    $display("Test completed");
    $finish;
  end

endmodule
]], module, module, module, module)

            -- Create testbench file
            local file = io.open(tb_file, "w")
            if file then
              file:write(template)
              file:close()
              vim.cmd("edit " .. tb_file)
              vim.notify("Created testbench: " .. tb_file, vim.log.levels.INFO)
            end
          end, "Generate Testbench")

          -- Module template
          map("<leader>vn", function()
            local module = vim.fn.input("Module name: ")
            if module ~= "" then
              local template = string.format([[
module %s #(
  parameter WIDTH = 8
) (
  input  wire             clk,
  input  wire             rst_n,
  input  wire [WIDTH-1:0] data_in,
  output reg  [WIDTH-1:0] data_out
);

  // Internal signals

  // Sequential logic
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= '0;
    end else begin
      data_out <= data_in;
    end
  end

  // Combinational logic

endmodule
]], module)

              local filename = module .. ".v"
              local file = io.open(filename, "w")
              if file then
                file:write(template)
                file:close()
                vim.cmd("edit " .. filename)
                vim.notify("Created module: " .. filename, vim.log.levels.INFO)
              end
            end
          end, "New Module")

          -- FPGA tools (if available)
          map("<leader>vFv", function()
            vim.cmd("split | terminal vivado -mode batch -source build.tcl")
          end, "Vivado Build")

          map("<leader>vFq", function()
            vim.cmd("split | terminal quartus_sh --flow compile " .. vim.fn.input("Project: "))
          end, "Quartus Build")

          -- Code navigation
          map("<leader>va", function()
            vim.lsp.buf.code_action()
          end, "Code Actions")

          map("<leader>vh", function()
            vim.lsp.buf.hover()
          end, "Hover Info")

          -- Module hierarchy (using verible)
          map("<leader>vm", function()
            local file = vim.fn.expand("%")
            vim.cmd("split | terminal verible-verilog-kythe-extractor " .. file .. " 2>/dev/null || echo 'Install verible for hierarchy'")
          end, "Module Info")
        end,
      })
    end,
  },
}
