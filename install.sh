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
echo '.bash_profile symlinked'

if [ -f ~/.gitconfig ]
	then
		echo 'gitconfig found, saving as .gitconfig.bkup'
		mv ~/.gitconfig ~/.gitconfig.bkup
fi
ln -s $(pwd)/gitconfig .gitconfig
mv .bash_profile ~/
echo '.gitconfig symlinked'

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
		echo 'done!'

		echo 'installing fzf...'
		cd ~/.vim/bundle
		git clone https://github.com/junegunn/fzf.vim
		echo 'done!'

		echo 'installing fugitive...'
		cd ~/.vim/bundle
		git clone https://github.com/tpope/vim-fugitive
		echo 'done!'

		echo 'installing airline...'
		cd ~/.vim/bundle
		git clone https://github.com/vim-airline/vim-airline
		echo 'done!';;

	* ) exit;;
esac
