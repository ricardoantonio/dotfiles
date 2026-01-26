# ZSH My Custom Configuration

# Initialize autocompletion
autoload -U compinit; compinit

# Starship config file
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# ---- PATH Configuration ----
# Go binaries
if command -v go &> /dev/null; then
  export PATH=$PATH:$(go env GOPATH)/bin
fi

# PostgreSQL
export PATH=/opt/homebrew/opt/postgresql@16/bin:$PATH

# ---- Development Folders ----
alias dev="cd ~/Developer"
alias work="cd ~/Developer/work"
alias proj="cd ~/Developer/projects"
alias exp="cd ~/Developer/experiments"
alias oss="cd ~/Developer/opensource"

# ---- Tools Aliases ----
alias v=nvim
alias reload="source ~/.zshrc"
alias ls="eza --icons"
alias ll="eza --icons -l"
alias la="eza --icons -la"
alias cr="cargo run"

# ---- History Configuration ----
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify

# ---- Key Bindings ----
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

# ---- Plugins ----
# Load zsh-syntax-highlighting if available
if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
  echo "zsh-syntax-highlighting not found"
fi

# Load zsh-autosuggestions if available
if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
else
  echo "zsh-autosuggestions not found"
fi

# ---- fzf ----
if command -v fzf &> /dev/null; then
  source <(fzf --zsh)
else
  echo "fzf not found"
fi

# ---- zoxide ----
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh --cmd cd)"
else
  echo "zoxide not found"
fi

# ---- yazi ----
if command -v yazi &> /dev/null; then
  function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
else
  echo "yazi not found"
fi

# ---- Starship Prompt ----
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
else
  echo "starship not found"
fi
