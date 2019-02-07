"---------------"
" Jack's .vimrc "
"---------------"

"------------------------"
" General editor settings"
"------------------------"

" Convenient whitespace marking
set lisp
set list
set listchars=tab:>\ ,eol:¬

" Enable mouse
set mouse=a
set ttymouse=xterm2
"Set tab display width to 2 spaces
set tabstop=2
set expandtab

" Search preferences
set incsearch
set hlsearch

set laststatus=2
set matchtime=1
set nocompatible

" Line numbers
set number

" General indent settings
set shiftwidth=8
set tabstop=2
set smartindent
set shiftwidth=2

set omnifunc=syntaxcomplete#Complete
set scrolloff=10
set showmatch
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set ttyfast
set lazyredraw

set backspace=2

" Press F2 to paste without messing up indentation
set pastetoggle=<F2>
setlocal shiftwidth=2

"set clipboard=unnamedplus
" Y yanks to system clipboard
"vnoremap <C-c> :w !xsel --clipboard<CR><CR>

" Look for indent style in ~/.vim/indent/
filetype indent on

" Save the file scroll location
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" Fix time out length to not wait excessively long switching to normal mode
set timeoutlen=1000 ttimeoutlen=0

" Show possible files to edit using :e tab completion
set wildmenu

" Use :sudow to write use sudo to write a file
cnoremap sudow w !sudo tee % >/dev/null

" highlight last inserted text
nnoremap gV `[v`]

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
let NERDTreeShowHidden=1

" Bookmarks
let NERDTreeShowBookmarks=1
if !empty($NERDTREE_BOOKMARKS)
  if filereadable($NERDTREE_BOOKMARKS)
    let g:NERDTreeBookmarksFile = $NERDTREE_BOOKMARKS
  endif
endif
nmap <silent> <F3> :NERDTreeToggle<CR>

set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*,*node_modules*
let NERDTreeRespectWildIgnore=1

" Turn off search highlight - backslash space
nnoremap <leader><space> :nohlsearch<CR>

" Turn off skipping folded lines vertically
nnoremap j gj
nnoremap k gk

" Show a ruler at 80 chars
set colorcolumn=80
" Auto resize splits after window resize
augroup Misc
    autocmd!
    autocmd VimResized * exe "normal! \<c-w>="
augroup END

" Open splits the right way
set splitbelow
set splitright

" Resize splits
nnoremap <C-w>k 5<C-w>-
nnoremap <C-w>j 5<C-w>+
nnoremap <C-w>h 5<C-w><
nnoremap <C-w>l 5<C-w>>

" Automatically strip trailing whitespace on write
autocmd BufWritePre * :%s/\s\+$//e

let g:NERDTreeChDirMode       = 2

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "➕",
    \ "Untracked" : "⭐",
    \ "Renamed"   : "➡",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "❓"
    \ }
"let g:NERDTreeIndicatorMapCustom = {
"    \ "Modified"  : "🔸 ",
"    \ "Staged"    : "✅  ",
"    \ "Untracked" : "🆕  ",
"    \ "Renamed"   : " ",
"    \ "Unmerged"  : "🆙  ",
"    \ "Deleted"   : "❌  ",
"    \ "Dirty"     : "*️⃣" ,
"    \ "Clean"     : "😀  ",
"    \ "Unknown"   : "❗️  "
"    \ }
"
" Save undo and swp in a convenient location
set undofile
set undodir=~/.vim/tmp/undo//
set dir=~/.vim/tmp/swp//

"-----"
" FZF "
"-----"
set rtp+=~/.fzf
nnoremap <C-p> :FZF -m<cr>
" nnoremap <C-P> :Ag<cr>
"let $FZF_DEFAULT_COMMAND='ag -g ""'
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

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

xmap ga <Plug>(EasyAlign)

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"-----------------"
" Vundle settings "
"-----------------"
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Seoul 256 color scheme
Plugin 'junegunn/seoul256.vim'
"-------------------------"
" General editor packages "
"-------------------------"
" Git integration
Plugin 'tpope/vim-fugitive'
" Git gutter
Plugin 'airblade/vim-gitgutter'
" Save sessions
Plugin 'tpope/vim-obsession'
" Toggle mouse focus b/t vim and terminal emulator with F12
Bundle 'nvie/vim-togglemouse'
" File browser
Plugin 'scrooloose/nerdtree.git'
" Git integration for Nerd Tree
Plugin 'albfan/nerdtree-git-plugin'
" Trailing whitespace is evil!
Bundle 'ntpeters/vim-better-whitespace'
" Status line
Plugin 'itchyny/lightline.vim'
" Tmux/Vim helper
Plugin 'christoomey/vim-tmux-navigator'
" Editor Config
Plugin 'editorconfig/editorconfig-vim'
" FZF
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'mileszs/ack.vim'

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
Plugin 'isRuslan/vim-es6'
" Jade templates
Plugin 'digitaltoad/vim-jade'
" Handlebars templates
Plugin 'mustache/vim-mustache-handlebars'
" Stylus
Plugin 'wavded/vim-stylus'
" Ansible
Bundle 'chase/vim-ansible-yaml'
" Markdown
Plugin 'tpope/vim-markdown'
" Emoji
Bundle 'junegunn/vim-emoji'
" Swift
Bundle 'keith/swift.vim'
" Docker
Bundle 'ekalinin/Dockerfile.vim'
" ANTLR
Bundle 'rollxx/vim-antlr'
" Racket
Bundle 'wlangstroth/vim-racket'
Bundle 'hashivim/vim-vagrant'

Bundle 'dag/vim-fish'
" JSX
Bundle 'pangloss/vim-javascript'
Bundle 'https://github.com/mxw/vim-jsx'
Bundle 'OmniSharp/omnisharp-vim'
Bundle 'junegunn/vim-easy-align'
call vundle#end()

"----------------"
" Color settings "
"----------------"
syntax enable
set background=dark
let g:lightline = {
  \ 'colorscheme': 'seoul256',
  \ }
colo seoul256
let g:seoul256_background = 256

" : Git Gutter emoji config
silent! if emoji#available()
  let g:gitgutter_sign_added = emoji#for('white_check_mark')
  let g:gitgutter_sign_modified = emoji#for('large_orange_diamond')
  let g:gitgutter_sign_removed = emoji#for('x')
  let g:gitgutter_sign_modified_removed = emoji#for('warning')
endif


set formatoptions+=r
