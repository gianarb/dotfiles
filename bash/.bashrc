export DOTFILES="$HOME/.dotfiles"

export PATH="$HOME/.dotfiles/bin:$HOME/.dotfiles/vendor/bin:$PATH:/opt/bin:/$HOME/go/bin:/$HOME/.local/bin:/$HOME/.gem/ruby/2.5.0/bin:$HOME/bin"
export PATH=${PATH}:/home/gianarb/.cargo/bin
export PATH=${PATH}:/usr/local/go/bin
export PATH=${PATH}:${GOPATH}/bin
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export EDITOR=vim export XDG_CONFIG_HOME=$HOME/.config

export GOPATH="$HOME/go"
export GOPROXY=https://proxy.golang.org

#
# This directory contains all the command replaced with a docker container.
# By default it's disable but you can enable it in your ~/.bashrc
# PATH="$DOTFILES/docker-bin:$PATH'

alias ll='ls ${LS_OPTS} -lsah'
alias myip='curl --silent ipinfo.io/ip'
alias less='less --RAW-CONTROL-CHARS'
alias ls='ls ${LS_OPTS}'

alias sl=ls
alias mdkir=mkdir
alias vi=vim
alias clipc=pbcopy

#
# Load bash git prompt
#
if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
    source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
fi
GIT_PROMPT_ONLY_IN_REPO=0
GIT_PROMPT_THEME_NAME="Single_line" # needed for reload optimization, should be unique

#
# FZF plugins
#
export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore -l ""'

# Enable experimental feature for Docker buildkit
DOCKER_BUILDKIT=1

# in theory bash is deprecated (that's weird by itself) in Catalina in favor of
# zsh. That's not acceptable.
export BASH_SILENCE_DEPRECATION_WARNING=1
