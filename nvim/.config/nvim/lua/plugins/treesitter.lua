-- treesitter.lua
-- Configures nvim-treesitter with context and textobjects support.

return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = false, -- Avoid old releases
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      -- Treesitter context for sticky headers
      {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
          require('treesitter-context').setup {
            enable = true, -- Enable by default
            max_lines = 0, -- No line limit
            trim_scope = 'outer', -- Trim outer scope if too long
            mode = 'cursor', -- Follow cursor
            separator = '-', -- Separator line
          }
        end,
      },
      -- Textobjects (loaded conditionally)
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        event = 'VeryLazy',
        init = function()
          -- Disable by default unless textobjects are explicitly enabled
          require('lazy.core.loader').disable_rtp_plugin 'nvim-treesitter-textobjects'
        end,
      },
    },
    cmd = { 'TSUpdateSync', 'TSInstall', 'TSBufEnable' },
    keys = {
      -- Incremental selection keymaps
      { '<C-space>', desc = 'Increment selection' },
      { '<bs>', desc = 'Decrement selection', mode = 'x' },
      -- Treesitter-context keymaps
      { '<leader>cc', '<cmd>lua require("treesitter-context").toggle()<cr>', desc = 'Toggle Treesitter context' },
      {
        ';gc',
        function()
          require('treesitter-context').go_to_context()
        end,
        desc = '[G]oto [C]ontext',
      },
    },
    ---@type TSConfig
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        'bash',
        'c',
        'html',
        'javascript',
        'json',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'regex',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'yaml',
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
      -- Optional: Uncomment to enable textobjects
      -- textobjects = {
      --   select = {
      --     enable = true,
      --     lookahead = true,
      --     keymaps = {
      --       ['af'] = '@function.outer',
      --       ['if'] = '@function.inner',
      --       ['ac'] = '@class.outer',
      --       ['ic'] = '@class.inner',
      --     },
      --   },
      --   move = {
      --     enable = true,
      --     set_jumps = true,
      --     goto_next_start = {
      --       [']m'] = '@function.outer',
      --     },
      --     goto_previous_start = {
      --       ['[m'] = '@function.outer',
      --     },
      --   },
      -- },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)

      -- Load textobjects plugin only if configured
      if opts.textobjects then
        local loader = require 'lazy.core.loader'
        loader.disabled_rtp_plugins['nvim-treesitter-textobjects'] = nil
        local plugin = require('lazy.core.config').plugins['nvim-treesitter-textobjects']
        loader.source_runtime(plugin.dir, 'plugin')
      end
    end,
  },
}
