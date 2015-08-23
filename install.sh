#!bin/bash

mkdir ~/.vim
mkdir ~/.irssi

cd ~/
ln -s ~/.dotfiles/tmux.conf .tmux.conf
ln -s ~/.dotfiles/irssi ~/.irssi/config
ln -s ~/.dotfiles/nvimrc ~/.nvimrc
ln -s ~/.dotfiles/nvim ~/.nvim
ln -s ~/.dotfiles/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/gitignore_global ~/.gitignore_global

echo "GIT_PROMPT_ONLY_IN_REPO=1" >> ~/.bashrc
echo "source ~/.dotfiles/bash-git-prompt/gitprompt.sh" >> ~/.bashrc

cd ~/.dotfiles/mongo-hacker

npm install -g csslint jshint

make
