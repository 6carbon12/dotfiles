-- bootstrap Lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- set leader key early
vim.g.mapleader = " "

-- Core config
require("core.options")

-- autocmds
require("core.autocmds")

-- commands
require("core.commands")

-- Plugins
require("plugins.init")

-- Keymaps
require("core.keymaps")

vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { sp = "#7aa2f7", underline = true, bold = true})
vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { sp = "#7aa2f7", underline = true })
vim.api.nvim_set_hl(0, "BufferLineModifiedSelected", { fg = "#f7768e", sp = "#7aa2f7",underline = true })     -- The ● icon
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#7aa2f7", italic = true })
vim.api.nvim_set_hl(0, "Search",    { bg = "#2e3b4e", fg = "#82aaff", bold = true })
vim.api.nvim_set_hl(0, "IncSearch", { bg = "#1f2a38", fg = "#a0e4ff", bold = true })

