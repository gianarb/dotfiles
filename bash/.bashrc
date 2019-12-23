export DOTFILES="$HOME/.dotfiles"
export PATH="$HOME/.dotfiles/bin:$HOME/.dotfiles/vendor/bin:$PATH:/opt/bin:/home/gianarb/go/bin:/home/gianarb/.local/bin:/home/gianarb/.gem/ruby/2.5.0/bin:$HOME/bin"
export EDITOR=vim
export XDG_CONFIG_HOME=$HOME/.config
export LS_OPTS='--color=auto'

#
# This directory contains all the command replaced with a docker container.
# By default it's disable but you can enable it in your ~/.bashrc
# PATH="$DOTFILES/docker-bin:$PATH'

alias ll='ls ${LS_OPTS} -lsah'
alias myip='curl ipinfo.io/ip'
alias less='less --RAW-CONTROL-CHARS'
alias ls='ls ${LS_OPTS}'

alias sl=ls
alias mdkir=mkdir
alias soruce=source
alias souce=source
alias vi=vim
alias clipc='xclip -in -selection clipboard'

#
# Load bash git prompt
#
source $DOTFILES/bash-git-prompt/gitprompt.sh
GIT_PROMPT_ONLY_IN_REPO=0
GIT_PROMPT_THEME_NAME="Single_line" # needed for reload optimization, should be unique

#
# FZF plugins
#
export FZF_DEFAULT_COMMAND='rg --hidden -l ""'

_history() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

source <(kubectl completion bash)

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source /usr/share/nvm/init-nvm.sh

export JAVA_HOME=/usr/lib/jvm/java-10-openjdk
export ANDROID_HOME=/home/gianarb/Android/Sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export ANDROID_SDK_HOM=$ANDROID_HOME

export PATH=${PATH}:$ANDROID_HOME/tools/bin
export PATH=${PATH}:$ANDROID_HOME/tools
export PATH=${PATH}:$ANDROID_HOME/platform-tools
export PATH=${PATH}:$ANDROID_SDK/emulator
export PATH=${PATH}:/home/gianarb/.cargo/bin

export PATH=${PATH}:/usr/local/go/bin

GOPROXY=https://proxy.golang.org

EMOJIS=('🌄' '☀️' '☕️' '🍳' '🍞' '🐓' '🐔' '🌲' '🌳' '🌴' '🌵' '🌷' '🌺' '🌸' '🌹' '🌻' '🌼' '💐' '🌾' '🌿' '🍀' '🍁' '🍂' '🍃' '🍄' '☀️' '⛅️' '☁️' '☔️' '🌈' '🌊' '🗻' '🌍' '🌞' '💻' '🚽' '📚' '✂️' '🔪' '🍔' '🍕' '🍖' '🍗' '🍘' '🍙' '🍚' '🍛' '🍜' '🍝' '🍞' '🍟' '🍣' '🍤' '🍥' '🍱' '🍲' '🍳' '🍴' '🍏' '🍇' '🍉' '🍊' '🍌' '🍍' '🍑' '🍒' '🍓' '🍡' '🍢' '🍦' '🍧' '🍨' '🍩' '🍪' '🍫' '🍬' '🍭' '🍮' '🍰' '🍷' '🍸' '🍶' '🍹' '🍺' '🍻' '😴' '🌠' '🌑' '🌒' '🌔' '🌖' '🌘' '🌚' '🌝' '🌛' '🌜' '⛺️' '🌃' '🌉' '🌌');

RANDOM_EMOJI() {
  SELECTED_EMOJI=${EMOJIS[$RANDOM % ${#EMOJIS[@]}]};
  echo $SELECTED_EMOJI;
}

ALL_EMOJY() {
  printf "%s\n" "${EMOJIS[@]}";
}

[[ -s "/home/gianarb/.gvm/scripts/gvm" ]] && source "/home/gianarb/.gvm/scripts/gvm"

function mdtopdf() {
    pandoc $1 --pdf-engine=latexmk -o $2
}

DOCKER_BUILDKIT=1
