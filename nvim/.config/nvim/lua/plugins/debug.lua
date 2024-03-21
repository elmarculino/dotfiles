-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'mfussenegger/nvim-dap-python',

    -- additional plugins
    'theHamsta/nvim-dap-virtual-text',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      layouts = {
        {
          elements = { 'scopes', 'breakpoints', 'stacks', 'watches' },
          size = 40,
          position = 'left',
        },
        -- {
        --   elements = { 'repl' },
        --   size = 10,
        --   position = 'bottom',
        -- },
      },
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
          collapsed = '+',
        },
      },
    }

    -- Debugging keymaps
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })
    vim.keymap.set('n', '<leader>dd', dapui.toggle, { desc = 'Debug: Toggle DAP UI F7' })
    vim.keymap.set('n', '<leader>dr', dap.repl.toggle, { desc = 'Debug: Toggle REPL' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug: Start/Continue F5' })
    vim.keymap.set('n', '<leader>dC', dap.run_to_cursor, { desc = 'Debug: Run to Cursor' })
    vim.keymap.set('n', '<leader>dg', dap.goto_, { desc = 'Debug: Go to line (no execute)' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step Into F1' })
    vim.keymap.set('n', '<leader>dj', dap.down, { desc = 'Debug: Down' })
    vim.keymap.set('n', '<leader>dk', dap.up, { desc = 'Debug: Up' })
    vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'Debug: Run Last' })
    vim.keymap.set('n', '<leader>do', dap.step_out, { desc = 'Debug: Step Out F3' })
    vim.keymap.set('n', '<leader>dO', dap.step_over, { desc = 'Debug: Step Over F2' })
    vim.keymap.set('n', '<leader>dp', dap.pause, { desc = 'Debug: Pause' })
    vim.keymap.set('n', '<leader>ds', dap.session, { desc = 'Debug: Session' })
    vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = 'Debug: Terminate' })
    vim.keymap.set('n', '<leader>da', function() dap.continue { before = get_args } end, { desc = 'Debug: Run with Args' })
    vim.keymap.set('n', '<leader>dh', function() require('dap.ui.widgets').hover() end, { desc = 'Debug: Hover' })
    vim.keymap.set('n', '<leader>dp', function() require('dap.ui.widgets').preview() end, { desc = 'Debug: preview' })
    vim.keymap.set('n', '<leader>de', function() dapui.eval() end, { desc = 'Debug: Eval' })
    vim.keymap.set('n', '<leader>dw', function() dapui.elements.watches.add() end, { desc = 'Debug: Eval' })
    vim.keymap.set('n', '<leader>du', function() dapui.open { reset = true } end, { desc = 'Debug: Reset DAP UI layout.' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- vim.keymap.set('n', '<leader>dr', function()
    --   dapui.float_element('repl', { enter = true, width = 60, height = 30 })
    -- end, { desc = 'Debug: Open REPL' })
    -- vim.keymap.set('n', '<leader>db', function()
    --   dapui.float_element('breakpoints', { enter = true, width = 60, height = 30 })
    -- end, { desc = 'Debug: Open REPL' })
    -- vim.keymap.set('n', '<leader>dW', function()
    --   dapui.float_element('watches', { enter = true, width = 60, height = 30 })
    -- end, { desc = 'Debug: Open Watches pane' })
    -- vim.keymap.set('n', '<leader>dt', function()
    --   dapui.float_element('stacks', { enter = true, width = 60, height = 30 })
    -- end, { desc = 'Debug: Open Stacks pane' })
    -- vim.keymap.set('n', '<leader>dc', function()
    --   dapui.float_element('scopes', { enter = true, width = 60, height = 30 })
    -- end, { desc = 'Debug: Open Scopes pane' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.attach['dapui_config'] = dapui.open
    dap.listeners.before.launch['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    require('dap-python').setup '/Users/msoares/micromamba/envs/aws/bin/python'
    require('nvim-dap-virtual-text').setup()
  end,
}
