#!/usr/bin/env bash

# Stow config directories
stow zsh
stow vim
stow git
stow tmux
stow config

# Create .vim directories
mkdir -p ~/.vim/bundle/
mkdir -p ~/.vim/tmp/swp
mkdir -p ~/.vim/tmp/undo

# Clone various package managers from git
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/zsh-users/antigen.git ~/.zsh/antigen/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install vim packages
vim +PluginInstall +qall

# Source the gnome terminal colors
source seoul.sh

