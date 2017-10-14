bash:
	@echo "source ${DOTFILES}/bashrc" >> ~/.bashrc

profile.d:
	@sudo ln -s ${DOTFILES}/profile.d/xhost.sh /etc/profile.d/xhost.sh
