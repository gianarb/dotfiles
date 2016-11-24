PATH="$HOME/.dotfiles/docker-bin:$HOME/.dotfiles/bin:$HOME/.dotfiles/vendor/bin:$PATH:/opt/bin"

alias tmux='TERM=screen-256color tmux'
alias ll='ls -lsa'
export PS1='\w $ '

#
# Load bash git prompt
#
GIT_PROMPT_ONLY_IN_REPO=1
source ~/.dotfiles/bash-git-prompt/gitprompt.sh

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

#
source ~/.dotfiles/bash/git-completion
source ~/.dotfiles/bash/docker-completion
