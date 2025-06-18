-- Indentation settings
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true

-- UI
vim.opt.cmdheight = 0                 -- Hide command line when not needed
vim.wo.relativenumber = true         -- Show relative line numbers
vim.o.linebreak = true

-- Colored line number with undercurl for diagnostics
vim.diagnostic.config({
  virtual_text = false,
  signs = true,      -- enable signs
  underline = true, -- we skip underline now
  update_in_insert = false,
  severity_sort = true,
})

vim.fn.sign_define("DiagnosticSignError", { text = "", numhl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn",  { text = "", numhl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint",  { text = "", numhl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo",  { text = "", numhl = "DiagnosticSignInfo" })

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl=true, sp="#ff5c57" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",  { undercurl=true, sp="#f3f99d" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo",  { undercurl=true, sp="#57c7ff" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint",  { undercurl=true, sp="#9aedfe" })

-- Making folds work
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

