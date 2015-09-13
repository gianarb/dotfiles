all: tmux irssi nvim
irssi:
	ln -s ~/.dotfiles/irssi ~/.irssi/config
tmux:
	ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
nvim:
	ln -s ~/.dotfiles/nvimrc ~/.nvimrc
	ln -s ~/.dotfiles/nvim ~/.nvim
git:
	ln -s ~/.dotfiles/gitconfig ~/.gitconfig
	ln -s ~/.dotfiles/gitignore_global ~/.gitignore_global
bash:
	echo "source ~/.dotfiles/bashrc" >> ~/.bashrc
mongo:
	cd ~/.dotfiles/mongo-hacker &&
	make
npm:
	npm install -g csslint jshint
