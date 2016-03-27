PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:~/bin
export PATH

# Ignore leading spaces and duplicate commands in history
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=1000

unset MAILCHECK

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export EDITOR=vim
export PAGER=less
export LESS='-aiM'

case $(uname) in
	Darwin)
		# If on a Mac, load Homebrew completions
		if [ -f $(brew --prefix)/etc/bash_completion ]; then
			. $(brew --prefix)/etc/bash_completion
		fi
		;;
	Linux)
		if [[ -f /etc/bash_completion ]]; then
			. /etc/bash_completion
		fi
		;;
esac

virtualenv_prompt() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    printf "(\[\e[1;34m\]`basename $VIRTUAL_ENV`\[\e[0m\]) "
  else
    printf ""
  fi
}

ip4to6() {
	ip4=$(echo $1 | tr . " ")
	printf "%x %x %x %x" $ip4 | (read o1 o2 o3 o4; echo $o1$o2:$o3$o4)
}

ip6to4() {
	echo $1 | tr : " " | (
		read h1 h2
		printf "%d.%d.%d.%d\n" 0x${h1:0:2} 0x${h1:2:2} 0x${h2:0:2} 0x${h2:2:2}
	)
}

# Git prompt
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
source ~/.git-prompt.sh
PS1='\u@\h:\w'
[[ -n "$VIRTUAL_ENV" ]] && VIRTUAL_PS1="(`basename \"$VIRTUAL_ENV\"`) "
PROMPT_COMMAND='__git_ps1 "$(virtualenv_prompt)\u@\h:\W" "\\\$ "'

export WORKON_HOME=~/.virtualenvs

# Go
GOPATH=$HOME/gocode
export GOPATH
PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
fi

alias la='ls -la'
alias ll='ls -l'
alias sdr='screen -DR'
alias sx='screen -x'
# git
alias gp='git pull'
alias gb='git branch'
alias gcb='git checkout -b'
alias gcm='git checkout master'
alias grm='git fetch; git rebase origin/master'
