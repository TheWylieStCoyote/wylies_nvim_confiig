-- Harpoon Configuration
-- Quick file navigation - mark files and jump instantly

return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- Lazy load on first keypress
    keys = {
      { "<leader>ha", function() require("harpoon"):list():add(); vim.notify("Added to Harpoon", vim.log.levels.INFO) end, desc = "Harpoon: Add File" },
      { "<leader>hr", function() require("harpoon"):list():remove(); vim.notify("Removed from Harpoon", vim.log.levels.INFO) end, desc = "Harpoon: Remove File" },
      { "<leader>hh", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon: Toggle Menu" },
      { "<leader>hc", function() require("harpoon"):list():clear(); vim.notify("Harpoon list cleared", vim.log.levels.INFO) end, desc = "Harpoon: Clear All" },
      { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon: File 1" },
      { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon: File 2" },
      { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon: File 3" },
      { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon: File 4" },
      { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "Harpoon: File 5" },
      { "<leader>hp", function() require("harpoon"):list():prev() end, desc = "Harpoon: Previous" },
      { "<leader>hn", function() require("harpoon"):list():next() end, desc = "Harpoon: Next" },
      { "[h", function() require("harpoon"):list():prev() end, desc = "Harpoon: Previous" },
      { "]h", function() require("harpoon"):list():next() end, desc = "Harpoon: Next" },
      { "<leader>h1", function() require("harpoon"):list():replace_at(1); vim.notify("Replaced slot 1", vim.log.levels.INFO) end, desc = "Harpoon: Replace at 1" },
      { "<leader>h2", function() require("harpoon"):list():replace_at(2); vim.notify("Replaced slot 2", vim.log.levels.INFO) end, desc = "Harpoon: Replace at 2" },
      { "<leader>h3", function() require("harpoon"):list():replace_at(3); vim.notify("Replaced slot 3", vim.log.levels.INFO) end, desc = "Harpoon: Replace at 3" },
      { "<leader>h4", function() require("harpoon"):list():replace_at(4); vim.notify("Replaced slot 4", vim.log.levels.INFO) end, desc = "Harpoon: Replace at 4" },
      { "<leader>h5", function() require("harpoon"):list():replace_at(5); vim.notify("Replaced slot 5", vim.log.levels.INFO) end, desc = "Harpoon: Replace at 5" },
    },
    opts = {
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
        key = function()
          local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
          if vim.v.shell_error == 0 and git_root ~= "" then
            return git_root
          end
          return vim.fn.getcwd()
        end,
      },
      default = {
        display = function(list_item)
          return vim.fn.fnamemodify(list_item.value, ":~:.")
        end,
      },
    },
  },
}
