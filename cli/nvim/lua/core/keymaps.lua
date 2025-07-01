local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key is set in init.lua

-- Insert mode shortcuts
keymap("i", "jj", "<Esc>", opts)
keymap("i", "ww", "<Esc>:w<CR>", opts)
keymap("i", "zz", "<C-o>zz", opts)


-- File tree toggle
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Buffer navigation
keymap("n", "<C-m>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<C-n>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<C-x>", ":bdelete<CR>", opts)

-- Diagnostics popup
keymap("n", "<leader><leader>", ":lua vim.diagnostic.open_float()<CR>", opts)

-- Redo
keymap("n", "<leader>u", ":redo<CR>", opts)

-- Format
vim.keymap.set("n", "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })
