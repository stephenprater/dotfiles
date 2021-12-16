# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# Auto-completion
# ---------------
if [ -f "/opt/homebrew/opt/fzf"]; then
  [[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null
  source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
else
  [[ $- == *i* ]] && source "/usr/share/doc/fzf/examples/completion.zsh"
  source "/usr/share/doc/fzf/examples/key-bindings.zsh"
fi

# Key bindings
# ------------
