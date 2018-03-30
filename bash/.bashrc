export TERM="screen-256color"
export DOTFILES="$HOME/.dotfiles"
export PATH="$HOME/.dotfiles/bin:$HOME/.dotfiles/vendor/bin:$PATH:/opt/bin:/home/gianarb/go/bin"
export EDITOR=vim

#
# This directory contains all the command replaced with a docker container.
# By default it's disable but you can enable it in your ~/.bashrc
# PATH="$DOTFILES/docker-bin:$PATH'

alias ll='ls -lsah'
alias myip='curl ipinfo.io/ip'

alias sl=ls
alias mdkir=mkdir
alias soruce=source
alias souce=source
alias vi=vim
alias myzoom='echo "https://zoom.us/j/7781108297"'
alias clipc='xclip -in -selection clipboard'

alias g=git
alias d=docker

alias gs='git show --pretty=oneline'
alias gpom='git push origin master'
alias gpod='git push origin develop'
alias gfpu='git fetch upstream && git pull upstream develop'
alias grom='git reset --hard origin/master'
alias gp='git pull'
alias shm="source ~/.bashrc"

# Reference
alias alphabet='echo a b c d e f g h i j k l m n o p q r s t u v w x y z'
alias unicode='echo ✓ ™  ♪ ♫ ☃ ° Ɵ ∫'
alias numalphabet='alphabet; echo 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6'
alias ascii='man ascii | grep -m 1 -A 63 --color=never Oct'

#
# Load bash git prompt
#
GIT_PROMPT_ONLY_IN_REPO=0
source $DOTFILES/bash-git-prompt/gitprompt.sh

export XDG_CONFIG_HOME=$HOME/.config

#
# FZF plugins
#
export FZF_DEFAULT_COMMAND="find -L * -path '*/\.*' -prune -o -type f -print -o -type l -print 2> /dev/null"

_history() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

git_log() {
  local out sha q
  while out=$(
      git log --decorate=short --graph --oneline --color=always |
      fzf --ansi --multi --no-sort --reverse --query="$q" --print-query); do
    q=$(head -1 <<< "$out")
    while read sha; do
      [ -n "$sha" ] && git show --color=always $sha | less -R
    done < <(sed '1d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
  done
}
source <(kubectl completion bash)


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
