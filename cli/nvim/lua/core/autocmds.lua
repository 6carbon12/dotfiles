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

local open_buffers = {}
-- Helper to remove buffer from list
local function remove_buf(bufnr)
  for i, v in ipairs(open_buffers) do
    if v == bufnr then
      table.remove(open_buffers, i)
      break
    end
  end
end

-- Add new buffer when it's loaded (not just entered)
vim.api.nvim_create_autocmd("BufAdd", {
  callback = function(args)
    local bufnr = args.buf
    -- Prevent duplicates
    remove_buf(bufnr)
    table.insert(open_buffers, bufnr)

    vim.schedule(function()
      vim.cmd("redrawtabline")
    end)
  end,
})

-- Remove buffer when deleted
vim.api.nvim_create_autocmd("BufDelete", {
  callback = function(args)
    remove_buf(args.buf)

    vim.schedule(function()
      vim.cmd("redrawtabline")
    end)
  end,
})

-- Expose the buffer order globally
_G.BUFF_ORDER = open_buffers

vim.api.nvim_create_autocmd("BufLeave", {
  callback = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_config(win).relative ~= "" then
        vim.api.nvim_win_close(win, true)
      end
    end
  end,
})

