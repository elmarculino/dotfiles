return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = function()
    local harpoon = require 'harpoon'
    harpoon:setup()
    return {
      { '<C-a>', function() harpoon:list():append() end },
      { '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end },
      { '<C-h>', function() harpoon:list():select(1) end },
      { '<C-j>', function() harpoon:list():select(2) end },
      { '<C-k>', function() harpoon:list():select(3) end },
      { '<C-l>', function() harpoon:list():select(4) end },
    }
  end,
  opts = {
    global_settings = {
      save_on_toggle = false,
      save_on_change = true,
      enter_on_sendcmd = false,
    },
  },
}
