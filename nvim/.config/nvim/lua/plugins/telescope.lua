return {

  {
    'nvim-telescope/telescope.nvim',
    commit = vim.fn.has 'nvim-0.9.0' == 0 and '057ee0f8783' or nil,
    cmd = 'Telescope',
    version = false, -- telescope did only one release, so use HEAD for now
    keys = function()
      local builtin = require 'telescope.builtin'
      return {
        { '<leader>gf', builtin.git_files, desc = 'Search [G]it [F]iles' },
        { '<leader>sw', builtin.grep_string, desc = '[S]earch current [W]ord' },
        { '<leader>/', builtin.live_grep, desc = 'Grep (root dir)' },
        { '<leader>sg', builtin.live_grep, desc = 'Grep (root dir)' },
        { '<leader>.', builtin.find_files, desc = 'Find Files (root dir)' },
        { '<leader>,', '<cmd>Telescope buffers show_all_buffers=true<cr>', desc = 'Switch Buffer' },
        { '<leader>bs', '<cmd>Telescope buffers<cr>', desc = 'Switch Buffers' },
        { '<leader>:', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
        -- git
        { '<leader>gc', '<cmd>Telescope git_commits<CR>', desc = 'commits' },
        { '<leader>gs', '<cmd>Telescope git_status<CR>', desc = 'status' },
        -- search
        { '<leader>s"', '<cmd>Telescope registers<cr>', desc = 'Registers' },
        { '<leader>sa', '<cmd>Telescope autocommands<cr>', desc = 'Auto Commands' },
        { '<leader>sb', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Buffer' },
        { '<leader>sc', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
        { '<leader>sC', '<cmd>Telescope commands<cr>', desc = 'Commands' },
        { '<leader>sd', '<cmd>Telescope diagnostics bufnr=0<cr>', desc = 'Document diagnostics' },
        { '<leader>sD', '<cmd>Telescope diagnostics<cr>', desc = 'Workspace diagnostics' },
        { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = 'Help Pages' },
        { '<leader>sH', '<cmd>Telescope highlights<cr>', desc = 'Search Highlight Groups' },
        { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = 'Key Maps' },
        { '<leader>sM', '<cmd>Telescope man_pages<cr>', desc = 'Man Pages' },
        { '<leader>sm', '<cmd>Telescope marks<cr>', desc = 'Jump to Mark' },
        { '<leader>so', '<cmd>Telescope vim_options<cr>', desc = 'Options' },
        { '<leader>sr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent' },
        { '<leader>sR', '<cmd>Telescope resume<cr>', desc = 'Resume' },
        {
          '<leader>sw',
          function()
            builtin.grep_string { word_match = '-w' }
          end,
          desc = 'Word (root dir)',
        },
        {
          '<leader>sW',
          function()
            builtin.grep_string { cwd = false, word_match = '-w' }
          end,
          desc = 'Word (cwd)',
        },
        {
          '<leader>sw',
          function()
            builtin.grep_string { mode = 'v' }
          end,
          desc = 'Selection (root dir)',
        },
        {
          '<leader>sW',
          function()
            builtin.grep_string { cwd = false, mode = 'v' }
          end,
          desc = 'Selection (cwd)',
        },
        {
          '<leader>uC',
          function()
            builtin.colorscheme { enable_preview = true }
          end,
          desc = 'Colorscheme with preview',
        },
      }
    end,
    opts = {
      defaults = {
        git_worktrees = vim.g.git_worktrees,
        path_display = { 'truncate' },
        sorting_strategy = 'ascending',
        layout_config = {
          horizontal = { prompt_position = 'top', preview_width = 0.55 },
          vertical = { mirror = false },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
      },
    },
  },
  {
    'telescope.nvim',
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      config = function()
        require('telescope').load_extension 'fzf'
      end,
    },
  },
}
