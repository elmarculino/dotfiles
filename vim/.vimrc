" Specify a directory for plugins 
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install() }}
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'tmhedberg/SimpylFold'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'sheerun/vim-polyglot'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'

" Initialize plugin system
call plug#end()

syntax on
filetype plugin indent on

set encoding=utf-8
set tags=./tags;,tags$HOME

set tabstop=2                   " number of visual spaces per TAB"
set shiftwidth=2                " number of spaces in tab when editing"
set softtabstop=2               " number of spaces a backspace will remove after TAB"
set expandtab
set autoindent                  " minimal automatic indenting for any filetype.
set backspace=indent,eol,start  " Proper backspace behavior.
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2
set foldcolumn=3
set hidden                      " possibility to have more than one unsaved buffers"
set number relativenumber       " enable relativenumber"
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

let g:coc_global_extensions = [ 
			\ 'coc-emoji', 'coc-tsserver', 'coc-prettier',
			\ 'coc-css', 'coc-json', 'coc-yaml', 'coc-git', 'coc-pairs' ]

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

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <C-d> <Plug>(coc-range-select)
"xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"" Using CocList
"" Show all diagnostics
"nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions
"nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
"" Show commands
"nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document
"nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list
"nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
