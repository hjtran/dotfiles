#!/bin/bash

# Creates sym links for dot files
# Run from script dir

echo 'making symlinks of dotfiles...'
echo
make_sym () {
    if [ -f ~/.$1 ]
        then
            echo $1' found, saving as .'$1'.bkup'
            mv '~/.'$1 '~/.'$1'.bkup'
    fi
    ln -s $(pwd)/$1 .$1
    mv .$1 ~/
    echo '.'$1' symlinked'
}
for f in 'vimrc' 'bash_profile' 'gitconfig' 'tmux.conf'; do
    make_sym $f
done
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
