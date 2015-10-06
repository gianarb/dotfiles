all: tmux irssi nvim

irssi:
	ln -s ${PWD}/irssi ~/.irssi

tmux:
	ln -s ${PWD}/tmux.conf ~/.tmux.conf

nvim:
	ln -s ${PWD}/vimrc ~/.nvimrc
	ln -s ${PWD}/vim ~/.nvim

vim:
	ln -s ${PWD}/vimrc ~/.vimrc
	ln -s ${PWD}/vim ~/.vim

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
