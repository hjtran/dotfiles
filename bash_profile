# Author: Hai Joey Tran
# bash settings to be used across my systems

# source .bashrc for system specific settings
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

# vim-like aliases
alias :x='exit'
alias :q='exit'

# line count
alias lc='wc -l '

# colored ls
alias ls='ls -G'

# include ~/bin for personal binary files
export PATH=~/bin:$PATH

# set bash prompt text (before commands)
PS1='\H:\w $ '

# added by Anaconda3 4.4.0 installer
export PATH="/Users/joey/anaconda3/bin:$PATH"
