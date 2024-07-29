#!/bin/zsh

set -euo pipefail

DOTPATH=$(cd $(dirname $0); pwd)

function is_ubuntu() {
  if [ "$(uname)" = 'Linux' ]; then
    if [ -e /etc/lsb-release ]; then
      return 0
    fi
  fi
  return 1 
}

function is_mac() {
  if [ "$(uname)" = 'Darwin' ]; then
    return 0
  fi
  return 1
}

function is_redhat() {
  if [ "$(uname)" = 'Linux' ]; then
    if [ -e /etc/redhat-release ]; then
      return 0
    fi
  fi
  return 1
}

echo "Setting up dotfiles ..."

if ! is_ubuntu && ! is_mac && ! is_redhat; then
  echo "Not supported OS"
  exit 1
fi

echo "Installing brew ..."

if is_ubuntu; then
  echo "Installing packages for Ubuntu ..." 
  sudo apt install build-essential procps curl file git
  if [ ! `type "xsel"` > /dev/null 2>&1 ]; then
    # Install xsel for tmux copy mode
    sudo apt install xsel
  fi
fi

if ! type "brew" > /dev/null 2>&1; then
  echo "Installing Homebrew ..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if is_mac; then
    echo "Setup brew for Mac ..."
    # Add PATH for Mac
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zshrc
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  if [ "$(uname)" = 'Linux' ]; then
    echo "Setup brew for Linux ..."
    # Add PATH for Linux
    # https://docs.brew.sh/Homebrew-on-Linux
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv∏)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zshrc
  fi
fi

echo "Run brew doctor ..."
brew doctor

echo "Install brew packages ..."
export HOMEBREW_BUNDLE_FILE="$DOTPATH/Brewfile"
brew bundle install

echo "Setting up git ..."

git config --global core.editor "vim"
git config --global pull.rebase false

if [ -z "$(git config user.name)" ]; then
  echo "Setup git with private username and email? (y/N): "
  if read -q; then
    git config --global user.name "Kazuki Matsumaru"
    git config --global user.email marukaz.jh@gmail.com
  else
    echo "Setting up git with private username and email only for this repository ..."
    git config user.name "Kazuki Matsumaru"
    git config user.email marukaz.jh@gmail.com
fi

echo "Installing GitHub CLI extensions ..."

gh auth login
gh extension install kawarimidoll/gh-q
gh extension install github/gh-copilot

echo "Setting up fzf ..."
$(brew --prefix)/opt/fzf/install

echo "Setting up prezto ..."
if ! [ -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done
fi

echo "Linking dotfiles ..."

for f in .??*
do
  [ "$f" = ".git" ] && continue

  ln -sfv "$DOTPATH/$f" "$HOME/$f"
done

echo "Activating .gitignore_global ..."
git config --global core.excludesFile ~/.gitignore_global

echo "Adding PATH for brew bundle ..."
(echo; echo "export HOMEBREW_BUNDLE_FILE=\"${PWD}/Brewfile\"") >> ~/.zprofile
