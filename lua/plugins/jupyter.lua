-- Jupyter Notebook Configuration
-- jupytext.nvim: transparent .ipynb <-> percent .py conversion
-- molten-nvim: live kernel execution with inline output

return {
  -- jupytext: open/save .ipynb as percent-format .py
  {
    "GCBallesteros/jupytext.nvim",
    ft = { "python", "markdown" },
    opts = {
      style = "percent",
      output_extension = "py",
      force_ft = "python",
    },
  },

  -- molten: Jupyter kernel execution with inline output
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    ft = { "python" },
    init = function()
      -- Settings must be set before plugin loads
      vim.g.molten_image_provider = "none" -- set to "image.nvim" if installed
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = true
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
    keys = {
      { "<leader>nbi", ":MoltenInit<cr>",              desc = "Notebook: Init Kernel",           ft = "python" },
      { "<leader>nbe", ":MoltenEvaluateLine<cr>",      desc = "Notebook: Evaluate Line",         ft = "python" },
      { "<leader>nbr", ":MoltenReevaluateCell<cr>",    desc = "Notebook: Re-evaluate Cell",      ft = "python" },
      { "<leader>nbd", ":MoltenDelete<cr>",            desc = "Notebook: Delete Cell Output",    ft = "python" },
      { "<leader>nbs", ":MoltenShowOutput<cr>",        desc = "Notebook: Show Output",           ft = "python" },
      { "<leader>nbh", ":MoltenHideOutput<cr>",        desc = "Notebook: Hide Output",           ft = "python" },
      { "<leader>nbI", ":MoltenInterrupt<cr>",         desc = "Notebook: Interrupt Kernel",      ft = "python" },
      { "<leader>nbR", ":MoltenRestart!<cr>",          desc = "Notebook: Restart Kernel",        ft = "python" },
      {
        "<leader>nbe",
        ":<C-u>MoltenEvaluateVisual<cr>",
        mode = "v",
        desc = "Notebook: Evaluate Selection",
        ft = "python",
      },
    },
  },
}
