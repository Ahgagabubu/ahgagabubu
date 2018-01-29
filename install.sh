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

read -p " Do you want to continue? [y/N] " agree

if [[ $agree != [Yy] ]];then
	echo " Do nothing & exit!"
	exit
fi

until [[ $install_all == [YyNn] ]];do
	read -p " Install all components? (Choose no you can select what you want later.) [Y/n] " install_all
	install_all=${install_all:-y}
done

# Check config
if [[ $install_all == [Yy] ]];then
	install_zshrc=y
	install_vimrc=y
	install_tmux_conf=y
fi

until [[ $install_zshrc == [YyNn] ]];do
	read -p " Install zsh configs? [y/N] " install_zshrc
	install_zshrc=${install_zshrc:-n}
done

until [[ $install_vimrc == [YyNn] ]];do
	read -p " Install vim configs? [y/N] " install_vimrc
	install_vimrc=${install_vimrc:-n}
done

until [[ $install_tmux_conf == [YyNn] ]];do
	read -p " Install tmux configs? [y/N] " install_tmux_conf
	install_tmux_conf=${install_tmux_conf:-n}
done

line
if [[ $install_zshrc == [Yy] ]];then
	echo "Installing zsh configs..."

	rm -rf ~/.oh-my-zsh
	git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

	cp -rf ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
	sed 's/^ZSH_THEME=.*/ZSH_THEME="ys"/g' -i ~/.zshrc
	sed 's/^# CASE_SENSITIVE=.*/CASE_SENSITIVE="true"/g' -i ~/.zshrc

	cp -rf zsh/*.zsh ~/.oh-my-zsh/custom/

	echo "done!"
fi

line
if [[ $install_vimrc == [Yy] ]];then
	echo "Installing vim configs..."

	# Install Vundle
	rm -rf ~/.vim
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

	cp -rf vim/vimrc.vundle ~/.vimrc
	vim +PluginInstall +qall

	# Add custom configs
	cp -rf vim/ftplugin ~/.vim/
	cat vim/vimrc.custom >> ~/.vimrc

	# Install vim-go submodules
	if [ "$GOPATH" != "" ];then
		vim +GoInstallBinaries +qall
	fi

	echo "done!"
fi

line
if [[ $install_tmux_conf == [Yy] ]];then
	echo "Installing tmux configs..."

	rm -rf ~/.tmux
	git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux/tmux-themepack

	cp -rf tmux/tmux.conf ~/.tmux.conf

	# Set tmux default shell to be zsh if exists.
	[ -e /bin/zsh ] && echo "set-option -g default-shell /bin/zsh" >> ~/.tmux.conf

	echo "done!"
fi

