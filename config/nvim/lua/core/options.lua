-- Good to have
vim.o.ignorecase = true         -- ignore case in search...
vim.o.smartcase = true          -- ...unless capital letter is in search
vim.o.scrolloff = 8             -- keep 8 lines visible above/below cursor
vim.o.sidescrolloff = 8         -- keep 8 columns visible side-to-side
vim.o.undofile = true           -- persistent undo across sessions
vim.o.swapfile = false          -- disable swap files
vim.o.backup = false            -- disable backup
vim.o.writebackup = false       -- disable backup before overwrite
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Indentation settings
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.opt.list = true
vim.opt.listchars = {
    tab = "▏ ",
    leadmultispace = "▏ ",
    trail = "•",
}

-- UI
vim.opt.cmdheight = 0                 -- Hide command line when not needed
vim.opt.relativenumber = true         -- Show relative line numbers
vim.opt.number = true                 -- Show relative line numbers
vim.opt.signcolumn = "yes"
vim.opt.numberwidth = 4
vim.opt.cursorline = true
vim.o.linebreak = true
vim.o.termguicolors = true

-- Colored line number with undercurl for diagnostics
vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅙 ",
      [vim.diagnostic.severity.WARN]  = " ",
      [vim.diagnostic.severity.HINT]  = "󰌵 ",
      [vim.diagnostic.severity.INFO]  = " ",
    },
    texthl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
    },
  }
})

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

