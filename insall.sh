#!/usr/bin/env bash

set -xeuo pipefail

install_path=$HOME/.dotfiles

git=$(which git)
stow=$(which stow)

if [ ! -f "$HOME/.gdbinit" ]; then
    wget -P ~ git.io/.gdbinit
fi

if [ ! -d "$HOME~/.i3/i3blocks-contrib" ]; then
    git clone https://github.com/vivien/i3blocks-contrib $HOME/.i3/i3blocks-contrib
fi

if [ ! -d "$install_path" ]; then
  $git clone https://github.com/gianarb/dotfiles $install_path
fi

pushd $install_path
$stow i3
$stow tmux
$stow git
$stow bash
$stow vim
$stow gdb
$stow dunst
$stow alacritty
$stow gh
$stow nixpkgs
$stow rssnix
popd
