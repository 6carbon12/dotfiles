vim.api.nvim_create_autocmd("User", {
  pattern = "TreesitterAttach",
  callback = function(args)
    vim.schedule(function()
      local buf = args.buf
      vim.api.nvim_buf_set_option(buf, "foldmethod", "expr")
      vim.api.nvim_buf_set_option(buf, "foldexpr", "nvim_treesitter#foldexpr()")
      vim.api.nvim_buf_set_option(buf, "foldenable", true)
      vim.api.nvim_buf_set_option(buf, "foldlevel", 99)
      vim.api.nvim_buf_call(buf, function()
        vim.cmd("normal! zx")
      end)
    end)
  end,
})
