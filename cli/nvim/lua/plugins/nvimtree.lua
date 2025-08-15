return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- Optional icons
  },
  config = function()
    require("nvim-tree").setup({
      hijack_cursor = true,        -- cursor stays on file when opening
      update_focused_file = {
        enable = true,             -- auto-focus file in tree if it is in cwd
        update_root = false,       -- don't change cwd to focus the file
      },

      actions = {
        open_file = {
          quit_on_open = true,
        },
      },

      view = {
        width = 35,
        side = "right",
        preserve_window_proportions = true,
      },

      renderer = {
        indent_markers = { enable = true }, -- guide lines for folders
        icons = {
          show = {
            folder_arrow = false,
          },
        },
      },

      filters = {
        custom = { "^\\.git$" },    -- hide .git folder
      },
    })
  end,
}

