[ -r ~/.bashrc ] && source ~/.bashrc

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
if [ -e /Users/jamesog/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/jamesog/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
