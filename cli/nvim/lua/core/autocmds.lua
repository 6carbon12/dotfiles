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

vim.api.nvim_create_autocmd("User", {
  pattern = "NvimTreeOpen",
  callback = function()
    -- Loop through buffers and nuke the `[No Name]` one if it's hanging around
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      local name = vim.api.nvim_buf_get_name(buf)
      local ft = vim.api.nvim_buf_get_option(buf, "filetype")
      local listed = vim.api.nvim_buf_get_option(buf, "buflisted")

      if name == "" and listed and ft == "" then
        -- This is the ghost `[No Name]` buffer. Wipe it.
        vim.schedule(function()
          pcall(vim.cmd, "bwipeout " .. buf)
        end)
      end
    end
  end
})

