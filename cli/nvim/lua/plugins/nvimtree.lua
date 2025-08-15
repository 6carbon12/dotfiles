return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- Optional icons
  },
  config = function()
    require("nvim-tree").setup({
      filters = {
        custom = {
          "^.git$"
        }
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      view = {
        side = "right",
      }
    })
  end,
}

