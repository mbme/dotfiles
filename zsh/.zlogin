# Based on Prezto
# Executes commands at login post-zshrc.

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

# Source local config
if [[ -s "$HOME/.zlogin_local" ]]; then
  source "$HOME/.zlogin_local"
fi
