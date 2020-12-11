# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# brew completion
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# alias
alias reload='source ~/dotfiles/.zshrc'
alias jupyter_nike='ssh -L 8516:localhost:8516 athena -t ssh -L 8516:localhost:8516 nike'
alias ic='ibmcloud'
alias k=kubectl
function qblogin (){oc login -u kubeadmin -p $1 --insecure-skip-tls-verify=true api.${2}.cp.fyre.ibm.com:6443 -n zen}

## IBM
alias seer_install='mvn -s maven/settings.xml clean install -DskipTests -Dartifactory.user=$ARTIFACTORY_USER -Dartifactory.apikey=$ARTIFACTORY_APIKEY'

## vim
alias vi='vim'

# load environment specific settings
if [ -f ~/.zshlocal ]; then
        source ~/.zshlocal
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
