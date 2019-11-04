
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

alias vim=/usr/local/bin/nvim
alias ssh='TERM=xterm-256color ssh'
alias preview="fzf --preview 'bat --color \"always\" {}'"
