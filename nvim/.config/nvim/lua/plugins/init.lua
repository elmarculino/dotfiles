return {
  'hashivim/vim-terraform',

  -- Lsp Java plugin
  'mfussenegger/nvim-jdtls',
  'mfussenegger/nvim-dap',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- library used by other plugins
  { 'nvim-lua/plenary.nvim', lazy = true },

  -- search/replace in multiple files
  {
    'nvim-pack/nvim-spectre',
    cmd = 'Spectre',
    opts = { open_cmd = 'noswapfile vnew' },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },
}
