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
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone https://github.com/zplug/zplug ~/.zsh/.zplug
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install vim packages
nvim +PlugInstall

