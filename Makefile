all: tmux irssi nvim completion-update
.PHONY: nvim vim

irssi:
	ln -s ${PWD}/irssi ~/.irssi

tmux:
	ln -s ${PWD}/tmux.conf ~/.tmux.conf

vim:
	ln -s ${PWD}/vimrc ~/.vimrc
	ln -s ${PWD}/vim ~/.vim

nvim: vim
	ln -s ~/.vimrc ~/.nvimrc
	ln -s ~/.vim ~/.nvim

git:
	ln -s ${PWD}/gitconfig ~/.gitconfig
	ln -s ${PWD}/gitignore_global ~/.gitignore_global

bash:
	echo "source ${PWD}/bashrc" >> ~/.bashrc

mongo:
	cd ./mongo-hacker &&
	make

npm:
	npm install -g csslint jshint

completion-update:
	 curl -L https://raw.githubusercontent.com/git/git/0f8e831356d4f1a34baf46bb1a6b2d4c89ec9cb8/contrib/completion/git-completion.bash > ~/.dotfiles/bash/git-completion
	 curl -L https://raw.githubusercontent.com/docker/docker/master/contrib/completion/bash/docker > ~/.dotfiles/bash/docker-completion
