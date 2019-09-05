# GNU and BSD (macOS) ls flags aren't compatible
ls --version &>/dev/null
if [ $? -eq 0 ]; then
  lsflags="--color --group-directories-first -F"
else
  lsflags="-GF"
  export CLICOLOR=1
fi

# Set current directory as a terminal title
case $TERM in
    xterm*)
        precmd () {print -Pn "\e]0;%~\a"}
        ;;
esac

# Aliases
alias ls="ls ${lsflags}"
alias la="ls ${lsflags} -la"
alias svim='sudo vim'
alias tailf='tail -f -n 1000'
alias -r g='git'
alias gp='git push'
alias r='ranger'
alias ydl='noglob youtube-dl -o "%(title)s.%(ext)s"'
alias ydl-mp3='noglob youtube-dl -x --audio-format mp3 -o "%(title)s.%(ext)s"'
alias zip-package='7z a -mx=0'

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

# Source local config
if [[ -s "$HOME/.zshrc_local" ]]; then
    source "$HOME/.zshrc_local"
fi
