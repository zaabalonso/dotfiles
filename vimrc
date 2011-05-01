set nocompatible
filetype on
filetype plugin on

" statusline
set statusline=%F%m%r%h%w\ %y\ [lines=%L]\ [x=%04v][y=%04l][%p%%]
set laststatus=2

" colors
syntax enable 
set t_Co=256
colorscheme oceanblack 
    "colors darkblue
    "colorscheme mustang 
    "colorscheme symfony 
    "colorscheme clouds-midnight 
    "colorscheme wombat256  

" tabspacing
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

set ttyfast
set noswapfile
set nobackup
set nowritebackup
set enc=utf-8
set fencs=utf-8
set visualbell t_vb=
set history=1000
set undolevels=1000
set wildmenu
set winwidth=300
set winminwidth=50
set tabpagemax=80
set showcmd " show partial commands in status line and selected characters/lines in visual mode

" search options
set nohls " hlsearch if want highlighting
set incsearch
set ignorecase
set smartcase

" wipe out highlights if using hlsearch
nnoremap <leader><space> :noh<cr>

" fix search regex 
nnoremap / /\v
vnoremap / /\v

" search a highlighted term
vmap  / y/<C-R>=substitute(escape(@", '\\/.*$^~[]'), "\n", "\\\\n", "g")<CR><CR>

" remap tab key to match bracket pairs
nnoremap <tab> %
vnoremap <tab> %

" remap leader to comma 
let mapleader=","

" map jj to escape key
inoremap jj <ESC>

" commenting in visual mode
"vmap  o  :s/^/#/<CR>    
"vmap  O  :s/^#//<CR>   
vmap  o  :call NERDComment(1, 'toggle')<CR>
vmap  O  :call NERDComment(1, 'toggle')<CR>

" yankring history
"silent execute '!mkdir -p $HOME/.vim/tmp/yankring'
"let g:yankring_history_dir = '$HOME/.vim/tmp/yankring'

" open tag in new window
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" tab navigation 
map <S-h> gT
map <S-l> gt
map <C-h> gT
map <C-l> gt
nmap <S-t> :tabnew<CR>

" shift + tab to un-indent
imap <S-Tab> <C-o><<

" find out who's to blame for the current line
vmap <leader>b :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR> 
vmap <leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" strip trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Yank from the cursor to the end of the line, to be consistent with C and D
nnoremap Y y$

"press S to replace the current word with the last-yanked text
map S diw"0P

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" let w!! write a file with root priv
cmap w!! w !sudo tee % >/dev/null

" use command-t plugin with ,t
nmap <silent> <leader>t <Esc>:tabe<CR>:CommandT<CR>

" use ,W to strip all trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" PHP Specific
autocmd FileType php let php_sql_query=1 "sql-syntax highlighting
autocmd FileType php let php_htmlInStrings=1 "highlights html inside of php strings
" automagically folds functions & methods
"autocmd FileType php let php_folding=1

" Perl
let perl_extended_vars=1

"""""""""""""""""
" function keys
"""""""""""""""""

" fuck you, help key.
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
nnoremap ; :

" list all previously yanked text with <F3>
nnoremap <silent> <F3> :YRShow<cr>
inoremap <silent> <F3> <ESC>:YRShow<cr>

" toggle nerd tree with <F2>
map <F2> :NERDTreeToggle<CR>

" ,w to open a split window and switch to it
nnoremap <leader>w <C-w>v<C-w>l
" use <F6> to cycle through split windows
nnoremap <F6> <C-W>w
" <Shift>+<F6> to cycle backwards
nnoremap <S-F6> <C-W>W

" pastetoggle (sane indentation on pastes)
set pastetoggle=<F12> 

" function to loop through a specified path and include each tag file
function! BuildTagsFromPath()
python << EOF
import os
import vim

tags = ''
tagpath = "%s/%s" % (os.environ['HOME'], '.vim/tags')

for file in os.listdir(tagpath):
    if (file != 'README'):
        tags += "%s/%s," % (tagpath, file)

cmdsettags = "set tags=%s" % tags
vim.command(cmdsettags)
EOF
endfunction

call BuildTagsFromPath()