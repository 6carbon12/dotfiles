return {
  "folke/tokyonight.nvim",
  config = function()
    require("tokyonight").setup({
      style = "night",     -- Options: "night", "storm", "day"
      -- transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        functions = { bold = true },
        keywords = { italic = true },
        strings = { italic = true },
        -- sidebars = "transparent",
        -- floats = "transparent",
      },
      sidebars = { "qf", "vista_kind", "terminal", "packer", "transparent" },
      hide_inactive_statusline = false,
    })

    vim.cmd("colorscheme tokyonight")

    -- Custom highlights (after setting the colorscheme)
    -- vim.api.nvim_set_hl(0, "LineNr", { fg = "#3B4262" })           -- Normal line numbers
    -- vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFFFFF", bold = true }) -- Current line

  end,
}

