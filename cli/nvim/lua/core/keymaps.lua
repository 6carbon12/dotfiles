local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key is set in init.lua

-- Insert mode shortcuts
keymap("i", "jj", "<Esc>", opts)
keymap("i", "ww", "<Esc>:w<CR>", opts)

-- File tree toggle
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Buffer navigation
keymap("n", "<C-m>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<C-n>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<C-x>", ":bdelete<CR>", { silent = true }) -- non-noremap version to allow command aliases

-- Diagnostics popup
keymap("n", "<leader><leader>", ":lua vim.diagnostic.open_float()<CR>", opts)

-- Redo
keymap("n", "<leader>u", ":redo<CR>", opts)

