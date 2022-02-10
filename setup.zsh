#!/bin/zsh

DOTPATH=~/dotfiles

if type "apt" > /dev/null 2>&1; then
  sudo apt install build-essential procps curl file git
  if [ ! `type "xsel"` > /dev/null 2>&1 ]; then
    # Install xsel for tmux copy mode
    sudo apt install xsel
  fi
fi

if [ ! `type "brew"` > /dev/null 2>&1 ]; then
  echo "Installing Homebrew ..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ "$(uname)" == 'Linux'* ]; then
    echo "Setup brew for Linux ..."
    # Add PATH for Linux
    # https://docs.brew.sh/Homebrew-on-Linux
    test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
    test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
    echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
  fi
fi

echo "Run brew doctor ..."
brew doctor

echo "Install packages ..."
export HOMEBREW_BUNDLE_FILE="~/dotfiles/Brewfile"
brew bundle install

# Git setup

if [ ! `git config user.name` > /dev/null 2>&1 ]; then
  echo "Setup git with private username and email? (y/N): "
  if read -q; then
    git config --global user.name "Kazuki Matsumaru"
    git config --global user.email marukaz.jh@gmail.com
  fi
fi

# fzf setup
$(brew --prefix)/opt/fzf/install

# Install prezto for zsh
if [ ! -d ~/.zprezto ]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done
fi

for f in .??*
do
  [ "$f" = ".git" ] && continue

  ln -sfv "$DOTPATH/$f" "$HOME/$f"
done

# Activate .gitignore_global
git config --global core.excludesFile ~/.gitignore_global