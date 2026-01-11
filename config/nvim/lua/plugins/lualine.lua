return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = 'tokyonight',
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "NvimTree" },
          winbar = {},
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          "diff",
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            sections = { "error" },
            symbols = { error = "🚫:" },
            colored = true,
            update_in_insert = false,
          },
        },
        lualine_c = {
          "filename",
          {
            function()
              local sc = vim.fn.searchcount({ maxcount = 0 })
              if sc.total > 0 then
                return string.format("[%d/%d]", sc.current, sc.total)
              end
              return ""
            end,
            cond = function()
              return vim.v.hlsearch == 1
            end
          },
        },
        lualine_x = {
          {
            function ()
              local reg = vim.fn.reg_recording()
              if reg ~= "" then
                return "REC @" .. reg
              end
              return ""
            end
          },
          "fileformat",
          "filetype"
        },
        lualine_y = { "progress", "location" },
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "fzf" },
    })
  end,
}

