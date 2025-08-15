return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier_tailwind" },
        typescriptreact = { "prettier_tailwind" },
        html = { "prettier_tailwind" },
        css = { "prettier_tailwind" },
        json = { "prettier" },
        markdown = { "prettier" },
        yaml = { "prettier" },
        lua = { "stylua" },
      },
      formatters = {
        prettier_tailwind = {
          command = "prettier",
          args = {
            "--plugin", "prettier-plugin-tailwindcss",
            "--stdin-filepath", "$FILENAME",
          },
          stdin = true,
        },
      },
    })
  end,
}
