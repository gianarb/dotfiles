export DOTFILES="$HOME/.dotfiles"

export PATH="$HOME/.dotfiles/bin:$HOME/.dotfiles/vendor/bin:$PATH:/opt/bin:/$HOME/go/bin:/$HOME/.local/bin:/$HOME/.gem/ruby/2.5.0/bin:$HOME/bin"
export PATH=${PATH}:/home/gianarb/.cargo/bin
export PATH=${PATH}:/usr/local/go/bin
export PATH=${PATH}:${GOPATH}/bin
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export EDITOR=vim export XDG_CONFIG_HOME=$HOME/.config

alias ll='ls ${LS_OPTS} -lsah'
alias myip='curl --silent ipinfo.io/ip'
alias less='less --RAW-CONTROL-CHARS'
alias ls='ls ${LS_OPTS}'

alias vi=vim
alias clipc=pbcopy

# in theory bash is deprecated (that's weird by itself) in Catalina in favor of
# zsh. That's not acceptable.
export BASH_SILENCE_DEPRECATION_WARNING=1

#
# FZF plugins
#
export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore -l ""'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

for rc in $(ls ${DOTFILES}/bashrc.d/[0-9]*sh | sort -n); do
  . "$rc";
done
