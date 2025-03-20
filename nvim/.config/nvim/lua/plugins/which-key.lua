return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    plugins = {
      spelling = {
        enabled = true, -- Enable spelling plugin
      },
    },
    setup = function() -- Changed from init to setup
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    spec = { -- Changed from defaults to spec
      {
        mode = { 'n', 'v' },
        { ';g', group = 'goto' },
        { '<leader>b', group = 'Buffer' },
        { '<leader>c', group = 'Code' },
        { '<leader>d', group = 'Debugger' },
        { '<leader>f', group = 'Format' },
        { '<leader>g', group = 'Git' },
        { '<leader>gh', group = 'Hunks' },
        { '<leader>gs', group = 'Surround' },
        { '<leader>l', group = 'LSP' },
        { '<leader>s', group = 'Search' },
        { '<leader>x', group = 'diagnostics/quickfix' },
        { '[', group = 'prev' },
        { ']', group = 'next' },
        { 'g', group = 'goto' },
      },
    },
  },
  config = function(_, opts)
    local wk = require 'which-key'
    wk.setup(opts) -- Setup with options
    wk.add(opts.spec) -- Changed from register to add
  end,
}
