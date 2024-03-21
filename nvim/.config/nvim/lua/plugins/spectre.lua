return {
  -- search/replace in multiple files
  'nvim-pack/nvim-spectre',
  cmd = 'Spectre',
  opts = { open_cmd = 'noswapfile vnew' },
  config = function()
    vim.keymap.set('n', '<leader>fr', function()
      require('spectre').open()
    end, { desc = 'Replace in files (Spectre)' })
  end,
}
