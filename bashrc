__colour_prompt() {
	local c_red='\[\e[31m\]'
	local c_green='\[\e[32m\]'
	local c_lblue='\[\e[1;34m\]'
	local c_cyan='\[\e[1;36m\]'
	local c_clear='\[\e[0m\]'
	local lhs="${VIRTUAL_ENV:+(${c_green}$(basename ${VIRTUAL_ENV})${c_clear}) }${c_cyan}\h${c_clear} ${c_lblue}\W${c_clear}"
	local rhs

	if [[ $UID == 0 ]]; then
		rhs="${c_red}"'\\$'"${c_clear}"
	else
		rhs="${c_green}"'\\$'"${c_clear}"
	fi
	if type __git_ps1 &>/dev/null; then
		__git_ps1 "$lhs" " $rhs "
	else
		PS1="$lhs $rhs "
	fi
}

#PROMPT_COMMAND='__colour_prompt "${c_cyan}\h${c_clear} ${c_lblue}\W${c_clear}"'
PROMPT_COMMAND='__colour_prompt'

#PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin:/usr/X11/bin:~/bin
# Moved /usr/local/bin first to get Homebrew git
PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:/usr/X11/bin:~/bin
# Python --user
PATH=$PATH:~/Library/Python/3.7/bin:~/Library/Python/2.7/bin
# Postgres
PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
export PATH

export SSH_AUTH_SOCK="/usr/local/var/run/yubikey-agent.sock"

#PS1='\h:\W \u\$ '
# PROMPT_COMMAND='__git_ps1 "\h:\W \u" "\$ "'
# Make bash check its window size after a process completes
shopt -s checkwinsize

HISTCONTROL=ignoredups

# Git prompt stuff
GIT_PS1_SHOWCOLORHINTS=y
GIT_PS1_SHOWDIRTYSTATE=y
GIT_PS1_SHOWSTASHSTATE=y

export MINICOM='-o -w'

#export GOROOT=~/go
export GOPATH=~/gocode
PATH=/usr/local/go/bin:$PATH:$GOPATH/bin:~/.cargo/bin
#PATH=$PATH:$GOPATH/bin

alias ll='ls -l'
alias wip='whois -h whois.cymru.com'

WORKON_HOME=~/.virtualenvs
VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
#source /usr/local/bin/virtualenvwrapper.sh

#export PAGER=/usr/local/bin/vimpager
export PAGER=less
export EDITOR=vim
export LESS='-a -F -i -M -R'
alias less=$PAGER
alias zless=$PAGER
alias gp='git pull'
alias gcb='git checkout -b'
alias gcm='git checkout master'

# Fuck you, Homebrew
HOMEBREW_NO_ANALYTICS=1

alias start_godoc='docker run --name godoc -v /Users:/Users -e GOPATH=/Users/jamesog/gocode -p 6060:6060 -d golang:1.7 godoc -v -http=:6060'

source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'

#export HOMEBREW_GITHUB_API_TOKEN=3ebe709e17bcfe5e5bc1048cf7503a40934f745e
#export SSH_AUTH_SOCK=/Users/jamesog/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
