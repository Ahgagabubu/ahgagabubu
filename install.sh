#!/bin/bash
##########################################################
# Make sure zsh is at /bin/zsh & tmux vim are installed. #
##########################################################

printline () {
    echo    "------------------------------------------------------------------------------------"
}

echo    ""
printline
echo    "!!! This step will overwrite your vimrc & tmux.conf                              !!!"
echo    "!!! Make sure you have backed up your configs if you want to restore them later. !!!"
printline

read -p " Do you want to continue? [y/N] " CONTINUE

if [[ $CONTINUE != [Yy] ]];then
    echo " Do nothing & exit!"
    exit
fi

read -p " Install all components? (Choose no you can select what you want later.) [Y/n] " INSTALL_ALL
[[ $INSTALL_ALL != [Nn] ]] && INSTALL_ALL=y

# Check config
if [[ $INSTALL_ALL != [Yy] ]];then
    read -p " Install zsh conf? [Y/n] " ZSHRC
    read -p " Install vim conf? [Y/n] " VIMRC
    read -p " Install tmux conf? [Y/n] " TMUXRC
fi

[[ $ZSHRC != [Nn] ]] && ZSHRC=y
[[ $VIMRC != [Nn] ]] && VIMRC=y
[[ $TMUXRC != [Nn] ]] && TMUXRC=y

printline

# Git submodule update
git submodule init
git submodule update

if [[ $ZSHRC == [Yy] ]];then
    echo -n " Installing zsh configs..."
    if [ -e "/bin/zsh" ];then
        mkdir -p ~/.oh-my-zsh
        cp -rf oh-my-zsh/* ~/.oh-my-zsh/
        cp -rf zshrc.zsh-template ~/.zshrc
        echo "done!"
    else
        echo "zsh is not at /bin/zsh or not installed!"
    fi
fi

if [[ $VIMRC == [Yy] ]];then
    echo -n " Installing vim configs..."
    mkdir -p ~/.vim
    cp -rf vim-dracula/colors ~/.vim/
    cp -rf vimrc.template ~/.vimrc
    echo "done!"
fi

if [[ $TMUXRC == [Yy] ]];then
    echo -n " Installing tmux configs..."
    mkdir -p ~/.tmux
    cp -rf tmux-themepack ~/.tmux/
    cp -rf tmux.conf.template ~/.tmux.conf
    [ -e /bin/zsh ] && echo "set-option -g default-shell /bin/zsh" >> ~/.tmux.conf
    echo "done!"
fi

