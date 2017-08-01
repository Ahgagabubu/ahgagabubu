#!/bin/sh
echo "!!! This step will overwrite your vimrc & tmux.conf                              !!!"
echo "!!! Make sure you have backed up your configs if you want to restore them later. !!!"
read -p "Do you want to continue? [y/N]" yn

case $yn in
    [Yy]*)
        mkdir -p ~/.vim/colors
        cp -rf vimrc ~/.vimrc
        cp -rf vim-dracula/colors/* ~/.vim/colors/

        mkdir -p ~/.tmux/tmux-themepack
        cp -rf tmux.conf ~/.tmux.conf
        cp -rf tmux-themepack ~/.tmux/
        echo "Done!"
    ;;

    *) 
        echo "Do nothing & exit!"
        exit
    ;;
esac
