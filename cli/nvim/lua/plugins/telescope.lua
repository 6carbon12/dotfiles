return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    -- This is where you would add configuration options for telescope,
    -- but the defaults are great to start with.
    require('telescope').setup({})
  end,
}
