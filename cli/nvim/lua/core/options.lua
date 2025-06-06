-- Indentation settings
vim.o.tabstop = 4        -- A tab is 4 spaces
vim.o.shiftwidth = 4     -- Auto-indent uses 4 spaces
vim.o.expandtab = true   -- Tabs are spaces
vim.o.smartindent = true
vim.o.autoindent = true

-- UI
vim.opt.cmdheight = 0                 -- Hide command line when not needed
vim.wo.relativenumber = true         -- Show relative line numbers
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

vim.o.foldenable = true
vim.o.foldmethod = 'expr' 
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevel = 99
vim.opt.foldcolumn = '0'
vim.opt.foldlevelstart = 99
vim.opt.fillchars = {
  fold = ' ',
  foldopen = '▾',
  foldclose = '▸',
  foldsep = '│',
}
function _G.custom_fold_text()
  local line = vim.fn.getline(vim.v.foldstart)
  local lines_count = vim.v.foldend - vim.v.foldstart + 1
  local suffix = string.format("             ..%d lines ", lines_count)
  local available_width = vim.o.textwidth > 0 and vim.o.textwidth or 80
  local target_width = available_width - #suffix
  if #line > target_width then
    line = string.sub(line, 1, target_width - 3) .. "..."
  end
  return line .. suffix
end

vim.opt.foldtext = 'v:lua.custom_fold_text()'

