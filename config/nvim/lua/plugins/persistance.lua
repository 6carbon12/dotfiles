return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- load early but lazy
  opts = {
    dir = vim.fn.stdpath("state") .. "/sessions", -- save location
    options = { "buffers", "curdir", "tabpages", "winsize" }, -- what's saved
  },
}

