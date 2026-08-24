-- Override the LazyVim dashboard header (lazyvim/plugins/ui.lua) with our own
-- name, drawn in the same ANSI Shadow figlet font LazyVim uses.
return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
██╗    ██╗██╗   ██╗██╗     ██╗███████╗██╗   ██╗██╗███╗   ███╗
██║    ██║╚██╗ ██╔╝██║     ██║██╔════╝██║   ██║██║████╗ ████║
██║ █╗ ██║ ╚████╔╝ ██║     ██║█████╗  ██║   ██║██║██╔████╔██║
██║███╗██║  ╚██╔╝  ██║     ██║██╔══╝  ╚██╗ ██╔╝██║██║╚██╔╝██║
╚███╔███╔╝   ██║   ███████╗██║███████╗ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚══╝╚══╝    ╚═╝   ╚══════╝╚═╝╚══════╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
]],
        },
      },
    },
  },
}
