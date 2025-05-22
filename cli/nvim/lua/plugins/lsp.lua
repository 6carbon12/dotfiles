return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup({})
        lspconfig.emmet_ls.setup({
            filetypes = { "html", "css", "javascriptreact", "typescriptreact" },
        })
    end,
}

