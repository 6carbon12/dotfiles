return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function ()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      "                                                  ██████╗██████╗ ██████╗                                            ",
      "                                                 ██╔════╝██╔══██╗██╔══██╗                                           ",
      "                                                 ██║     ██████╔╝██████╔╝                                           ",
      "                                                 ██║     ██╔═══╝ ██╔═══╝                                            ",
      "                                                 ╚██████╗██║     ██║                                                ",
      "                                                  ╚═════╝╚═╝     ╚═╝                                                ",
      " ██████╗ ██████╗ ██████╗ ██╗   ██╗    ██████╗  █████╗ ███████╗████████╗███████╗    ██████╗ ██████╗  █████╗ ██╗   ██╗",
      "██╔════╝██╔═══██╗██╔══██╗╚██╗ ██╔╝    ██╔══██╗██╔══██╗██╔════╝╚══██╔══╝██╔════╝    ██╔══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝",
      "██║     ██║   ██║██████╔╝ ╚████╔╝     ██████╔╝███████║███████╗   ██║   █████╗      ██████╔╝██████╔╝███████║ ╚████╔╝ ",
      "██║     ██║   ██║██╔═══╝   ╚██╔╝      ██╔═══╝ ██╔══██║╚════██║   ██║   ██╔══╝      ██╔═══╝ ██╔══██╗██╔══██║  ╚██╔╝  ",
      "╚██████╗╚██████╔╝██║        ██║       ██║     ██║  ██║███████║   ██║   ███████╗    ██║     ██║  ██║██║  ██║   ██║   ",
      " ╚═════╝ ╚═════╝ ╚═╝        ╚═╝       ╚═╝     ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝    ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ",
      "                                                                                                                    ",
    }


    dashboard.section.buttons.val = {
      dashboard.button("e", "  New file", ":enew<CR>"),
      dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
      dashboard.button("l", "  Restore session", ":lua require('persistence').load()<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }

    dashboard.section.footer.val = {
      "",
      "",
      "",
      "",
      "",
      "",
      "Win if u can, lose if u must, BUT always cheat",
    }

    alpha.setup(dashboard.opts)
  end
}

