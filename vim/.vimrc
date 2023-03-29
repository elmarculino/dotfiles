" Specify a directory for plugins 
call plug#begin('~/.vim/plugged')

Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'tpope/vim-surround'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'

" Initialize plugin system
call plug#end()

syntax on
filetype plugin indent on

set encoding=utf-8
set tags=./tags;,tags$HOME

set tabstop=2                   " number of visual spaces per TAB
set shiftwidth=2                " number of spaces in tab when editing
set softtabstop=2               " number of spaces a backspace will remove after TAB
set expandtab
set autoindent                  " minimal automatic indenting for any filetype.
set backspace=indent,eol,start  " Proper backspace behavior.
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2
set hidden                      " possibility to have more than one unsaved buffers
set number relativenumber       " enable relativenumber
set splitbelow
set splitright

colorscheme jellybeans
let g:airline_theme='jellybeans'
let g:SimpylFold_docstring_preview = 1

map <C-n> :NERDTreeToggle<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-p> :GFiles<Cr>
nnoremap <C-g> :Rg<Cr>

"nmap <Leader>f :Files<CR>
nmap <Leader>' :Marks<CR>
nmap <Leader>/ :Rg<Space>
nmap <Leader>: :History:<CR>
nmap <Leader>B :FZFLines<CR>
nmap <Leader>C :Commands<CR>
nmap <Leader>H :Helptags!<CR>
nmap <Leader>L :Lines<CR>
nmap <Leader>M :Maps<CR>
nmap <Leader>T :Tags<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>d :FzfFasdDir<CR>
nmap <Leader>f :FzfFasdFile<CR>
nmap <Leader>h :History<CR>
nmap <Leader>l :BLines<CR>
nmap <Leader>p :Prettier<CR>
nmap <Leader>t :BTags<CR>

nnoremap <S-j> :m-2<CR>
nnoremap <S-k> :m+<CR>

" Edit vimr configuration file
nnoremap <Leader>ve :e $MYVIMRC<CR>
nnoremap confe :e $MYVIMRC<CR>
" Reload vimr configuration file
nnoremap <Leader>vr :source $MYVIMRC<CR>
nnoremap confr :source $MYVIMRC<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" coc Prettier command 
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

command! FzfFasdFile call fzf#run(fzf#wrap({'source': 'fasd -lf -R', 'sink': { line -> execute('e '.split(line)[-1])  }}))
command! FzfFasdDir call fzf#run(fzf#wrap({'source': 'fasd -ld -R', 'sink': { line -> execute('NERDTree '.split(line)[-1]) }}))

function! s:fasd_update() abort
    if empty(&buftype) || &filetype ==# 'dirvish'
        call job_start(['fasd', '-A', expand('%:p')])
    endif
endfunction
augroup fasd
    autocmd!
    autocmd BufWinEnter,BufFilePost * call s:fasd_update()
augroup END

"Search lines in all open vim buffers
function! s:line_handler(l)
	let keys = split(a:l, ':\t')
	exec 'buf' keys[0]
	exec keys[1]
	normal! ^zz
endfunction

function! s:buffer_lines()
	let res = []
	for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
		call extend(res, map(getbufline(b,0,"$"), 'b . ":\t" . (v:key + 1) . ":\t" . v:val '))
	endfor
	return res
endfunction

command! FZFLines call fzf#run({ 'source': <sid>buffer_lines(), 'sink': function('<sid>line_handler'), 'options': '--extended --nth=3..', 'down': '60%' }) })

augroup TooLong
    autocmd!
    autocmd winEnter,BufEnter * call clearmatches() | call matchadd('ColorColumn', '\%>80v', 100)
augroup END

function! EditAllBuffersAndComeBackWithoutLosingHighlighting()
    let this_buffer = bufnr("%")
    bufdo set eventignore= | if &buftype != "nofile" && expand("%") != '' | edit | endif
    execute "b" . this_buffer
endfunction

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
"set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes


" ----------------------------------------------------------------
" Shougo/vimfiler.vim
" ----------------------------------------------------------------
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
noremap <silent> <leader>f :VimFilerBuffer -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit<cr>

autocmd FileType vimfiler call s:vimfiler_settings()
function! s:vimfiler_settings() abort
  silent! nunmap <buffer> <C-l>
endfunction

autocmd BufEnter * if winnr('$') == 1 && exists('b:vimfiler') && b:vimfiler['context']['explorer'] | quit | endif
