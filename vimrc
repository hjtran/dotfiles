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
" Unlist quickfix buffers so we dont cycle through them
augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
augroup END
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

""" Commands
command! ProjectFiles execute 'FZF' s:FindGitRoot()
command! FZFPyDefs call fzf#run({
                    \'down':'40%',
                    \'source': PyDefs(),
                    \'sink': function('JumpTo')})

""" Keybindings
let mapleader=","
nnoremap <C-t> :tabnew<CR>
autocmd FileType python nnoremap <Leader>r :w<CR>:! python %<CR>
autocmd FileType python nnoremap <Leader>s :! python<CR>
nnoremap <Leader>n :bnext<CR>
nnoremap <Leader>m :bprevious<CR>
nnoremap <Leader>d :call append(line('.'), CreateSphinxStub())<CR>
" Bindings for moving between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" These bindings require plugins
nnoremap <Leader>c :Gcommit -a<CR>
nnoremap <Leader>e :ProjectFiles<CR>
nnoremap <Leader>j :FZFPyDefs<CR>

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
" disable shift-k
map <S-k> <Nop>

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
function! s:FindGitRoot()
    return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

function! ParseArgs()
    let signature=getline('.')
    let signature=substitute(signature,'^.*(','','')
    let signature=substitute(signature,').*$','','')
    let raw_args=split(signature,',')
    let special_words=['self','*args','**kwargs']
    let args=[]
    for arg in raw_args
        if (index(special_words,arg) == -1)
            let arg=substitute(arg,' ','','')
            let arg=substitute(arg,'=.*$','','')
            call add(args, arg)
        endif
    endfor
    return args
endfunction

function! CreateSphinxStub()
    let spaces=repeat(' ',indent('.')+4)
    let args=ParseArgs()
    let docstr=[spaces.'"""']
    for arg in args
        call add(docstr,spaces.':param '.arg.': ')
        call add(docstr,spaces.':type  '.arg.': ')
        call add(docstr,'')
    endfor
    call add(docstr,spaces.':return: ')
    call add(docstr,spaces.':rtype : ')
    call add(docstr,spaces.'"""')
    return docstr
endfunction

function! ParseMatch(list,match)
    " For use with PyDefs()
    " Parses a match into a list and adds it to a:list
    " match_eles will be of the form:
    "   [ Num of White Spaces, class/def, class/method name, line number ]
    let match_eles=[len(matchstr(a:match,'^\s*'))]
    let match_eles=match_eles + matchlist(a:match,'\v^\W*(class|def) ([^:(]+).*$')[1:2]
    let match_eles=match_eles + [line('.')]
    call add(a:list,match_eles)
endfun

function! JumpTo(line)
    " For use with PyDefs()
    execute split(a:line)[0]
endfun

function! PyDefs()
    " Parses the current buffer for Python class, function,
    " and method declarations and returns a list with information
    " about each declaration.
    " Currently only supports one level of nesting
    let list=[]
    %g/\v^\W*(class|def)/call ParseMatch(list,getline("."))
    let defs=[]
    let parent=""
    for item in list
        try
            let offset=item[0]
            let name=item[2]
            let linenum=item[3]
            if offset/4 == 0
                let parent=name
                call add(defs,join([linenum,name]))
            else
                let method=join([parent,name],'.')
                let myline=join([linenum,method])
                call add(defs,myline)
            endif
        catch
            echo item
        endtry
    endfor
    return defs
endfun
