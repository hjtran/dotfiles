# Author: Hai Joey Tran
# Common settings for all systems and environments

# include ~/bin for personal scripts
export PATH=~/bin:$PATH

# Load common aliases
dotfiles=~/repo/dotfiles
source $dotfiles'/alias/common.sh'

# shell prompt
function parse_git_branch {
git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="\[\033[01;32m\]\w \[\033[01;34m\]\[\033[01;34m\]\$(parse_git_branch) > \[\e[0m\]"

# source .bashrc for system specific settings
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi
