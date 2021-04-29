#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

HISTSIZE=100000
SAVEHIST=100000

# =====================
# alias
# =====================
alias la='ls -lFGa'
alias ll='ls -lFG'
alias relogin='exec $SHELL -l'
alias history='history -i'

# =====================
# starship
# =====================
eval "$(starship init zsh)"

# =====================
# fzf
# =====================
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# =====================
# go
# =====================
export GOPATH="$HOME/.go"
export PATH="$GOPATH/bin:$PATH"
