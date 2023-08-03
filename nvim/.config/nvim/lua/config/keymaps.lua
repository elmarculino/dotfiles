-- [[ Basic Keymaps ]]

-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

-- Resize with arrows
keymap('n', '<C-Up>', ':resize -2<CR>', opts)
keymap('n', '<C-Down>', ':resize +2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Clear highlights
keymap('n', '<leader>h', '<cmd>nohlsearch<CR>', opts)

-- Better paste
keymap('v', 'p', 'P', opts)

-- Insert --
-- Press jk fast to enter
keymap('i', 'jk', '<ESC>', opts)

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Plugins --
-- Lsp
keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format{ async = true }<cr>', { desc = '[F]format', silent = true })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
keymap('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- keymap('n', '∆', [[:echo "Alt-j pressed"<CR>]], { noremap = true, silent = true })
-- Move Lines
keymap('n', '∆', '<cmd>m .+1<cr>==', { desc = 'Move down' })
keymap('n', '˚', '<cmd>m .-2<cr>==', { desc = 'Move up' })
keymap('i', '∆', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
keymap('i', '˚', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })
keymap('v', '∆', ":m '>+1<cr>gv=gv", { desc = 'Move down' })
keymap('v', '˚', ":m '<-2<cr>gv=gv", { desc = 'Move up' })

-- buffers
keymap('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev buffer' })
keymap('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
keymap('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev buffer' })
keymap('n', ']b', '<cmd>bnext<cr>', { desc = 'Next buffer' })

keymap('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
keymap('n', '<leader>`', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })

-- Clear search with <esc>
keymap({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and clear hlsearch' })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
keymap('n', '<leader>ur', '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>', { desc = 'Redraw / clear hlsearch / diff update' })

keymap({ 'n', 'x' }, 'gw', '*N', { desc = 'Search word under cursor' })

-- Add undo break-points
keymap('i', ',', ',<c-g>u')
keymap('i', '.', '.<c-g>u')
keymap('i', ';', ';<c-g>u')

-- save file
keymap({ 'i', 'v', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })

-- new file
keymap('n', '<leader>bn', '<cmd>enew<cr>', { desc = 'New File' })

keymap('n', '<leader>xl', '<cmd>lopen<cr>', { desc = 'Location List' })
keymap('n', '<leader>xq', '<cmd>copen<cr>', { desc = 'Quickfix List' })

-- quit
keymap('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })

-- Terminal Mappings
keymap('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Enter Normal Mode' })
keymap('t', '<C-/>', '<cmd>close<cr>', { desc = 'Hide Terminal' })
keymap('t', '<c-_>', '<cmd>close<cr>', { desc = 'which_key_ignore' })

-- Tmux
keymap('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

-- Zenmod
keymap('n', '<leader>z', '<cmd>ZenMod<CR>', { desc = 'Open [Z]enMod' })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
