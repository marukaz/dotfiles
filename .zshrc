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

# alias
alias reload='source ~/dotfiles/.zshrc'
alias jupyter_nike='ssh -L 8516:localhost:8516 athena -t ssh -L 8516:localhost:8516 nike'

# vim
alias vi='vim'

# load environment specific settings
if [ -f ~/.zshlocal ]; then
        source ~/.zshlocal
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
