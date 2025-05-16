-- Bootstrap Lazy.nvim if not installed
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

-- Normal settings

-- Set indentation to 4 spaces instead of tabs
vim.o.tabstop = 4        -- Number of spaces that a tab character represents
vim.o.shiftwidth = 4     -- Number of spaces for each indentation level
vim.o.expandtab = true   -- Use spaces instead of tabs
vim.o.smartindent = true -- Enable smart indentation
vim.o.autoindent = true  -- Enable automatic indentation

-- only errors no warnings
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
    -- Optional: if you use floating diagnostics (hover windows)
    float = {
        severity = { min = vim.diagnostic.severity.ERROR },
    },
})

-- no cmd line when not in use
vim.opt.cmdheight = 0

-- relative line numbers
vim.wo.relativenumber = true

-- command on the status line
vim.o.showcmdloc = "statusline" 

vim.o.showcmd = true
-----------------------------------------------------------------------------
-- Keybinds

-- -- Set leader key to Space
vim.g.mapleader = " "

-- -- In Insert mode, jj will act as Esc
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

-- -- In Insert mode, ww will save the file
vim.keymap.set("i", "ww", "<Esc>:w<CR>", { noremap = true, silent = true })

-- -- leader e to toggle file exploere
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- -- Switch to next tab
vim.keymap.set("n", "<C-m>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })

-- -- Switch to previous tab
vim.keymap.set("n", "<C-n>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })

-- -- Ctrl k to kill tab
vim.keymap.set("n", "<C-x>", ":bdelete<CR>", { noremap = false, silent = true })

-- -- space space to open warnings
vim.keymap.set("n", "<leader><leader>", ":lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })

-- -- space u to redo
vim.keymap.set("n", "<leader>u", ":redo<CR>", { noremap = true, silent = true})
-- -- Focus NvimTree if it's open
-- -- vim.keymap.set("n", "<leader>fe", ":NvimTreeFocus<CR>", { noremap = true, silent = true })

-- -- Focus the editor window (code) with Space + f + c
-- -- vim.keymap.set("n", "<leader>fc", ":wincmd p<CR>", { noremap = true, silent = true })

-- -- unbinding keys for pane changing
-----------------------------------------------------------------------------


-- Set up Lazy
require("lazy").setup({
    -- We'll add plugins here in next steps!
    {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- optional icons
    },
    config = function()
        require("nvim-tree").setup({
                actions = {
                    open_file ={
                        quit_on_open = true
                    }
                }
            })
    end,
    },
    {
	"nvim-treesitter/nvim-treesitter",
   	build = ":TSUpdate",
    	config = function()
        	require("nvim-treesitter.configs").setup({
                ensure_installed = { "python", "c", "lua", "bash", "jsonc", "ini", "toml"},
            	    highlight = { enable = true },
            	    indent = { enable = true },
        	})
	end,
    },
    {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },  -- Icons for the bufferline
    config = function()
        require("bufferline").setup({
            options = {
                numbers = "none",    -- or "ordinal" or "both"
                close_command = "bdelete! %d",  -- command to close a buffer
                right_mouse_command = "bdelete! %d",  -- right-click close
                indicator = { style = "icon", icon = "▎" },
                buffer_close_icon = "",
                modified_icon = "●",
                close_icon = "",
                left_trunc_marker = "",
                right_trunc_marker = "",
                show_buffer_icons = true,
                show_buffer_close_icons = true,
                show_tab_indicators = true,
                persist_buffer_sort = true,
            },
        })
    end,
    },
    {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
                { name = 'path' },
            }),
            formatting = {
                format = require('lspkind').cmp_format({
                mode = 'symbol', -- 'symbol_text' if you want icon + text, 'symbol' for icon only
                maxwidth = 50,   -- optional: limit popup width
                })
            }

        })
    end
    },
    {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup {}
    end
    },
    {
    -- Mason to download lsps
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup {
            ensure_installed = { "lua_ls" },  -- Add more servers here later
        }

        -- Loop through servers and set them up with default config
        local lspconfig = require("lspconfig")
        local servers = require("mason-lspconfig").get_installed_servers()
            for _, server in ipairs(servers) do
            if server ~= "clangd" then
                lspconfig[server].setup {}
            end
        end        
    end
    },
    {
    -- icons for suggestions
    "onsails/lspkind.nvim",
    config = function()
        require('lspkind').init({
            -- Enables text + icon (but you can disable text later if you want only icons)
            mode = 'symbol', -- Use 'symbol' for icon only, 'symbol_text' for icon + text

            -- You can customize icons here if you want!
            preset = 'codicons', -- VS Code-like icons
        })
    end
    },
    {
    -- theme
    "folke/tokyonight.nvim",
    config = function()
        -- Set the theme (You can also use 'tokyonight-storm' or 'tokyonight-day')
        vim.cmd("colorscheme tokyonight")
    end
    },
    {
    -- better status line
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    },
    {
    -- Markdown preview
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    },
    {
    'numToStr/Comment.nvim', 
    opts = {}, -- optional config
    lazy = false,
    }

})

-- comment.nvim
require("Comment").setup({
    sticky = true,
    toggler = {
        line = '<leader>/'
    }
})

-- tokyonight
require("tokyonight").setup({
    style = "night",     -- Options: "night", "storm", "day"
    transparent = true,  
    terminal_colors = true,
    styles = {
        comments = { italic = true },
        functions = { bold = true },
        keywords = { italic = true },
        strings = { italic = true },
        sidebars = "transparent",
        floats = "transparent",
    },
    sidebars = { "qf", "vista_kind", "terminal", "packer", "transparent"},  -- Which windows to have a darker background
    hide_inactive_statusline = false,

})

-- status line
require('lualine').setup {
  options = {
    theme = 'palenight', -- You can use your favorite theme here
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    disabled_filetypes = {
            statusline = { 'NvimTree' },
            winbar = {},
        }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff',
        {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        sections = { 'error' }, -- ✅ only show errors
        symbols = { error = '🚫:' }, -- 🚫 remove warn/info/hint
        colored = true, -- optional: keeps color on error count
        update_in_insert = false, -- optional: don't update in insert mode
        }
        },

    lualine_c = { 'filename', '%s' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress', 'location'  },
    lualine_z = {
    }
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  extensions = { 'fzf' },
}
