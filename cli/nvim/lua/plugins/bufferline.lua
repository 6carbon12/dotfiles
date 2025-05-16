return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({
      options = {
        numbers = "none", -- or "ordinal" or "both"
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        indicator = { style = "icon", icon = "|" },
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
      },
    })
  end,
}

