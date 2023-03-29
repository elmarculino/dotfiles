nnoremap <silent><leader>ha :lua require("harpoon.mark").add_file()<CR>
nnoremap <silent><leader>he :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <silent><leader>hc :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>

nnoremap <silent><leader>hj :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent><leader>hk :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <silent><leader>hl :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent><leader>h; :lua require("harpoon.ui").nav_file(4)<CR>
