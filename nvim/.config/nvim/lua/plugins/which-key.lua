return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    plugins = { spelling = true },
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    defaults = {
      mode = { 'n', 'v' },
      ['g'] = { name = '+goto' },
      [']'] = { name = '+next' },
      ['['] = { name = '+prev' },
      ['<leader>b'] = { name = '+Buffer' },
      ['<leader>c'] = { name = '+Code' },
      ['<leader>d'] = { name = '+Document' },
      ['<leader>g'] = { name = '+Git' },
      ['<leader>l'] = { name = '+LSP' },
      ['<leader>w'] = { name = '+Workspace' },
      ['<leader>s'] = { name = '+Search' },
      ['<leader>gh'] = { name = '+Hunks' },
      ['<leader>gs'] = { name = '+Surround' },
      ['<leader>x'] = { name = '+diagnostics/quickfix' },
    },
  },
  config = function(_, opts)
    local wk = require 'which-key'
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
