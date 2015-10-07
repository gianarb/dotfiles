all: tmux irssi nvim
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
