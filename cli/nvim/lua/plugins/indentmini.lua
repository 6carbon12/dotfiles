return {
  "nvimdev/indentmini.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("indentmini").setup({
      char = "▏",
      exclude = { "help", "lazy", "mason" },
      highlight = {
        "IndentLine",
        "IndentLineCurrent",
      },
    })
    vim.api.nvim_set_hl(0, "IndentLine", { fg = "#3b4261" })
    vim.api.nvim_set_hl(0, "IndentLineCurrent", { fg = "#737aa2" })
  end,
}

