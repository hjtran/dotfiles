" hjtran vimrc


" tabcomplete
set wildmode=longest,list,full
set wildmenu

" make vim distro-independent
set nocompatible 

" base indent on filetype
filetype indent plugin on 

" enable syntax highlighting
syntax on	

" enable line numbers
set number	

" Better command-line completion
set wildmenu

" Highlight searches
set hlsearch

" Enable smartcase search
set ignorecase
set smartcase

" Display status line
set laststatus=2

" Raise dialogue for confirming unsaved changes
set confirm

"" Indentation Options
" New lines will have = indent for no filetype-specific files
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

" Enable Pathogen plugin
execute pathogen#infect()

""" Keybindings
let mapleader=","
nnoremap <C-t> :tabnew<CR>
nnoremap <Leader>n :tabnext<CR>
nnoremap <Leader>m :tabprevious<CR>
autocmd FileType python nnoremap <Leader>r :w<CR>:! python %<CR>
autocmd FileType python nnoremap <Leader>s :! python<CR>
autocmd FileType lua nnoremap <Leader>r :w<CR>:! th %<CR>
autocmd FileType lua nnoremap <Leader>s :! th<CR>
autocmd FileType julia nnoremap <Leader>r :w<CR>:! julia %<CR>
autocmd FileType julia nnoremap <Leader>s :! julia<CR>
nnoremap <Leader>b :shell<CR>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" W and Q do the same as w and q
command W w
command Q q

" rebind ^ and $ to 0 and W
nnoremap B ^
nnoremap E $
nnoremap ^ <nop>
nnoremap $ <nop>

" Text expansions
iab pydb import pdb; pdb.set_trace()

" Add _ as word boundary
set iskeyword-=_

" visual line to show where python lines should end
autocmd FileType python setlocal cc=80

" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pyflakes']

set backspace=indent,eol,start
