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
require("core.keymaps")

-- autocmds
require("core.autocmds")

-- Plugins
require("plugins.init")

vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { sp = "#7aa2f7", underline = true, bold = true})
vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { sp = "#7aa2f7", underline = true })
vim.api.nvim_set_hl(0, "BufferLineModifiedSelected", { fg = "#f7768e", sp = "#7aa2f7",underline = true })     -- The ● icon
