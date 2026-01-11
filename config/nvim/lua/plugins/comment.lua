return {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup({
      sticky = true,
      toggler = {
        line = '<leader>/'
      }
    })
  end,
  lazy = false, -- Load on startup
}

