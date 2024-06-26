fpath=($DOTHOME/functions $fpath)

autoload -U $DOTHOME/functions/*(:t)

# color term
export CLICOLOR=1
# export LSCOLORS=Dxfxcxdxbxegedabadacad
# export ZLS_COLORS=$LSCOLORS
export LC_CTYPE=en_US.UTF-8
export LESS=FRX

# make with the pretty colors
autoload colors; colors

# history
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=10000

setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt HIST_VERIFY
setopt SHARE_HISTORY # share history between sessions ???
setopt EXTENDED_HISTORY # add timestamps to history
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt APPEND_HISTORY # adds history
setopt INC_APPEND_HISTORY SHARE_HISTORY  # adds history incrementally and share it across sessions
setopt HIST_IGNORE_ALL_DUPS  # don't record dupes in history
setopt HIST_REDUCE_BLANKS

ZSH_AUTOSUGGEST_STRATEGY=(completion history)

# Bindings

# emacs keybindings
bindkey -v

# use incremental search
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward

bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

bindkey '^Y' vi-cmd-mode

# external editor support
# autoload edit-command-line
# zle -N edit-command-line
# bindkey '^x^e' edit-command-line

# Partial word history completion
# bindkey '\ep' up-line-or-search
# bindkey '\en' down-line-or-search
# bindkey '\ew' kill-region


