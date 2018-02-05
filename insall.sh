#!/usr/bin/env bash
wget -P ~ git.io/.gdbinit

git clone https://github.com/vivien/i3blocks-contrib $HOME/.i3/i3blocks-contrib

set -xeuo pipefail

install_path=$HOME/.dotfiles

git=$(which git)
stow=$(which stow)

if [ ! -d "$install_path" ]; then
  $git clone https://github.com/gianarb/dotfiles $install_path
fi

pushd $install_path
$stow i3
$stow tmux
$stow git
$stow irssi
$stow  bash
$stow  vim
$stow gdb
$stow dunst
$stow  desktop
$stow  terminator
$stow  config
popd
