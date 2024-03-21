-- Navigate code with search labels, enhanced character motions.
return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  config = function()
    local flash = require 'flash'

    local function jump_to_line()
      flash.jump {
        search = { mode = 'search', max_length = 0 },
        label = { after = { 0, 0 } },
        pattern = '^',
      }
    end

    vim.keymap.set({ 'n', 'x', 'o' }, 's', flash.jump, { desc = 'Flash' })
    vim.keymap.set({ 'n', 'x', 'o' }, 'S', flash.treesitter, { desc = 'Flash Treesitter' })
    vim.keymap.set({ 'o' }, 'r', flash.remote, { desc = 'Remote Flash' })
    vim.keymap.set({ 'x', 'o' }, 'R', flash.treesitter_search, { desc = 'Treesitter Search' })
    vim.keymap.set({ 'c' }, '<C-s>', flash.toggle, { desc = 'Toggle Flash Search' })
    vim.keymap.set({ 'n' }, '<leader>j', jump_to_line, { desc = 'Jump to line' })
  end,
}
