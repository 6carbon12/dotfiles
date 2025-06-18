return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
        },
      },
    })
    lspconfig.emmet_ls.setup({
      filetypes = { "html", "css", "javascriptreact", "typescriptreact" },
    })
  end,
}

