zmodload zsh/zprof
export SHELL="/usr/bin/zsh"

unsetopt BG_NICE
export TERM='xterm-256color'

setopt correctall

HISTFILE="$HOME/.zsh_history"
HISTSIZE=200000
HISTSAVE=200000
SAVEHIST=HISTSIZE
DISABLE_CORRECTION="true"

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

bindkey -v
export KEYTIMEOUT=1
bindkey '^w' backward-kill-word
bindkey '^p' up-history
bindkey '^n' down-history

KEYTIMEOUT=1

clear-screen() clear
bindkey '^o' clear-screen
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char
zle -N history-substring-search-up
zle -N history-substring-search-down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
zle -N history-substring-search-up
zle -N history-substring-search-down

PATH="$HOME/.zsh/scripts/:$PATH"
PATH="$HOME/scripts/:$PATH"
PATH="/opt/local/bin/:$PATH"

export GOPATH=$HOME/git/go
export PAGER=less
export DISPLAY=:0

autoload -U promptinit; promptinit

source ~/.zsh/aliases
source ~/.zsh/zplug/init.zsh

zplug "junegunn/fzf-bin", \
  from:gh-r, \
  as:command, \
  rename-to:fzf

zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", from:github
zplug "zsh-users/zsh-syntax-highlighting", from:github
zplug "zsh-users/zsh-history-substring-search", from:github
zplug "zsh-users/zsh-completions", from:github

zplug load


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
