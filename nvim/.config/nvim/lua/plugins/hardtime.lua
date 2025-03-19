return {
  'm4xshen/hardtime.nvim',
  dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
  event = 'VeryLazy',
  opts = {},
  config = function()
    require('hardtime').setup()
  end,
}
