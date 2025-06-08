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

-- Plugins
require("plugins.init")

-- autocmds
require("core.autocmds")

