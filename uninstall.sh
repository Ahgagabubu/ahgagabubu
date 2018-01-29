#!/bin/bash
echo    ""
echo    "!!! This step will overwrite your vimrc & tmux.conf & .oh-my-zsh                 !!!"
echo    "!!! Make sure you have backed up your configs if you want to restore them later. !!!"
read -p " Do you want to continue? [y/N] " agree

if [[ $agree == [Yy] ]];then
	echo "Deleting oh-my-zsh & configs..."
	rm -rf ~/.zshrc ~/.oh-my-zsh
	echo "Deleting vim configs..."
	rm -rf ~/.vimrc ~/.vim
	echo "Deleting tmux configs..."
	rm -rf ~/.tmux.conf ~/.tmux
fi

echo    "done!"

