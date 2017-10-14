.PHONY: completion-update npm i3
.DEFAULT: default

bash:
	@echo "source ${DOTFILES}/bashrc" >> ~/.bashrc

mongo:
	@cd ${DOTFILES}/mongo-hacker &&
	@make

completion-update:
	 @curl -L https://raw.githubusercontent.com/git/git/0f8e831356d4f1a34baf46bb1a6b2d4c89ec9cb8/contrib/completion/git-completion.bash > ~/.dotfiles/bash/git-completion
	 @curl -L https://raw.githubusercontent.com/docker/docker/master/contrib/completion/bash/docker > ~/.dotfiles/bash/docker-completion

profile.d:
	@sudo ln -s ${DOTFILES}/profile.d/xhost.sh /etc/profile.d/xhost.sh
