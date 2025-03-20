-- debug.lua
--
-- Configures the DAP plugin for debugging in Neovim, with a focus on Python
-- via nvim-dap-python, but extensible to other languages.

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Debugger UI
    { 'rcarriga/nvim-dap-ui', dependencies = { 'nvim-neotest/nvim-nio' } },
    -- Debug adapter management
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    -- Python debugging
    'mfussenegger/nvim-dap-python',
    -- Virtual text support
    'theHamsta/nvim-dap-virtual-text',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- Setup mason-nvim-dap for automatic debugger installation
    require('mason-nvim-dap').setup {
      automatic_setup = true,
      handlers = {},
      ensure_installed = {
        'debugpy', -- Python debugger
        -- Add other debuggers here as needed (e.g., 'codelldb' for C/C++)
      },
    }

    -- Configure DAP UI
    dapui.setup {
      layouts = {
        {
          elements = { 'scopes', 'breakpoints', 'stacks', 'watches' },
          size = 40,
          position = 'left',
        },
        {
          elements = { 'repl' }, -- Uncommented for interactive debugging
          size = 10,
          position = 'bottom',
        },
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

    -- Keymap to evaluate variable under cursor
    vim.keymap.set('n', '<leader>de', function()
      dapui.eval(nil, { enter = true })
    end, { desc = 'Debug: Evaluate under cursor' })

    -- Standardized debugging keymaps with <leader>d prefix
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<leader>dt', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Conditional Breakpoint' })
    vim.keymap.set('n', '<leader>dr', dap.repl.toggle, { desc = 'Debug: Toggle REPL' })
    vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'Debug: Run Last' })
    vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Debug: Toggle UI' })
    vim.keymap.set('n', '<leader>dh', function()
      require('dap.ui.widgets').hover()
    end, { desc = 'Debug: Hover' })
    vim.keymap.set('n', '<leader>dp', function()
      require('dap.ui.widgets').preview()
    end, { desc = 'Debug: Preview' })
    vim.keymap.set('n', '<leader>dw', function()
      dapui.elements.watches.add()
    end, { desc = 'Debug: Add to Watches' })
    vim.keymap.set('n', '<leader>dR', function()
      dapui.open { reset = true }
    end, { desc = 'Debug: Reset UI Layout' })
    vim.keymap.set('n', '<leader>dC', dap.run_to_cursor, { desc = 'Debug: Run to Cursor' })
    vim.keymap.set('n', '<leader>dg', dap.goto_, { desc = 'Debug: Go to Line (No Execute)' })
    vim.keymap.set('n', '<leader>dj', dap.down, { desc = 'Debug: Down Stack' })
    vim.keymap.set('n', '<leader>dk', dap.up, { desc = 'Debug: Up Stack' })
    vim.keymap.set('n', '<leader>ds', dap.session, { desc = 'Debug: Session Info' })
    vim.keymap.set('n', '<leader>dx', dap.terminate, { desc = 'Debug: Terminate' })
    vim.keymap.set('n', '<leader>dP', dap.pause, { desc = 'Debug: Pause' })

    -- Optional: Define get_args for running with arguments
    -- local function get_args()
    --   -- Implement logic to get arguments (e.g., prompt or hardcoded list)
    --   return vim.split(vim.fn.input('Args: '), ' ')
    -- end
    -- vim.keymap.set('n', '<leader>da', function()
    --   dap.continue { before = get_args }
    -- end, { desc = 'Debug: Run with Arguments' })

    -- Auto-open/close DAP UI with debugging events
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.attach['dapui_config'] = dapui.open
    dap.listeners.before.launch['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Setup Python debugging
    require('dap-python').setup '$HOME/micromamba/envs/aws/bin/python'

    -- Configure virtual text for debugging
    require('nvim-dap-virtual-text').setup {
      enabled = true, -- Enable virtual text
      enabled_commands = true, -- Enable commands like :DapVirtualTextEnable
      highlight_changed_variables = true, -- Highlight changed variables
      highlight_new_as_changed = false, -- Don’t treat new variables as changed
      show_stop_reason = true, -- Show why execution stopped
      commented = false, -- Don’t prefix with comment symbols
      only_first_definition = true, -- Show only first definition of variables
      all_references = false, -- Don’t show all references
    }
  end,
}
