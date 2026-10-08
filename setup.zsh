#!/bin/zsh

set -euo pipefail

DOTPATH=${0:A:h}

# Preserve existing settings before replacing them with repository links.
function link_dotfile() {
  local source_path=$1 target_path=$2
  if [[ -L "$target_path" && "${target_path:A}" = "${source_path:A}" ]]; then
    return 0
  fi
  mkdir -p "${target_path:h}"
  if [[ -e "$target_path" || -L "$target_path" ]]; then
    local backup_path="${target_path}.backup.$(date +%Y%m%d%H%M%S).$$"
    mv -v "$target_path" "$backup_path"
  fi
  ln -sv "$source_path" "$target_path"
}

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
  if ! command -v xsel > /dev/null 2>&1; then
    # Install xsel for tmux copy mode
    sudo apt install xsel
  fi
fi
if ! type "brew" > /dev/null 2>&1; then
  echo "Installing Homebrew ..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! command -v brew > /dev/null 2>&1; then
  for brew_path in /opt/homebrew/bin/brew /usr/local/bin/brew \
                   "$HOME/.linuxbrew/bin/brew" /home/linuxbrew/.linuxbrew/bin/brew; do
    if [[ -x "$brew_path" ]]; then
      eval "$("$brew_path" shellenv)"
      break
    fi
  done
fi

echo "Run brew doctor ..."
brew doctor

echo "Install brew packages ..."
export HOMEBREW_BUNDLE_FILE="$DOTPATH/Brewfile"
brew bundle install

echo "Installing GitHub CLI extensions ..."
gh auth login
gh extension install kawarimidoll/gh-q

echo "Setting up fzf ..."
"$(brew --prefix)/opt/fzf/install"

echo "Setting up prezto ..."
if ! [ -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
  git clone --recursive https://github.com/marukaz/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  target_path="${ZDOTDIR:-$HOME}/.${rcfile:t}"
  if [[ ! -e "$target_path" && ! -L "$target_path" ]]; then
    ln -s "$rcfile" "$target_path"
  fi
done

echo "Linking dotfiles ..."
for f in .gitconfig .gitconfig_work .gitignore_global .p10k.zsh .tmux.conf \
         .zpreztorc .zshrc .vscode/settings.json; do
  target_path="$HOME/$f"
  if [[ "$f" = .zshrc || "$f" = .zpreztorc || "$f" = .p10k.zsh ]]; then
    target_path="${ZDOTDIR:-$HOME}/$f"
  fi
  link_dotfile "$DOTPATH/$f" "$target_path"
done
