#!/usr/bin/env zsh

UNAME=$(uname)
if [[ "$UNAME" == "Darwin" ]]; then
  alias copy="pbcopy"
  alias ls="gls --color=auto --group-directories-first -lAh"
elif [[ "$UNAME" == "Linux" ]]; then
  alias copy="xclip -selection c"
  alias ls="ls --color=auto --group-directories-first -lAh"
  alias open="xdg-open >/dev/null 2>&1"
fi

# Typos
alias vim="nvim"
alias ivm="nvim"
alias sl="ls"

# Network related convience aliases
alias my-ip="curl ifconfig.me -s"
alias copy-my-ip="my-ip | copy"
alias netscan="arp-scan --interface=en0 --localnet"

# Quickly generate UUIDs
alias getuuid='uuidgen | tr "[:upper:]" "[:lower:]" | tr -d "\n"'
alias copyuuid="getuuid | copy"

