zmodload zsh/zprof

unsetopt BG_NICE
export TERM='xterm-256color'

export EDITOR=nvim

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

PATH="$HOME/.zsh/scripts/node:$PATH"
PATH="$HOME/.zsh/scripts/virtualbox:$PATH"
PATH="$HOME/bin:$PATH"
PATH="$HOME/.npm-packages/bin:$PATH"

if [[ $(uname -a) =~ .*"Darwin".* ]]; then
  alias python="python3"
  PATH="$HOME/Library/Python/3.9/bin:$PATH"
fi

export PAGER=less
export DISPLAY=:0

export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'

autoload -U promptinit; promptinit

source $HOME/.zsh/aliases.zsh
source $HOME/.zsh/zplug/init.zsh

source_directory () {
  for alias in $1/*.zsh(N); do source $alias; done
}

source_directory $HOME/.zsh/aliases/node
source_directory $HOME/.zsh/aliases/work

PATH="$HOME/.pyenv/bin:$PATH"

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

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

