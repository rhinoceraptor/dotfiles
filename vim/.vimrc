"---------------"
" Jack's .vimrc "
"---------------"

"------------------------"
" General editor settings"
"------------------------"

" Convenient whitespace marking
set list
set listchars=tab:>\ ,eol:¬
set lisp

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

" Omnisharp settings
filetype plugin on
set completeopt=longest,menuone,preview
set omnifunc=syntaxcomplete#Complete
let g:OmniSharp_selector_ui = 'fzf'  " Use fzf.vim
set previewheight=5
let g:ale_linters = { 'cs': ['OmniSharp'] }
let g:OmniSharp_highlight_types = 1
let g:OmniSharp_want_snippet=1
augroup omnisharp_commands
  autocmd!

  " When Syntastic is available but not ALE, automatic syntax check on events
  " (TextChanged requires Vim 7.4)
  " autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

  " Show type information automatically when the cursor stops moving
  autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

  " Update the highlighting whenever leaving insert mode
  autocmd InsertLeave *.cs call OmniSharp#HighlightBuffer()

  " Alternatively, use a mapping to refresh highlighting for the current buffer
  autocmd FileType cs nnoremap <buffer> <Leader>th :OmniSharpHighlightTypes<CR>

  " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
  autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
  autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
  autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

  " Finds members in the current buffer
  autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

  autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
  autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
  autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
  autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
  autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

  " Navigate up and down by method/property/field
  " autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
  " autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>
augroup END


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

let g:NERDTreeChDirMode = 2

let g:NERDTreeIndicatorMapCustom = {
  \ "Modified"  : "✹",
  \ "Staged"  : "✚",
  \ "Untracked" : "✭",
  \ "Renamed"   : "➜",
  \ "Unmerged"  : "═",
  \ "Deleted"   : "✖",
  \ "Dirty"   : "✗",
  \ "Clean"   : "✔︎",
  \ "Unknown"   : "?"
  \ }
"let g:NERDTreeIndicatorMapCustom = {
"  \ "Modified"  : "🔸 ",
"  \ "Staged"  : "✅  ",
"  \ "Untracked" : "🆕  ",
"  \ "Renamed"   : " ",
"  \ "Unmerged"  : "🆙  ",
"  \ "Deleted"   : "❌  ",
"  \ "Dirty"   : "*️⃣" ,
"  \ "Clean"   : "😀  ",
"  \ "Unknown"   : "❗️  "
"  \ }
"
" Save undo and swp in a convenient location
set undofile
set undodir=~/.vim/tmp/undo//
set dir=~/.vim/tmp/swp//

"-----"
"-----------------"
" Command aliases "
"-----------------"
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Wq wq
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev WQa wqa
cnoreabbrev Wqa wqa
cnoreabbrev Qa qa
cnoreabbrev QA qa

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
" Toggle mouse focus b/t vim and terminal emulator with F12
Bundle 'nvie/vim-togglemouse'
" File browser
Plugin 'scrooloose/nerdtree.git'
" Git integration for Nerd Tree
Plugin 'Xuyuanp/nerdtree-git-plugin'
" Trailing whitespace is evil!
Bundle 'ntpeters/vim-better-whitespace'
" Status line
Plugin 'itchyny/lightline.vim'
" Tmux/Vim helper
Plugin 'christoomey/vim-tmux-navigator'
" Editor Config
Plugin 'editorconfig/editorconfig-vim'
" FZF - fuzzy file finder
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" Ack
Plugin 'mileszs/ack.vim'

"---------------------------"
" Syntax highlight packages "
"---------------------------"
Plugin 'kchmck/vim-coffee-script'
" Tmux config files
Plugin 'tmux-plugins/vim-tmux'
" ES6
Plugin 'isRuslan/vim-es6'
" Markdown
Plugin 'tpope/vim-markdown'
" Emoji
Bundle 'junegunn/vim-emoji'
" Docker
Bundle 'ekalinin/Dockerfile.vim'
" Syntax linting
Plugin 'w0rp/ale'

Bundle 'OmniSharp/omnisharp-vim'
Plugin 'tpope/vim-dispatch'
Plugin 'vim-syntastic/syntastic'
Plugin 'leafgarland/typescript-vim'
Plugin 'lervag/vimtex'

call vundle#end()

" FZF "
"-----"
set rtp+=~/.fzf
nnoremap <C-p> :FZF -m<cr>


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


