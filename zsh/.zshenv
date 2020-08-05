# Based on Prezto
# Defines environment variables.

export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8

export EDITOR=vim
export VISUAL=vim
export PAGER=less
export TERM=xterm-256color

export LESS="-r -i -J" # smart ignore case during search, render color text

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprofile"
fi
