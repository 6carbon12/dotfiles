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
      on_highlights = function (hl, c)
        hl.CursorLineNr =
        {
          fg = c.blue,
          italic = true
        }
        hl.Search =
        {
          bg = c.bg_highlight,
          fg = c.blue5,
          italic = true
        }
        hl.IncSearch =
        {
          bg = c.bg_highlight,
          fg = c.orange,
          bold = true
        }
      end
    })

    vim.cmd([[colorscheme tokyonight]])

  end,
}

