export LANG="ja_JP.UTF-8"

case `uname` in
  Darwin)
    alias ls='ls -G'
  ;;
  Linux)
    alias ls='ls -h --color=auto'
  ;;
esac

# ALIAS
alias ll='ls -l'      
alias la='ls -A'
alias l='ls -CF'
alias reload='source ~/repos/dotfiles/.zshrc'
alias jupyter_nike='ssh -L 8516:localhost:8516 athena -t ssh -L 8516:localhost:8516 nike'

# vim
alias vi='vim'

# grep
alias g='grep --color=always'
alias grep='grep --color=always'

# docker
alias d='docker'
alias dps='docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}"'
alias dc='docker-compose'

# git
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gcm='git commit -m'
alias gl='git log --pretty=format:"%C(yellow)%h%Creset %C(magenta)%ci%Creset%n%C(cyan)%an <%ae>%Creset%n%B"'
alias glp='git log -p'
alias glg='git log --graph --pretty=format:"%C(yellow)%h%Creset %C(magenta)%ci%Creset%n%C(cyan)%an <%ae>%Creset%n%B"'
alias gco='git checkout'
alias gd='git diff'
alias gdh='git diff HEAD'
alias gds='git diff --stat'
alias gdt='git difftool'
alias gst='git status'
alias gp='git pull'

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000
setopt appendhistory autocd beep nomatch
bindkey -e

# share history
setopt inc_append_history
setopt share_history

# load environment specific settings
if [ -f ~/.zshlocal ]; then
	source ~/.zshlocal
fi

# The following lines were added by compinstall
zstyle :compinstall filename '~/repos/dotfiles/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
