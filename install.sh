#!/bin/bash

# Creates sym links for dot files
# Run from script dir

echo 'making symlinks of dotfiles...'
if [ -f ~/.vimrc ]
	then
		echo 'vimrc found, saving as .vimrc.bkup'
		mv ~/.vimrc ~/.vimrc.bkup
fi
ln -s $(pwd)/vimrc .vimrc
mv .vimrc ~/

echo '.vimrc symlinked'

if [ -f ~/.bash_profile ]
	then
		echo 'bash_profile found, saving as .bash_profile.bkup'
		mv ~/.bash_profile ~/.bash_profile.bkup
fi
ln -s $(pwd)/bash_profile .bash_profile
mv .bash_profile ~/

echo 
echo 'done!'

read -p 'install vim extras?' yn
case $yn in
	[Yy]* ) 
		echo 'installing pathogen...'
		mkdir -p ~/.vim/autoload ~/.vim/bundle && \
		curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
		echo 'done!'

		echo 'installing syntastic...'
		cd ~/.vim/bundle
		git clone https://github.com/scrooloose/syntastic.git
		echo 'done~'

		echo 'installing solarized...'
		cd ~/.vim/bundle
		git clone git://github.com/altercation/vim-colors-solarized.git
		echo 'done!';;

	* ) exit;;
esac
