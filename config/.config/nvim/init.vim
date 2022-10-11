"----------------------"
" Jack's neovim config "
"----------------------"

set lisp
set list
set listchars=tab:>\ ,eol:¬
set mouse=a
set expandtab
set incsearch
set hlsearch
set laststatus=2
set matchtime=1
set nocompatible
set number
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set smartindent
set smarttab
set omnifunc=syntaxcomplete#Complete
set scrolloff=10
set showmatch
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set ttyfast
set lazyredraw
set backspace=2
set pastetoggle=<F2>
setlocal shiftwidth=2
set cursorline
set shell=zsh
set linebreak
set breakindent
let break_prefix='>>  '
let &showbreak=break_prefix
set wildmenu
set splitbelow
set splitright
set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*,*node_modules*
set colorcolumn=80
set wrap
set redrawtime=10000

filetype indent on

" Save the file scroll location
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" Don't get rid of selection when indenting
xnoremap <  <gv
xnoremap >  >gv

"-------------------"
" NERDTree settings "
"-------------------"
" Show NERDTree automatically in the pwd if vim called with no arguments
function! StartUp()
  if 0 == argc()
    NERDTree
  end
endfunction
autocmd VimEnter * call StartUp()
" let NERDTreeShowHidden=1
let NERDTreeIgnore=["^\.git$"]
" let NERDTreeMinimalUI = 1
nmap <silent> <F3> :NERDTreeToggle<CR>
" let NERDTreeRespectWildIgnore=1
let NERDTreeHighlightCursorline = 0
let NERDTreeShowHidden=1

" Turn off search highlight - backslash space
nnoremap <leader><space> :nohlsearch<CR>

" Resize splits
nnoremap <C-w>k 5<C-w>-
nnoremap <C-w>j 5<C-w>+
nnoremap <C-w>h 5<C-w><
nnoremap <C-w>l 5<C-w>>

" Automatically strip trailing whitespace on write
autocmd BufWritePre * :%s/\s\+$//e

let g:NERDTreeChDirMode = 2

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "+",
    \ "Untracked" : "*",
    \ "Renamed"   : "➡",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" Save undo and swp in a convenient location
set undofile
set undodir=~/.vim/tmp/undo//
set dir=~/.vim/tmp/swp//

"-----"
" FZF "
"-----"
" set rtp+=~/.fzf
nnoremap <C-p> :GFiles<CR>

nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'


"-----------------"
" Command aliases "
"-----------------"
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev WQa wqa
cnoreabbrev Wqa wqa
cnoreabbrev Qa qa
cnoreabbrev QA qa
cnoreabbrev Sp sp
cnoreabbrev Vsp vsp

"------"
" Tmux "
"------"
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

call plug#begin('~/.local/nvim/plugged')

" Theme plugins
Plug 'wadackel/vim-dogrun'
Plug 'itchyny/lightline.vim'
" Plug 'cormacrelf/vim-colors-github'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" Editing plugins
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'

" Language support plugins
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-markdown'
Plug 'junegunn/vim-emoji'
Plug 'ekalinin/Dockerfile.vim'
Plug 'tmux-plugins/vim-tmux'
Plug 'junegunn/goyo.vim'
" Plug 'pangloss/vim-javascript'
" Plug 'https://github.com/mxw/vim-jsx'
" Plug 'bronson/vim-crosshairs'
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'hwayne/tla.vim'
" Plug 'lorin/vim-tlaplus'
Plug 'davidoc/taskpaper.vim'
" Plug 'hwayne/tla.vim'
Plug 'hashivim/vim-terraform'

call plug#end()

syntax enable

" Theme configuration
set termguicolors
colorscheme dogrun
let g:lightline = {
      \ 'colorscheme': 'dogrun',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ],
      \ }
      \ }
" set background=light
" colorscheme github

" let g:airline_theme='github'
let g:airline#extensions#tabline#enabled = 1
