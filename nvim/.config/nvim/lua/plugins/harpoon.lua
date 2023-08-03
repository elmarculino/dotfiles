return {
  'ThePrimeagen/harpoon',
  keys = function()
    local mark = require 'harpoon.mark'
    local ui = require 'harpoon.ui'

    return {
      { '<C-a>', function() mark.add_file() end, },
      { '<C-e>', function() ui.toggle_quick_menu() end, },
      { '<C-h>', function() ui.nav_file(1) end, },
      { '<C-j>', function() ui.nav_file(2) end, },
      { '<C-k>', function() ui.nav_file(3) end, },
      { '<C-l>', function() ui.nav_file(4) end, },
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
