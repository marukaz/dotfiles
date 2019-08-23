#!/bin/sh

DOTPATH=~/repos/dotfiles

# Install xsel for tmux copy mode
if type "apt" > /dev/null 2>&1; then
    if !(type "xsel" > /dev/null 2>&1); then
	sudo apt install xsel
    fi
fi

for f in .??*
do
    [ "$f" = ".git" ] && continue

    ln -sfv "$DOTPATH/$f" "$HOME/$f"
done
