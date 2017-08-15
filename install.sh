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
if [[ $ZSHRC == [Yy] ]];then
    echo "Installing zsh configs..."
    if [ -e "/bin/zsh" ];then
        rm -rf ~/.oh-my-zsh
        git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
        cp -rf ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
        echo "done!"
    else
        echo "skipped!\n zsh is not at /bin/zsh or not installed!"
    fi
fi
printline

if [[ $VIMRC == [Yy] ]];then
    echo "Installing vim configs..."
    rm -rf /tmp/vim-dracula
    git clone https://github.com/dracula/vim.git /tmp/vim-dracula
    cp -rf /tmp/vim-dracula/colors/*.vim ~/.vim/colors/
    cp -rf vimrc.template ~/.vimrc
    echo "done!"
fi
printline

if [[ $TMUXRC == [Yy] ]];then
    echo "Installing tmux configs..."
    rm -rf ~/.tmux/tmux-themepack
    git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux/tmux-themepack
    cp -rf tmux.conf.template ~/.tmux.conf
    [ -e /bin/zsh ] && echo "set-option -g default-shell /bin/zsh" >> ~/.tmux.conf
    echo "done!"
fi

