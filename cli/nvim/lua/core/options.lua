-- Indentation settings
vim.o.tabstop = 4        -- A tab is 4 spaces
vim.o.shiftwidth = 4     -- Auto-indent uses 4 spaces
vim.o.expandtab = true   -- Tabs are spaces
vim.o.smartindent = true
vim.o.autoindent = true

-- UI
vim.opt.cmdheight = 0                 -- Hide command line when not needed
vim.wo.relativenumber = true         -- Show relative line numbers
vim.o.showcmd = true                 -- Show command in statusline
vim.o.showcmdloc = "statusline"
vim.o.linebreak = true

vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.ERROR },
  },
  signs = {
    severity = { min = vim.diagnostic.severity.ERROR },
  },
  underline = {
    severity = { min = vim.diagnostic.severity.ERROR },
  },
  float = {
    severity = { min = vim.diagnostic.severity.ERROR },
  },
})

