let data_dir = '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo ' . data_dir . '/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-python/python-syntax'
Plug 'mattesgroeger/vim-bookmarks'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'lervag/vimtex'
Plug 'voldikss/vim-floaterm'
Plug 'liuchengxu/vim-clap', { 'do': { -> clap#installer#force_download() } }
Plug 'ntpeters/vim-better-whitespace'
Plug 'Chiel92/vim-autoformat'
Plug 'dimercel/todo-vim'

call plug#end()

filetype plugin indent on
syntax enable

set nocompatible
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set number
set mouse=a
set nowrap
set hlsearch

nnoremap <C-h> <Left>
nnoremap <C-l> <Right>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" onedark
colorscheme onedark
let g:airline_theme='onedark'
unlet g:terminal_ansi_colors

set cursorline
highlight CursorLine ctermbg=236
highlight CursorLineNR ctermfg=208
highlight Visual ctermbg=darkgray
highlight Normal ctermbg=None
highlight SignColumn ctermbg=None
highlight LineNr ctermbg=None ctermfg=245
highlight Terminal ctermbg=None

" vim-airline
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline#extensions#keymap#enabled=1
let g:airline#extensions#tabline#show_buffers=0

nnoremap <C-n> :tabnew<CR>
inoremap <C-n> <ESC>:tabnew<CR>

nmap <Leader>1 <Plug>AirlineSelectTab1
nmap <Leader>2 <Plug>AirlineSelectTab2
nmap <Leader>3 <Plug>AirlineSelectTab3
nmap <Leader>4 <Plug>AirlineSelectTab4
nmap <Leader>5 <Plug>AirlineSelectTab5
nmap <Leader>6 <Plug>AirlineSelectTab6
nmap <Leader>7 <Plug>AirlineSelectTab7
nmap <Leader>8 <Plug>AirlineSelectTab8
nmap <Leader>9 <Plug>AirlineSelectTab9
nmap <Leader>] <Plug>AirlineSelectNextTab
nmap <Leader>[ <Plug>AirlineSelectPrevTab

" vim-clap
nnoremap <silent> <C-f> :Clap files<CR>
nnoremap <silent> <space><space> :Clap filer<CR>
nnoremap <silent> <C-g> :Clap commits<CR>
nnoremap <silent> <C-p> :Clap buffers<CR>
nnoremap <silent> <C-q> :bdelete<CR>

inoremap <C-p> <ESC>:Clap buffers<CR>

" nerdtree
nnoremap <silent> <space><space><space> :NERDTreeToggle<CR>

" nerdcommenter
let g:NERDSpaceDelims=1
let g:NERDToggleCheckAllLines=1
autocmd FileType python let g:NERDSpaceDelims=0

" python-syntax
let g:python_highlight_all=1

" bookmarks
let g:bookmark_auto_close=1

" coc.nvim
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=100
set shortmess+=c
set signcolumn=yes

let g:coc_global_extensions=['coc-clangd', 'coc-pyright', 'coc-sh', 'coc-git', 'coc-highlight', 'coc-cmake', 'coc-json', 'coc-yaml', 'coc-snippets', 'coc-vimlsp']

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nnoremap <silent> ? :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim', 'help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

inoremap <silent><expr> <C-e>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

let g:coc_snippet_next='<C-e>'

nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<Down>"
nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<Up>"
inoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Down>"
inoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Up>"
vnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<Down>"
vnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<Up>"

nmap <silent> <F12> <Plug>(coc-definition)
nmap <F2> <Plug>(coc-rename)

" vim-floaterm
let g:floaterm_keymap_new='<Leader>fn'
let g:floaterm_keymap_kill='<Leader>fk'
let g:floaterm_keymap_toggle='<Leader>ft'

" vim-better-whitespace
nnoremap <F3> :StripWhitespace<CR>

" vim-autoformat
noremap <F4> :Autoformat<CR>

let g:formatdef_autopep8='"autopep8 - --max-line-length=200"'

" todo-vim
nnoremap <F5> :TODOToggle<CR>

let g:todo_below=1
let g:todo_winheight=10
