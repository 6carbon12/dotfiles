return {
    "onsails/lspkind.nvim",
    config = function()
        require("lspkind").init({
            mode = "symbol",      -- 'symbol' for icons only, 'symbol_text' for icon + text
            preset = "codicons",  -- VS Code-like icons
        })
    end,
}

