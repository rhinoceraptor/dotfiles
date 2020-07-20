#!/usr/bin/env bash

# Check if zsh/git/tmux/stow/nvim/curl already installed
if   ! type "zsh"  &> /dev/null; then echo "Install zsh!";  exit 1
elif ! type "git"  &> /dev/null; then echo "Install git!";  exit 1
elif ! type "tmux" &> /dev/null; then echo "Install tmux!"; exit 1
elif ! type "nvim" &> /dev/null; then echo "Install nvim!"; exit 1
elif ! type "curl" &> /dev/null; then echo "Install curl!"; exit 1
elif ! type "curl" &> /dev/null; then echo "Install curl!"; exit 1
fi

exit 1
# Stow config directories
stow zsh
stow git
stow tmux
stow config

# Create .vim directories
mkdir -p ~/.vim/bundle/
mkdir -p ~/.vim/tmp/swp
mkdir -p ~/.vim/tmp/undo

# Clone various package managers from git
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone https://github.com/zplug/zplug ~/.zsh/.zplug
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install vim packages
nvim +PlugInstall

