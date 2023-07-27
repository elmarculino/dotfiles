local ok, telescope = pcall(require, 'telescope')
if not ok then
  return
end

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(telescope.load_extension, 'fzf')

-- Shorten function name
local keymap = vim.keymap.set
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')

-- See `:help telescope.builtin`
keymap('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
keymap('n', '<leader>,', builtin.buffers, { desc = '[,] Find existing buffers' })
keymap('n', '<leader>.', builtin.find_files, { desc = '[S]earch [F]iles' })
keymap('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
keymap('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
keymap('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
keymap('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
keymap('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
keymap('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
