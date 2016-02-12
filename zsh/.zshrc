#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
alias svim='sudo vim'
alias tailf='tail -f -n 1000'
alias -r g='git'
alias r='ranger'
alias vg='vagrant'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'
alias cd..='cd ..'

alias ydl='noglob youtube-dl -o "%(title)s.%(ext)s"'
alias ydl-mp3='noglob youtube-dl -x --audio-format mp3 -o "%(title)s.%(ext)s"'
alias zip-package='7z a -mx=0'

# Source local config
if [[ -s "$HOME/.zshrc_local" ]]; then
    source "$HOME/.zshrc_local"
fi
