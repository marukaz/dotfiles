#!/bin/zsh

DOTPATH=~/dotfiles

# Install xsel for tmux copy mode
if type "apt" > /dev/null 2>&1; then
    if [ ! `type "xsel"` > /dev/null 2>&1 ]; then
	sudo apt install xsel
    fi
fi

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
