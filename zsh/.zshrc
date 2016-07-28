# Colors
export TERM='screen-256color'

# ZSH completion
# autoload -U compinit
# compinit

# Correction
setopt correctall

# ZSH history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=200000
HISTSAVE=200000
SAVEHIST=HISTSIZE

DISABLE_CORRECTION="true"

# Various ZSH settings
setopt BANG_HIST
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt noflowcontrol

# Use vi mode in ZLE
bindkey -v
export KEYTIMEOUT=1
bindkey '^w' backward-kill-word
bindkey '^p' up-history
bindkey '^n' down-history

# Speed up key sequences
KEYTIMEOUT=1

# Custom keybindings
clear-screen() clear
bindkey '^o' clear-screen
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# Path stuff
# Load Ruby paths
#PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
#export NVM_DIR="/home/jack/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

fpath=( ~/.zsh/scripts "${fpath[@]}" )

# NERDTree bookmarks
export NERDTREE_BOOKMARKS="~/.vim/.NERDTreeBookmarks"

export PAGER=less

# Load aliases
source ~/.zsh/aliases

# Load antigen
source ~/.zsh/antigen/antigen.zsh

# Antigen (oh-my-zsh) packages
antigen-bundle extract
antigen-bundle git
#antigen-bundle pip
antigen-bundle tmuxinator
antigen-bundle grunt
#antigen-bundle gulp
# antigen-bundle npm
# antigen-bundle nvm
# antigen-bundle brew
# antigen-bundle brew
# antigen-bundle brew-cask
antigen bundle felixr/docker-zsh-completion
antigen bundle akoenig/npm-run.plugin.zsh

# syntax highlighting must be last to prevent pwd
# indicator from going off screen
antigen bundle b4b4r07/zsh-vimode-visual
antigen bundle mafredri/zsh-async
antigen bundle rhinoceraptor/pure
antigen bundle zsh-users/zsh-syntax-highlighting
antigen-bundle zsh-users/zsh-history-substring-search
antigen-bundle zsh-users/zsh-completions

antigen apply
