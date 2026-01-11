return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "python", "c", "lua", "bash", "jsonc", "ini", "toml", "javascript" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}

