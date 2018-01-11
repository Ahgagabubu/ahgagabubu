#!/bin/bash
##########################################################
# Make sure zsh is at /bin/zsh & tmux vim are installed. #
##########################################################

line () {
	echo    "------------------------------------------------------------------------------------"
}

echo    ""
line
echo    "!!! This step will overwrite your vimrc & tmux.conf & .oh-my-zsh                 !!!"
echo    "!!! Make sure you have backed up your configs if you want to restore them later. !!!"
line

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

line
if [[ $ZSHRC == [Yy] ]];then
	echo "Installing zsh configs..."

	rm -rf ~/.oh-my-zsh
	git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

	cp -rf ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
	sed 's/^ZSH_THEME=.*/ZSH_THEME="ys"/g' -i ~/.zshrc
	sed 's/^# CASE_SENSITIVE=.*/CASE_SENSITIVE="true"/g' -i ~/.zshrc
	echo 'alias vimup="vi +PluginInstall +qall"' >> ~/.zshrc

	cp -rf zsh/*.zsh ~/.oh-my-zsh/custom/

	echo "done!"
fi

line
if [[ $VIMRC == [Yy] ]];then
	echo "Installing vim configs..."

	# Install Vundle
	rm -rf ~/.vim
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

	cp -rf vim/vimrc.vundle ~/.vimrc
	vim +PluginInstall +qall

	# Add custom configs
	cp -rf vim/ftplugin ~/.vim/
	cat vim/vimrc.custom >> ~/.vimrc

	# Insstall vim-go submodules
	if [ "$GOPATH" != "" ];then
		vim +GoInstallBinaries +qall
		export PATH=$PATH:$GOPATH/bin
	fi

	echo "done!"
fi

line
if [[ $TMUXRC == [Yy] ]];then
	echo "Installing tmux configs..."

	rm -rf ~/.tmux
	git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux/tmux-themepack

	cp -rf tmux/tmux.conf ~/.tmux.conf

	# Set zsh as default shell is it exists.
	[ -e /bin/zsh ] && echo "set-option -g default-shell /bin/zsh" >> ~/.tmux.conf

	echo "done!"
fi

