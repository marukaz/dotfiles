#!/bin/sh

DOTPATH=~/repos/dotfiles

for f in .??*
do
    [ "$f" = ".git" ] && continue

    ln -sfv "$DOTPATH/$f" "$HOME/$f"
done
