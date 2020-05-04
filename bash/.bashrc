export DOTFILES="$HOME/.dotfiles"
export PATH="$HOME/.dotfiles/bin:$HOME/.dotfiles/vendor/bin:$PATH:/opt/bin:/home/gianarb/go/bin:/home/gianarb/.local/bin:/home/gianarb/.gem/ruby/2.5.0/bin:$HOME/bin"

export PATH=${PATH}:$ANDROID_HOME/tools/bin
export PATH=${PATH}:$ANDROID_HOME/tools
export PATH=${PATH}:$ANDROID_HOME/platform-tools
export PATH=${PATH}:$ANDROID_SDK/emulator
export PATH=${PATH}:/home/gianarb/.cargo/bin
export PATH=${PATH}:/usr/local/go/bin
export PATH=${PATH}:${GOPATH}/bin
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export JAVA_HOME=/usr/lib/jvm/default
export ANDROID_HOME=/home/gianarb/Android/Sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export ANDROID_SDK_HOM=$ANDROID_HOME



export EDITOR=vim export XDG_CONFIG_HOME=$HOME/.config

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

_history() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

#source <(kubectl completion bash)

EMOJIS=('🌄' '☀️' '☕️' '🍳' '🍞' '🐓' '🐔' '🌲' '🌳' '🌴' '🌵' '🌷' '🌺' '🌸' '🌹' '🌻' '🌼' '💐' '🌾' '🌿' '🍀' '🍁' '🍂' '🍃' '🍄' '☀️' '⛅️' '☁️' '☔️' '🌈' '🌊' '🗻' '🌍' '🌞' '💻' '🚽' '📚' '✂️' '🔪' '🍔' '🍕' '🍖' '🍗' '🍘' '🍙' '🍚' '🍛' '🍜' '🍝' '🍞' '🍟' '🍣' '🍤' '🍥' '🍱' '🍲' '🍳' '🍴' '🍏' '🍇' '🍉' '🍊' '🍌' '🍍' '🍑' '🍒' '🍓' '🍡' '🍢' '🍦' '🍧' '🍨' '🍩' '🍪' '🍫' '🍬' '🍭' '🍮' '🍰' '🍷' '🍸' '🍶' '🍹' '🍺' '🍻' '😴' '🌠' '🌑' '🌒' '🌔' '🌖' '🌘' '🌚' '🌝' '🌛' '🌜' '⛺️' '🌃' '🌉' '🌌');

RANDOM_EMOJI() {
  SELECTED_EMOJI=${EMOJIS[$RANDOM % ${#EMOJIS[@]}]};
  echo $SELECTED_EMOJI;
}

ALL_EMOJY() {
  printf "%s\n" "${EMOJIS[@]}";
}

function mdtopdf() {
    pandoc $1 --pdf-engine=latexmk -o $2
}

DOCKER_BUILDKIT=1


export BASH_SILENCE_DEPRECATION_WARNING=1
