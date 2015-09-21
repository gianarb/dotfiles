all: tmux irssi nvim
irssi:
	ln -s ${PWD}/irssi ~/.irssi/config
tmux:
	ln -s ${PWD}/tmux.conf ~/.tmux.conf
vim:
	ln -s ${PWD}/nvimrc ~/.nvimrc
	ln -s ${PWD}/nvim ~/.nvim
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
