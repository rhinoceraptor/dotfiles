#!/usr/bin/env bash

# Stow config directories
stow zsh
stow vim
stow git
stow tmux

# Clone various package managers from git
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/zsh-users/antigen.git ~/.zsh/antigen/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Source the gnome terminal colors
source gnome_term_colors.sh

