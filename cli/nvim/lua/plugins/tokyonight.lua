return {
  "folke/tokyonight.nvim",
  config = function()
    require("tokyonight").setup({
      style = "night",
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        functions = { bold = true },
        keywords = { italic = true },
        strings = { italic = true },
        sidebars = "transparent",
        floats = "dark",
      },
      sidebars = "dark",
      hide_inactive_statusline = false,
    })

    vim.cmd([[colorscheme tokyonight]])

  end,
}

