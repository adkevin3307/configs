let data_dir = '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo ' . data_dir . '/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-python/python-syntax'
Plug 'vim-autoformat/vim-autoformat'
Plug 'ntpeters/vim-better-whitespace'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

Plug 'gelguy/wilder.nvim'
Plug 'djoshea/vim-autoread'
Plug 'liuchengxu/vim-clap', { 'do': { -> clap#installer#force_download() } }

Plug 'sillybun/vim-repl'

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

set encoding=utf-8
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=100
set shortmess+=c
set signcolumn=yes

nnoremap <C-h> <Left>
nnoremap <C-l> <Right>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

nnoremap <Leader>n :nohl<CR>

" onedark
colorscheme onedark
unlet g:terminal_ansi_colors

set cursorline
highlight CursorLine ctermbg=None
highlight CursorLineNR ctermfg=208
highlight LineNr ctermbg=None ctermfg=245

highlight Normal ctermbg=None
highlight Terminal ctermbg=None
highlight Visual ctermbg=darkgray
highlight SignColumn ctermbg=None

" vim-airline
let g:airline_theme='onedark'
let g:airline#extensions#scrollbar#enabled=0
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline#extensions#keymap#enabled=1
let g:airline#extensions#tabline#show_buffers=1
let g:airline#entensions#hunks#enabled=1
let g:airline#extensions#hunks#coc_git=1

" indentLine
let g:indentLine_char='|'
let g:indentLine_fileTypeExclude=['dockerfile', 'tex', 'json', 'markdown']

" nerdcommenter
let g:NERDSpaceDelims=1
let g:NERDToggleCheckAllLines=1
let g:NERDCreateDefaultMappings=0
autocmd FileType python let g:NERDSpaceDelims=0
autocmd FileType yaml let g:NERDSpaceDelims=1

nnoremap <silent> <Leader>cc :call nerdcommenter#Comment("n", "Toggle")<CR>
vnoremap <silent> <Leader>cc :call nerdcommenter#Comment("n", "Toggle")<CR>

" python-syntax
let g:python_highlight_all=1

" vim-autoformat
noremap <F4> :Autoformat<CR>

let g:formatters_python=['black']
let g:formatdef_black='"black - --line-length=200 --skip-string-normalization"'

" coc.nvim
let g:coc_global_extensions=['coc-clangd', 'coc-pyright', 'coc-sh', 'coc-git', 'coc-highlight', 'coc-cmake', 'coc-json', 'coc-yaml', 'coc-snippets', 'coc-vimlsp']

inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

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

nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<Down>"
nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<Up>"
inoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Down>"
inoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Up>"
vnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<Down>"
vnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<Up>"

nmap <silent> <F12> <Plug>(coc-definition)
nmap <F2> <Plug>(coc-rename)

nmap <Leader>gp <Plug>(coc-git-prevchunk)
nmap <Leader>gn <Plug>(coc-git-nextchunk)
nmap <Leader>gg <Plug>(coc-git-chunkinfo)

" vim-doge
let g:doge_doc_standard_python='numpy'
let g:doge_comment_jump_modes=['n', 's']

" wilder.nvim
call wilder#setup({'modes': [':', '/', '?']})

call wilder#set_option('pipeline', [
            \   wilder#branch(
            \     wilder#cmdline_pipeline(),
            \     wilder#search_pipeline(),
            \   ),
            \ ])

call wilder#set_option('renderer', wilder#popupmenu_renderer({
            \ 'highlighter': wilder#basic_highlighter(),
            \ 'highlights': {
            \   'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}]),
            \ },
            \ }))

" vim-clap
nnoremap <silent> <space><space> :Clap files<CR>
nnoremap <silent> <C-f> :Clap filer<CR>
nnoremap <silent> <C-g> :Clap bcommits<CR>
nnoremap <silent> <C-y> :Clap yanks<CR>
nnoremap <silent> <C-p> :Clap buffers<CR>
nnoremap <silent> <C-t> :silent! Clap tags<CR>
nnoremap <silent> <C-q> :bdelete<CR>
nnoremap <silent> <Leader>f :Clap dumb_jump<CR>

inoremap <silent> <C-f> <ESC>:Clap filer<CR>
inoremap <silent> <C-p> <ESC>:Clap buffers<CR>
inoremap <silent> <C-t> <ESC>:silent! Clap tags<CR>

" vim-repl
let g:repl_position=3
let g:repl_console_name='REPL'
let g:repl_python_auto_import=0
let g:sendtorepl_invoke_key='<Leader>r'
let g:repl_program={'python': 'bpython', 'default': 'zsh'}

nnoremap <Leader>t :REPLToggle<CR>
nnoremap <Leader>a :REPLSendAll<CR>
nnoremap <Leader>s :REPLSendSession<CR>
