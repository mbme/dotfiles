if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $path
)

# Temporary Files
if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"



# GNU and BSD (macOS) ls flags aren't compatible
ls --version &>/dev/null
if [ $? -eq 0 ]; then
  lsflags="--color --group-directories-first -F"
else
  lsflags="-GF"
  export CLICOLOR=1
fi



# Current title tweaks
autoload -Uz add-zsh-hook

# Set current directory as a terminal title
function set-title-precmd() {
  printf "\e]2;%s\a" "${PWD/#$HOME/~}"
}
add-zsh-hook precmd set-title-precmd

# Add current command to terminal title
function set-title-preexec() {
  printf "\e]2;%s\a" "${PWD/#$HOME/~} > $1"
}
add-zsh-hook preexec set-title-preexec



# Aliases
alias ls="ls ${lsflags} -lh"
alias la="ls ${lsflags} -lah"
alias df="df -h"
alias svim='sudo vim'
alias tailf='tail -f -n 1000'
alias -r g='git'
alias gp='git push'
alias gpull='git pull'
alias tree='tree -hsFC --du --dirsfirst'



# History
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt append_history           # allow multiple sessions to append to one history
setopt bang_hist                # treat ! special during command expansion
setopt extended_history         # Write history in :start:elasped;command format
setopt hist_expire_dups_first   # expire duplicates first when trimming history
setopt hist_find_no_dups        # When searching history, don't repeat
setopt hist_ignore_dups         # ignore duplicate entries of previous events
setopt hist_ignore_space        # prefix command with a space to skip it's recording
setopt hist_reduce_blanks       # Remove extra blanks from each command added to history
setopt hist_verify              # Don't execute immediately upon history expansion
setopt inc_append_history       # Write to history file immediately, not when shell quits
setopt share_history            # Share history among all sessions



# search in history with Up/Down
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search   # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Tab completion
autoload -Uz compinit && compinit
setopt complete_in_word         # cd /ho/sco/tm<TAB> expands to /home/scott/tmp
setopt auto_menu                # show completion menu on succesive tab presses
setopt autocd                   # cd to a folder just by typing it's name

# Keybindings
bindkey -e

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line 
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

unsetopt beep

# Starship https://starship.rs/
eval "$(starship init zsh)"

# Send desktop notifications after long-running commands https://github.com/MichaelAquilina/zsh-auto-notify
source "$HOME/.zsh/auto-notify.plugin.zsh"

# Source local config
if [[ -s "$HOME/.zshrc_local" ]]; then
    source "$HOME/.zshrc_local"
fi


export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8

export EDITOR=vim
export VISUAL=vim
export PAGER=less
export TERM=xterm-256color

export LESS="-r -i -J" # smart ignore case during search, render color text


# Execute code that does not affect the current session in the background.
{
  # Compile the completion dump to increase startup speed.
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!
