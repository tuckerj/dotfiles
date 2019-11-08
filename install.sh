#!/bin/sh

dotfiles=(".vimrc" ".zshrc" ".gitconfig" ".tmux.conf" ".screenrc")
dir="${HOME}/dotfiles"

for dotfile in "${dotfiles[@]}";do
	echo Linking "${dir}/${dotfile}" "-->" "${HOME}/${dotfile}"
	ln -sf "${dir}/${dotfile}" "${HOME}/${dotfile}"
done
