#!/usr/bin/env bash

# un-stow config directories
stow -D zsh
stow -D vim
stow -D git
stow -D tmux

# remove various package managers
rm -rf ~/.vim/bundle/Vundle.vim
rm -rf ~/.zsh/antigen/
rm -rf ~/.tmux/plugins/tpm

