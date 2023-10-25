export DOTFILES="$HOME/.dotfiles"

export PATH="$HOME/.dotfiles/bin:$HOME/.dotfiles/vendor/bin:$PATH:/opt/bin:/$HOME/go/bin:/$HOME/.local/bin:/$HOME/.gem/ruby/2.5.0/bin:$HOME/bin"
export PATH=${PATH}:${HOME}/.cargo/bin
export PATH=${PATH}:/usr/local/go/bin
export PATH=${PATH}:${GOPATH}/bin

export HOMEBREW_BUNDLE_FILE=$HOME/.dotfiles/homebrew/Brewfile

export EDITOR=vim
export XDG_CONFIG_HOME=$HOME/.config

for rc in $(ls ${DOTFILES}/bashrc.d/[0-9]*sh | sort -n); do
  . "$rc";
done

export GIT_PS1_SHOWUPSTREAM="auto"
export PS1='\u@\h \[\e[$([[ $? = 0 ]] && printf 32 || printf 31);1m\]\w\[\e[m\] $(__git_ps1 " (%s)") \$ '

# Sometime the cursor disappears.
# This is a solution that works for me
# https://superuser.com/questions/1547622/tmux-keyboard-cursor-disappears-after-leaving-scroll-mode
alias refresh_cursor='tput cnorm'

alias ll='ls ${LS_OPTS} -lsah'
alias myip='curl --silent ipinfo.io/ip'
alias less='less --RAW-CONTROL-CHARS'
alias ls='ls ${LS_OPTS}'
alias vi=vim
alias clipc=pbcopy
alias port_in_use='netstat -tulpn | grep LISTEN'

#
# FZF plugins
#
export FZF_DEFAULT_COMMAND='rg -l ""'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# ensure compatibility tmux <-> direnv
if [ -n "$TMUX" ] && [ -n "$DIRENV_DIR" ]; then
    unset "${!DIRENV_@}"  # unset env vars starting with DIRENV_
fi
eval "$(direnv hook bash)"
