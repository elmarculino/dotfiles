-- oil.lua
-- Configures oil.nvim as a lightweight file explorer.

return {
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- For file icons
    event = 'VeryLazy', -- Load on demand (adjust as needed)
    opts = {
      columns = { 'icon' }, -- Show file icons in the buffer
      keymaps = {
        ['<C-h>'] = false, -- Disable default split keymap
        ['<M-h>'] = 'actions.select_split', -- Alt+h to open in horizontal split
        ['q'] = 'actions.close', -- Add q to close oil buffer
        ['<C-p>'] = 'actions.preview', -- Preview files with Ctrl+p
      },
      view_options = {
        show_hidden = true, -- Show hidden files by default
        is_always_hidden = function(name, _)
          return name == '.' or name == '..' -- Hide . and .. entries
        end,
      },
      float = {
        padding = 2, -- Padding around floating window
        max_width = 90, -- Limit width of floating window
        max_height = 20, -- Limit height of floating window
      },
      win_options = {
        winbar = '%{v:lua.require("oil").get_current_dir()}', -- Show current dir in winbar
      },
    },
    config = function(_, opts)
      local oil = require 'oil'
      oil.setup(opts)

      -- Keymaps
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', {
        desc = 'Open parent directory in current window',
      })
      vim.keymap.set('n', '<leader>-', function()
        oil.toggle_float()
      end, {
        desc = 'Toggle oil in floating window',
      })
    end,
  },
}
