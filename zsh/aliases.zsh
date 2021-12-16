
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias spec='nocorrect spec'
alias rspec='nocorrect rspec'
alias ll="ls -l"
alias la="ls -a"
alias l.='ls -ld .[^.]*'
alias lsd='ls -ld *(-/DN)'
alias cd..='cd ..'
alias ..='cd ..'
alias spec='spec -c'
alias heroku='nocorrect heroku'
alias cat='bat'
alias ping='prettyping --nolegend'
alias ls='exa -la --git'

if [ -f "/opt/homebrew/bin/bat" ]; then
  alias cat='bat'
else
  alias cat='batcat'
fi

if [ -f "/opt/homebrew/bin/nvim" ]; then
  alias vim=/opt/homebrew/bin/nvim
else
  alias vim=/usr/bin/nvim
fi

alias ssh='TERM=xterm-256color ssh'
alias preview="fzf --preview 'bat --color \"always\" {}'"
