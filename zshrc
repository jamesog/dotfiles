# Left prompt is set in precmd but the equivalent is:
# PS1='%B%F{cyan}%m %F{blue}%5(~|%-1~/(..%)/%2~|%~)%f%b $(__git_ps1 "(%s) ")%F{green}%#%f '
# Right prompt has time and date
RPS1="%* %D"

WORDCHARS=${WORDCHARS//[-\/]}
setopt appendhistory
setopt histignoredups
setopt extendedhistory
setopt histnostore
#setopt extended_glob
setopt complete_in_word
setopt nohup
setopt alwaystoend
setopt correct
setopt nobeep
setopt promptsubst

bindkey -e
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

export EDITOR=vim
LESS='-aiM'
export PAGER=less

alias ls='ls -FG'
alias ll='ls -l'
alias gp='git pull'
alias gc='git commit'
alias gcb='git checkout -b'
alias gcm='git checkout master'
alias wip='whois -h whois.cymru.com'

typeset -U path
path=($path $(go env GOPATH)/bin)

autoload -Uz compinit && compinit
zmodload zsh/complist
zstyle ':completion:*' menu select=2

if whence port >/dev/null; then
	zstyle ':completion:*:*:git:*' script /opt/local/share/git/contrib/completion/git-completion.zsh
	source /opt/local/share/git/contrib/completion/git-prompt.sh
elif whence brew >/dev/null; then
	zstyle ':completion:*:*:git:*' script /usr/local/etc/bash_completion.d/git-completion.bash
	source /usr/local/etc/bash_completion.d/git-prompt.sh
fi

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWCOLORHINTS=true

precmd() {
	local MACHINE
	if [[  -n "$SSH_CONNECTION" ]]; then
		MACHINE="%B%F{cyan}%m "
	fi
	__git_ps1 "${MACHINE}%B%F{blue}%5(~|%-1~/(..%)/%2~|%~)%f%b" " %F{green}%#%f "
}
