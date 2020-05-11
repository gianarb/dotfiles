#!/usr/bin/env bash
set -xeuo pipefail

install_path=$HOME/.dotfiles

git=$(which git)
stow=$(which stow)

if [ ! -f "$HOME/.gdbinit" ]; then
    wget -P ~ git.io/.gdbinit
fi

if [ ! -d "$HOME~/.config/i3/i3blocks-contrib" ]; then
    git clone https://github.com/vivien/i3blocks-contrib $HOME/.i3/i3blocks-contrib
fi

if [ ! -d "$install_path" ]; then
  $git clone https://github.com/gianarb/dotfiles $install_path
fi

wget -O ~/.weechat/python/autoload/wee_slack.py https://raw.githubusercontent.com/wee-slack/wee-slack/master/wee_slack.py
wget -O ~/.weechat/python/autoload/autosort.py https://raw.githubusercontent.com/de-vri-es/weechat-autosort/master/autosort.py
wget -O ~/.weechat/weemoji.json https://raw.githubusercontent.com/wee-slack/wee-slack/master/weemoji.json

pushd $install_path
$stow i3
$stow tmux
$stow git
$stow bash
$stow vim
$stow gdb
$stow dunst
$stow desktop
$stow config
$stow kitty
$stow vscode
$stow screenlayout
popd
