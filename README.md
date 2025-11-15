# Intro
This is my dotfiles repo. It's personal, but perhaps it can be useful to others.

# Adding script folder using stow
```zsh
~/.dotfiles: stow tmux
```

# Packages I like or require
zsh
tmux
tmux tpm
oh-my-zsh
neovim
stow
lazygit
ripgrep
fzf
tmuxinator
dua-cli
eza

# References
https://dev.to/andrenbrandao/terminal-setup-with-zsh-tmux-dracula-theme-48lm

# zsh aliases
To remember, may vary depending on system

```sh
# Brew completion
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
fi

# Starship
eval "$(starship init zsh)"
 
# Refresh ssh autocomplete
function refresh_ssh_autocomplete () {
    host_list=($(cat ~/.ssh/config | grep 'Host '  | awk '{s = s $2 " "} END {print s}'))
    zstyle ':completion:*:(ssh|scp|sftp):*' hosts $host_list
}
refresh_ssh_autocomplete
 
# uuidgen, lower case, no dash
alias uuidgenlc="uuidgen | tr '[:upper:]' '[:lower:]' | sed 's/-//g'"
 
# editor
export EDITOR="$(which nvim)"
 
# tmuxinator
alias t=tmuxinator
alias vi=nvim

# eza
alias l="eza -lhg --icons --git"
alias lt="eza -lhg --icons --git --tree"
alias lt1="eza -lhg --icons --git --tree --level=1"
alias lt2="eza -lhg --icons --git --tree --level=2"
alias lt3="eza -lhg --icons --git --tree --level=3"
 
# Mise
eval "$(mise activate zsh)"
 
# zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
 
# Autosuggest should be lighter
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#75715e'

# opencode
export PATH=/Users/tkg/.opencode/bin:$PATH
```
