return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  config = function()
    local luasnip = require("luasnip")

    luasnip.filetype_extend("javascriptreact", { "react" })
    -- Load custom Lua snippets
    require("luasnip.loaders.from_lua").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
    })

    vim.keymap.set({"i"}, "<C-K>", function() luasnip.expand() end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-Right>", function() luasnip.jump( 1) end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-Left>", function() luasnip.jump(-1) end, {silent = true})

    -- Optional: reload snippets without restarting
    vim.keymap.set("n", "<leader>rs", function()
      require("luasnip.loaders.from_lua").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/lua/snippets" }
      })
      print("Snippets reloaded!")
    end, { desc = "Reload LuaSnip snippets" })
  end,
}

