return {
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    -- config = function()
    --   require 'elmaculino.plugins.telescope'
    -- end,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
}
