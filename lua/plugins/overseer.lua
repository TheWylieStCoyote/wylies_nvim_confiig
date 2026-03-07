-- Overseer.nvim Configuration
-- Task runner and build system with VS Code tasks.json support

return {
  {
    "stevearc/overseer.nvim",
    cmd = {
      "OverseerRun",
      "OverseerToggle",
      "OverseerOpen",
      "OverseerClose",
      "OverseerBuild",
      "OverseerTaskAction",
      "OverseerInfo",
      "OverseerLoadBundle",
      "OverseerSaveBundle",
    },
    keys = {
      { "<leader>vr", "<cmd>OverseerRun<cr>", desc = "Overseer: Run Task" },
      { "<leader>vt", "<cmd>OverseerToggle<cr>", desc = "Overseer: Toggle Panel" },
      { "<leader>va", "<cmd>OverseerTaskAction<cr>", desc = "Overseer: Task Action" },
      { "<leader>vl", "<cmd>OverseerRun<cr>", desc = "Overseer: Run Last" },
      { "<leader>vb", "<cmd>OverseerBuild<cr>", desc = "Overseer: Build" },
      { "<leader>vi", "<cmd>OverseerInfo<cr>", desc = "Overseer: Info" },
      { "<leader>vs", "<cmd>OverseerSaveBundle<cr>", desc = "Overseer: Save Bundle" },
      { "<leader>vo", "<cmd>OverseerLoadBundle<cr>", desc = "Overseer: Load Bundle" },
    },
    opts = {
      strategy = "terminal",
      templates = { "builtin" },
      task_list = {
        direction = "bottom",
        min_height = 15,
        max_height = 25,
        default_detail = 1,
        bindings = {
          ["?"] = "ShowHelp",
          ["g?"] = "ShowHelp",
          ["<CR>"] = "RunAction",
          ["<C-e>"] = "Edit",
          ["o"] = "Open",
          ["<C-v>"] = "OpenVsplit",
          ["<C-s>"] = "OpenSplit",
          ["<C-f>"] = "OpenFloat",
          ["<C-q>"] = "OpenQuickFix",
          ["p"] = "TogglePreview",
          ["<C-l>"] = "IncreaseDetail",
          ["<C-h>"] = "DecreaseDetail",
          ["L"] = "IncreaseAllDetail",
          ["H"] = "DecreaseAllDetail",
          ["["] = "DecreaseWidth",
          ["]"] = "IncreaseWidth",
          ["{"] = "PrevTask",
          ["}"] = "NextTask",
          ["<C-k>"] = "ScrollOutputUp",
          ["<C-j>"] = "ScrollOutputDown",
          ["q"] = "Close",
        },
      },
      form = {
        border = "rounded",
        win_opts = { winblend = 0 },
      },
      confirm = {
        border = "rounded",
        win_opts = { winblend = 0 },
      },
      task_win = {
        border = "rounded",
        win_opts = { winblend = 0 },
      },
    },
  },
}
