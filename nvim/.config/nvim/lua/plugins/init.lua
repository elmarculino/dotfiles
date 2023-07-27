return {
  'hashivim/vim-terraform',

  -- Lsp Java plugin
  'mfussenegger/nvim-jdtls',
  'mfussenegger/nvim-dap',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Neovim Magit
  { 'NeogitOrg/neogit', dependencies = 'nvim-lua/plenary.nvim' },

  -- Files keyboard shortuts
  { 'ThePrimeagen/harpoon', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Files keyboard shortuts
  {
    'ThePrimeagen/refactoring.nvim',
    event = 'BufReadPost',
    requires = { { 'nvim-lua/plenary.nvim' }, { 'nvim-treesitter/nvim-treesitter' } },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    event = 'BufReadPost',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects', event = 'VeryLazy' },
    },
    build = ':TSUpdate',
  },
}
