return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls" }, -- add more servers here
    })

    local lspconfig = require("lspconfig")
    local servers = require("mason-lspconfig").get_installed_servers()
    for _, server in ipairs(servers) do
      if server ~= "clangd" then
        lspconfig[server].setup({})
      end
    end
  end,
}

