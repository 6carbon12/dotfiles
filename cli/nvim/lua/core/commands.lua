-- helper to delete then maybe show Alpha
local function delete_and_alpha(cmd, args)
  vim.cmd(cmd .. (args == "" and "" or " " .. args))
  if #vim.fn.getbufinfo({buflisted = 1}) == 1 then
    require("alpha").start(true)
  end
end

-- Create a user‑command BD that wraps your buffer.nvim :Bdelete
vim.api.nvim_create_user_command("BD", function(opts)
  delete_and_alpha("bd", table.concat(opts.fargs, " "))
end, {
  nargs = "*",
  complete = "buffer",
  desc = "Bdelete + show Alpha if it was the last buffer",
})
