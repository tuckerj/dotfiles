# ZSH
# Last update: 08/11/2019

# Use VI keymappings
# Esc or C-[ to enter command mode.
bindkey -v

# Enable corrections
setopt CORRECT
setopt CORRECT_ALL

# Case insensitive globbing
setopt NO_CASE_GLOB

# Automatic CD
setopt AUTO_CD

# Store history in HOME
HISTFILE=~/.zsh_history
# share hstory across multiple zsh sessions
setopt SHARE_HISTORY
# append to history
setopt APPEND_HISTORY

# Increase history file size
SAVEHIST=5000
HISTSIZE=2000

# Add detail to history - time, command and duration
setopt extended_history

# Add commands as typed rather than shell exit
setopt INC_APPEND_HISTORY

# Options to prune/limit history file
# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST
# do not store duplicates
setopt HIST_IGNORE_DUPS
# ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# remove blanks from history
setopt HIST_REDUCE_BLANKS

# Environment variables
# Default ls to use color
export CLICOLOR=1
# Use custom colors for dark background
export LSCOLORS=GxFxCxDxBxegedabagaced
export VISUAL="vim"
export EDITOR="$VISUAL"

# Changes
# 081119 Initial config for macOS 10.15
