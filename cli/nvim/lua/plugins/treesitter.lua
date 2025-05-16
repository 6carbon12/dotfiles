return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "python", "c", "lua", "bash", "jsonc", "ini", "toml" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}

