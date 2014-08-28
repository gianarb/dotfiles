mkdir ~/.vim
mkdir ~/.irssi

cd ~/
ln -s ~/.dotfiles/tmux.conf .tmux.conf
ln -s ~/.dotfiles/irssi ~/.irssi/config
ln -s ~/.dotfiles/vimrc ~/.vimrc
ln -s ~/.dotfiles/colors ~/.vim/colors
ln -s ~/.dotfiles/gitconfig ~/.gitconfig

echo "GIT_PROMPT_ONLY_IN_REPO=1" >> ~/.bashrc
echo "source ~/.dotfiles/bash-git-prompt/gitprompt.sh" >> ~/.bashrc

cd ~/.dotfiles/mongo-hacker
make
