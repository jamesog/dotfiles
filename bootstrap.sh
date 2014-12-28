#!/bin/sh

DOTFILES="
gitconfig
vimrc
vim
"

if [ "$PWD" != "$HOME" ]; then
	echo "Run $(basename $0) from your home directory ($HOME)" >&2
	exit
fi
dotdir=$(dirname $0)

for file in $DOTFILES
do
	if [ -L .$file ]; then
		echo "Skipping $file - target is already a symlink" >&2
	else
		if [ -e .$file ]; then
			mv .$file .${file}.orig
			echo "Backed up .$file to .${file}.orig" >&2
		fi
		ln -s ${dotdir}/$file .$file
		echo "Installed $file" >&2
	fi
done

# Install Vundle plugins
vim +PluginInstall +qall
