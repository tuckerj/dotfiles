# ZSH
# Last update: 01/12/2019

# %B%F Enable fg colour and bold - blue (normal), green (insert)
# %2~ Path (strat with ~ if below HOME) with max 2 trailing entries
# (1j,[%j].) If 1 or more jobs show [jobs] otherwise null
# %# # if escalated privileges otherwise 
# %B%F%K Stop using bold/fg/bg
NORMAL_PS1="%B%F{blue}%2~ %(1j.[%j].)%# %b%f%k"
INSERT_PS1="%B%F{green}%2~ %(1j.[%j].)%# %b%f%k"
PS1=$INSERT_PS1

# Vi mode
# Set line editor to select prompt based on mode
zle-keymap-select () {
  case $KEYMAP in
    vicmd) PS1=$NORMAL_PS1 ;;
    viins|main) PS1=$INSERT_PS1 ;;
  esac
  zle reset-prompt
}

zle -N zle-keymap-select
zle-line-init () {
  zle -K viins
}

zle -N zle-line-init
bindkey -v

# Some command emacs bindings (for conpatibility)
# Common emacs bindings for vi mode
bindkey '\e[3~'   delete-char
bindkey '^A'      beginning-of-line
bindkey '^E'      end-of-line
bindkey '^R'      history-incremental-pattern-search-backward

# Enable corrections
setopt CORRECT
setopt CORRECT_ALL

# Case insensitive globbing
setopt NO_CASE_GLOB

# Automatic CD
setopt AUTO_CD

# History

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
# 081119 	Initial config for macOS 10.15
# 011219	Changed prompt and added colour highlight for VIM Mode
#			Added some emacs mappings for shell
