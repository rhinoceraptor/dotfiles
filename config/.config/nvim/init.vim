"----------------------"
" Jack's neovim config "
"----------------------"

set lisp
set list
set listchars=tab:>\ ,eol:¬

" Enable mouse
set mouse=a
" Set tab display width to 2 spaces
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

set pastetoggle=<F2>
setlocal shiftwidth=2
set cursorline

set shell=bash
set linebreak

filetype indent on

" Save the file scroll location
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" Fix time out length to not wait excessively long switching to normal mode
"set timeoutlen=1000 ttimeoutlen=0

" Show possible files to edit using :e tab completion
set wildmenu

cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

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
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
nmap <silent> <F3> :NERDTreeToggle<CR>
set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*,*node_modules*
let NERDTreeRespectWildIgnore=1
let NERDTreeHighlightCursorline = 0

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
nnoremap <C-p> :GFiles<cr>

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

" Theming
Plug 'junegunn/seoul256.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git support
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'albfan/nerdtree-git-plugin'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'christoomey/vim-tmux-navigator'

" Language support
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-markdown'
Plug 'junegunn/vim-emoji'
Plug 'ekalinin/Dockerfile.vim'
Plug 'tmux-plugins/vim-tmux'
Plug 'pangloss/vim-javascript'
Plug 'https://github.com/mxw/vim-jsx'

Plug 'bronson/vim-crosshairs'

" Autocomplete plugins
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'wokalski/autocomplete-flow'
" Plug 'Shougo/neosnippet'
" Plug 'Shougo/neosnippet-snippets'
" Plug 'wellle/tmux-complete.vim'

call plug#end()

" let g:deoplete#enable_at_startup = 1
" let g:neosnippet#enable_completed_snippet = 1

syntax enable

"silent! if emoji#available()
"  let g:gitgutter_sign_added = emoji#for('white_check_mark')
"  let g:gitgutter_sign_modified = emoji#for('large_orange_diamond')
"  let g:gitgutter_sign_removed = emoji#for('x')
"  let g:gitgutter_sign_modified_removed = emoji#for('warning')
"endif

let airline_theme="base16_mocha"
let g:seoul256_background = 235
colo seoul256

let g:airline#extensions#tabline#enabled = 1
" let g:indentLine_showFirstIndentLevel = 1
" let g:indentLine_setColors = 0
" let g:indentLine_char = '│'

