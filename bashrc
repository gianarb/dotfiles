PATH="$HOME/.dotfiles/bin:$HOME/.dotfiles/vendor/bin:$PATH"

alias tmux='TERM=screen-256color tmux'
alias ll='ls -lsa'

#
# Load bash git prompt
#
GIT_PROMPT_ONLY_IN_REPO=1
source ~/.dotfiles/bash-git-prompt/gitprompt.sh

export XDG_CONFIG_HOME=$HOME/.config

#
# FZF plugins
#
_history() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

_find() {
  local file
  file=$(fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
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
# GitHub bash completation
# SOURCE here https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
source ~/.dotfiles/git-completion.bash
