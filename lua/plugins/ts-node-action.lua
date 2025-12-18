-- ts-node-action Configuration
-- TreeSitter-based code actions

return {
  {
    "CKolkey/ts-node-action",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    keys = {
      {
        "<leader>cn",
        function() require("ts-node-action").node_action() end,
        desc = "Node Action",
      },
      {
        "gn",
        function() require("ts-node-action").node_action() end,
        desc = "Node Action",
      },
    },
  },
}
