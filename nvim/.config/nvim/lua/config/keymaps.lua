-- [[ Basic Keymaps ]]

-- Resize with arrows
vim.keymap.set('n', '<S-Up>', ':resize -2<CR>', { silent = true })
vim.keymap.set('n', '<S-Down>', ':resize +2<CR>', { silent = true })
vim.keymap.set('n', '<S-Left>', ':vertical resize -2<CR>', { silent = true })
vim.keymap.set('n', '<S-Right>', ':vertical resize +2<CR>', { silent = true })

-- Clear highlights
vim.keymap.set('n', '<leader>h', '<cmd>nohlsearch<CR>', { silent = true })

-- Better paste
vim.keymap.set('v', 'p', 'P', { silent = true })

-- Insert --
-- Press jk fast to enter
vim.keymap.set('i', 'jk', '<ESC>', { silent = true })

-- Visual --
-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', { silent = true })
vim.keymap.set('v', '>', '>gv', { silent = true })

-- Plugins --
-- Lsp
vim.keymap.set('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format{ async = true }<cr>', { desc = '[F]format', silent = true })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- vim.keymap.set('n', '∆', [[:echo "Alt-j pressed"<CR>]], { noremap = true, silent = true })
-- Move Lines
vim.keymap.set('n', '∆', '<cmd>m .+1<cr>==', { desc = 'Move down' })
vim.keymap.set('n', '˚', '<cmd>m .-2<cr>==', { desc = 'Move up' })
vim.keymap.set('i', '∆', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
vim.keymap.set('i', '˚', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })
vim.keymap.set('v', '∆', ":m '>+1<cr>gv=gv", { desc = 'Move down' })
vim.keymap.set('v', '˚', ":m '<-2<cr>gv=gv", { desc = 'Move up' })

-- buffers
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Next buffer' })

vim.keymap.set('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
vim.keymap.set('n', '<leader>`', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })

-- Clear search with <esc>
vim.keymap.set({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and clear hlsearch' })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
vim.keymap.set('n', '<leader>ur', '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>', { desc = 'Redraw / clear hlsearch / diff update' })

vim.keymap.set({ 'n', 'x' }, 'gw', '*N', { desc = 'Search word under cursor' })

-- Add undo break-points
vim.keymap.set('i', ',', ',<c-g>u')
vim.keymap.set('i', '.', '.<c-g>u')
vim.keymap.set('i', ';', ';<c-g>u')

-- save file
vim.keymap.set({ 'i', 'v', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })

-- new file
vim.keymap.set('n', '<leader>bn', '<cmd>enew<cr>', { desc = 'New File' })

vim.keymap.set('n', '<leader>xl', '<cmd>lopen<cr>', { desc = 'Location List' })
vim.keymap.set('n', '<leader>xq', '<cmd>copen<cr>', { desc = 'Quickfix List' })

-- quit
vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })

-- Terminal Mappings
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Enter Normal Mode' })
vim.keymap.set('t', '<C-/>', '<cmd>close<cr>', { desc = 'Hide Terminal' })
vim.keymap.set('t', '<c-_>', '<cmd>close<cr>', { desc = 'which_key_ignore' })

-- Tmux
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

-- Zenmod
vim.keymap.set('n', '<leader>z', '<cmd>ZenMod<CR>', { desc = 'Open [Z]enMod' })

-- vim.cmd([[%s/\(\d\+\)/\1,/g | v/\S/d | %join]])

local function format_list()
	vim.cmd([[
    %s/\(\d\+\)/\1,/g | v/\S/d | %join
    execute 'normal $x' | execute 'normal ggVGYY'
	]])
end

vim.keymap.set('n', '<leader>fl', format_list, { desc = 'Format List' })


vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
