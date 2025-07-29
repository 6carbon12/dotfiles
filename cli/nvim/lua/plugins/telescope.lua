return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.x', -- Recommended to pin to a stable version
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    -- This is where you would add configuration options for telescope,
    -- but the defaults are great to start with.
    require('telescope').setup({})
  end,
}
