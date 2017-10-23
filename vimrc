""" hjtran vimrc

""" General settings
" :e opens a new buffer without closing the current buffer
set hidden
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
" Highlight searches
set hlsearch
" Enable smartcase search
set ignorecase
set smartcase
" Display status line
set laststatus=2
" Raise dialogue for confirming unsaved changes
set confirm
" Set search to move term into middle of screen
set so=7
" open to line the file was closed on
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
" Enable Pathogen plugin manager
execute pathogen#infect()
" Add _ as word boundary
set iskeyword-=_
" visual line to show where python lines should end
autocmd FileType python setlocal cc=80

""" Indentation Options
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set backspace=indent,eol,start

""" Text expansions
iab pydb import pdb; pdb.set_trace()
iab qtpdb import pdb; from schrodinger.Qt import QtCore; QtCore.pyqtRemoveInputHook(); pdb.set_trace()
iab impph from schrodinger.profilehooks import profile, timecall

""" Keybindings
let mapleader=","
nnoremap <C-t> :tabnew<CR>
autocmd FileType python nnoremap <Leader>r :w<CR>:! python %<CR>
autocmd FileType python nnoremap <Leader>s :! python<CR>
nnoremap <Leader>n :bnext<CR>
nnoremap <Leader>m :bprevious<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" These bindings require plugins
nnoremap <Leader>c :Gcommit -a<CR>
nnoremap <Leader>e :ProjectFiles<CR>
command! ProjectFiles execute 'FZF' s:find_git_root()

""" Rebindings
" W and Q do the same as w and q
command W w
command Q q
" rebind ^ and $ to 0 and W
nnoremap B ^
nnoremap E $
nnoremap ^ <nop>
nnoremap $ <nop>
" move vertically by visual line
nnoremap j gj
nnoremap k gk

""" Plugin settings
" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pyflakes']
" airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


""" Functions
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
