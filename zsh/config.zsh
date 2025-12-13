# ZSH My Custom Configuration
autoload -U compinit; compinit

# Starship config file
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# ---- PATH Configuration ----
# Go binaries
export PATH=$PATH:$(go env GOPATH)/bin
# Node.js v22 LTS
export PATH=/opt/homebrew/opt/node@22/bin:$PATH
# PostgreSQL
export PATH=/opt/homebrew/opt/postgresql@16/bin:$PATH

# ---- Development Folders ----
alias dev="cd ~/Developer"
alias work="cd ~/Developer/work"
alias proj="cd ~/Developer/projects"
alias exp="cd ~/Developer/experiments"

# ---- Tools Aliases ----
alias v=nvim
alias reload="source ~/.zshrc"
alias ls="eza --icons"
alias ll="eza --icons -l"
alias cr="cargo run"

# ---- Plugins ----
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# ---- zfz ----
source <(fzf --zsh)

# ---- zoxide ----
eval "$(zoxide init zsh --cmd cd)"

# ---- Starship Promp ----
eval "$(starship init zsh)"
