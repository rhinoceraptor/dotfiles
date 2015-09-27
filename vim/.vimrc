"---------------"
" Jack's .vimrc "
"---------------"

"------------------------"
" General editor settings"
"------------------------"
"
" Convenient whitespace marking
set list
set listchars=tab:>\ ,eol:¬

" Enable mouse
set mouse=a

"Set tab display width to 2 spaces
set tabstop=2

set expandtab
set hlsearch
set laststatus=2
set matchtime=1
set mouse=a
set nocompatible
" Line numbers
set number
set omnifunc=syntaxcomplete#Complete
set scrolloff=10
set shiftwidth=8
set showmatch
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set tabstop=4
set ttyfast
set ttymouse=xterm2
set smartindent
set shiftwidth=2
set lazyredraw
set incsearch
" Press F2 to paste without messing up indentation
set pastetoggle=<F2>

setlocal shiftwidth=4

" Fix time out length to not wait excessively long switching to normal mode
set timeoutlen=1000 ttimeoutlen=0

" Use :sudow to write use sudo to write a file
cnoremap sudow w !sudo tee % >/dev/null

" Show NERDTree automatically in the pwd if vim called with no arguments
function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction
autocmd VimEnter * call StartUp()
let NERDTreeShowHidden=1

" Turn off search highlight - backslash space
nnoremap <leader><space> :nohlsearch<CR>
" Turn off skipping folded lines vertically
nnoremap j gj
nnoremap k gk

" Auto resize splits after window resize
augroup Misc
    autocmd!
    autocmd VimResized * exe "normal! \<c-w>="
augroup END

" Automatically strip trailing whitespace on write
autocmd BufWritePre * :%s/\s\+$//e

" Save undo and swp in a convenient location
set undofile
set undodir=~/.vim/tmp/undo//
set dir=~/.vim/tmp/swp//

"-----------------"
" Command aliases "
"-----------------"
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Wq wq
cnoreabbrev WQ wq

"-----------------"
" Vundle settings "
"-----------------"
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" Material design theme
Bundle 'NLKNguyen/papercolor-theme'

"-------------------------"
" General editor packages "
"-------------------------"
" Git integration
Plugin 'tpope/vim-fugitive'
" Toggle mouse focus b/t vim and terminal emulator with F12
Bundle 'nvie/vim-togglemouse'
" Syntax checker
Bundle 'scrooloose/syntastic'
" File browser
Plugin 'scrooloose/nerdtree.git'
" Trailing whitespace is evil!
Bundle 'ntpeters/vim-better-whitespace'
" Status line
Plugin 'itchyny/lightline.vim'
" Tmux/Vim helper
Plugin 'christoomey/vim-tmux-navigator'

"-----------------------"
" Autocomplete packages "
"-----------------------"
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}

"---------------------------"
" Syntax highlight packages "
"---------------------------"
Plugin 'kchmck/vim-coffee-script'
" Tmux config files
Plugin 'tmux-plugins/vim-tmux'
" ES6
Plugin 'othree/yajs.vim'


call vundle#end()
"----------------"
" Color settings "
"----------------"
syntax enable
set background=dark
colorscheme PaperColor
let g:lightline = { 'colorscheme': 'PaperColor' }


