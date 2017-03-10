.PHONY: completion-update npm
.DEFAULT: default

irssi:
	@ln -s ${DOTFILES}/irssi ~/.irssi

tmux:
	@ln -s ${DOTFILES}/tmux.conf ~/.tmux.conf

vim:
	@ln -s ${DOTFILES}/vimrc ~/.vimrc
	@ln -s ${DOTFILES}/vim ~/.vim

nvim: vim
	@ln -s ~/.vimrc ~/.nvimrc
	@ln -s ~/.vim ~/.nvim

git:
	@ln -s ${DOTFILES}/gitconfig ~/.gitconfig
	@ln -s ${DOTFILES}/gitignore_global ~/.gitignore_global

bash:
	@echo "source ${DOTFILES}/bashrc" >> ~/.bashrc

mongo:
	@cd ${DOTFILES}/mongo-hacker &&
	@make

npm:
	*npm install -g csslint jshint

completion-update:
	 @curl -L https://raw.githubusercontent.com/git/git/0f8e831356d4f1a34baf46bb1a6b2d4c89ec9cb8/contrib/completion/git-completion.bash > ~/.dotfiles/bash/git-completion
	 @curl -L https://raw.githubusercontent.com/docker/docker/master/contrib/completion/bash/docker > ~/.dotfiles/bash/docker-completion

profile.d:
	@sudo ln -s ${DOTFILES}/profile.d/xhost.sh /etc/profile.d/xhost.sh
