local ok, _ = pcall(require, "telescope")
if not ok then
  return
end

local opts = { noremap=true, silent=true }

vim.api.nvim_set_keymap('n', '<leader>.', '<cmd>lua require("elmarculino.telescope").project_files()<cr>', opts)
vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>lua require("elmarculino.telescope").project_files()<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>,', '<cmd>lua require("elmarculino.telescope").buffers()<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fo', '<cmd>lua require("telescope.builtin").oldfiles()<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>/', '<cmd>lua require("elmarculino.telescope").current_buffer()<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fs', '<cmd>lua require("elmarculino.telescope").current_buffer()<cr>', opts)
