return {
  {
    'NeogitOrg/neogit',
    dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
    lazy = true,
    cmd = 'Neogit',
    keys = {
      { '<leader>gg', '<cmd>Neogit<CR>', desc = 'Open Neo[g]it' },
      { '<leader>gc', '<cmd>Neogit commit<CR>', desc = 'Open Neogit [c]ommit Page' },
    },
    config = function()
      require('neogit').setup {
        disable_commit_confirmation = true,
        integrations = {
          diffview = true,
        },
      }
    end,
  },
}
