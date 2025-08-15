local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local function with_desc(desc)
  return vim.tbl_extend("force", opts, { desc = desc })
end

-- Leader key is set in init.lua

-- Insert mode shortcuts
keymap("i", "jj", "<Esc>", with_desc("Insert -> Normal"))
keymap("i", "ww", "<Esc>:w<CR>", with_desc("Write and put me in Normal mode"))
keymap("i", "zz", "<C-o>zz", with_desc("Move this line to center of the window"))

-- File tree toggle
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", with_desc("Toggle File Explorer"))

-- Buffer navigation
-- Relative 
keymap("n", "<M-k>", ":BufferLineCycleNext<CR>", with_desc("Go to next buff"))
keymap("n", "<M-j>", ":BufferLineCyclePrev<CR>", with_desc("Go to previous buff"))
keymap("n", "<M-l>", ":BD<CR>", with_desc("Close current buff"))
-- Absolute
for i = 1, 9 do
  keymap('n', '<leader>' .. i, function()
    vim.cmd('BufferLineGoToBuffer ' .. i)
  end, with_desc("Go to buff" .. i))
end

-- Diagnostics popup
keymap("n", "<leader>d", vim.diagnostic.open_float, with_desc("Open diagnostics floating"))
keymap("n", "K", function ()
  vim.lsp.buf.hover { border = 'rounded' }
end, with_desc("Styled details"))

-- Redo
keymap("n", "<M-u>", ":redo<CR>", with_desc("Redo"))

-- Format
keymap("n", "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })

-- Telescope 
local tele_builtin = require('telescope.builtin')
-- Find files in your project
keymap('n', '<leader>ff', tele_builtin.find_files, with_desc("Find files"))
-- Project wide text search
keymap('n', '<leader>fg', tele_builtin.live_grep, with_desc("grep in project"))
-- Find text in the current buffer
keymap('n', '<leader>fb', tele_builtin.current_buffer_fuzzy_find, with_desc("grep in buffer"))
-- Find word under cursor in project
keymap('n', '<leader>sw', function()
  tele_builtin.grep_string({ default_text = vim.fn.expand("<cword>") })
end, with_desc("Grep word in project"))
-- Find WORD under cursor in project
keymap('n', '<leader>sW', function()
  tele_builtin.grep_string({ default_text = vim.fn.expand("<cWORD>") })
end, with_desc("Grep WORD in project"))

