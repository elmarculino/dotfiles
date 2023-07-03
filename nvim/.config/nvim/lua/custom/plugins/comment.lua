local M = {
  'numToStr/Comment.nvim',
  event = { 'BufRead', 'BufNewFile' },
  dependencies = {
    {
      'JoosepAlviste/nvim-ts-context-commentstring',
      event = 'VeryLazy',
    },
  },
}

function M.config()
  require('Comment').setup {

    -- LHS of operator-pending mapping in NORMAL + VISUAL mode
    opleader = {
      -- line-comment keymap
      line = 'gc',
      -- block-comment keymap
      block = 'gb',
    },

    -- Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
    mappings = {

      -- operator-pending mapping
      -- Includes:
      --  `gcc`               -> line-comment  the current line
      --  `gcb`               -> block-comment the current line
      --  `gc[count]{motion}` -> line-comment  the region contained in {motion}
      --  `gb[count]{motion}` -> block-comment the region contained in {motion}
      basic = true,

      -- extra mapping
      -- Includes `gco`, `gcO`, `gcA`
      extra = true,
    },

    -- LHS of toggle mapping in NORMAL + VISUAL mode
    toggler = {
      -- line-comment keymap
      --  Makes sense to be related to your opleader.line
      line = 'gcc',

      -- block-comment keymap
      --  Make sense to be related to your opleader.block
      block = 'gbc',
    },

    pre_hook = function(ctx)
      local U = require 'Comment.utils'

      local status_utils_ok, utils = pcall(require, 'ts_context_commentstring.utils')
      if not status_utils_ok then
        return
      end

      local location = nil
      if ctx.ctype == U.ctype.block then
        location = utils.get_cursor_location()
      elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
        location = utils.get_visual_start_location()
      end

      local status_internals_ok, internals = pcall(require, 'ts_context_commentstring.internals')
      if not status_internals_ok then
        return
      end

      return internals.calculate_commentstring {
        key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
        location = location,
      }
    end,
  }

  local comment_ft = require 'Comment.ft'
  comment_ft.set('lua', { '--%s', '--[[%s]]' })
end

return M
