all: tmux irssi nvim
irssi:
	ln -s ./irssi ~/.irssi/config
tmux:
	ln -s ./tmux.conf ~/.tmux.conf
vim:
	ln -s ./nvimrc ~/.nvimrc
	ln -s ./nvim ~/.nvim
git:
	ln -s ~/gitconfig ~/.gitconfig
	ln -s ~/gitignore_global ~/.gitignore_global
bash:
	echo "source ${PWD}/bashrc" >> ~/.bashrc
mongo:
	cd ./mongo-hacker &&
	make
npm:
	npm install -g csslint jshint
