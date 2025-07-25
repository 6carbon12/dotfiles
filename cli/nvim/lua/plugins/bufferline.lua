return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({
      options = {
        numbers = "none",
        sort_by = function(buf_a, buf_b)
          local buffer_order = _G.BUFF_ORDER or {}
          local a_idx, b_idx = nil, nil
          for i, v in ipairs(buffer_order) do
            if v == buf_a.id then a_idx = i end
            if v == buf_b.id then b_idx = i end
          end

          if not a_idx and not b_idx then return buf_a.id < buf_b.id end
          if not a_idx then return false end
          if not b_idx then return true end

          return a_idx < b_idx
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            separator = true
          }
        },
        indicator = {style = 'underline'},
        separator_style = "slope",
        diagnostics = "none",
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        buffer_close_icon = "󰅙",
        close_icon = "󰅙",
        modified_icon = "●",
        left_trunc_marker = "",
        right_trunc_marker = "",
        show_buffer_icons = true,
        persist_buffer_sort = true,
        show_buffer_close_icons = false,
        show_tab_indicators = false,
      },
    })
  end,
}

