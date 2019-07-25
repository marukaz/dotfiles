#!/bin/sh

DOTPATH=~/.dotfiles

for f in .??*
do
    [ "$f" = ".git" ] && continue

    ln -sv "$DOTPATH/$f" "$HOME/$f"
done
