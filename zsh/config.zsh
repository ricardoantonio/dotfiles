# ZSH My Custom Configuration

# ============================================
# Performance: Start zprof if needed
# ============================================
# Uncomment to profile ZSH startup time
# zmodload zsh/zprof

# ============================================
# Completion System
# ============================================
# Initialize autocompletion with cache
autoload -Uz compinit

# Speed up compinit by only checking once a day
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Completion menu
zstyle ':completion:*' menu select

# Colorful completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Better completion for kill command
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

# Cache completions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# ============================================
# Environment Variables
# ============================================
# Starship config file
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Editor preferences
export EDITOR='nvim'
export VISUAL='nvim'

# Default language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Less configuration (better paging)
export LESS='-R -F -X -i -M'
export LESSCHARSET='UTF-8'

# ============================================
# PATH Configuration
# ============================================
# Go binaries
if command -v go &> /dev/null; then
  export GOPATH=$(go env GOPATH)
  export PATH=$PATH:$GOPATH/bin
  export GOPRIVATE=git.rasoftwarelabs.com*
fi

# PostgreSQL
export PATH=/opt/homebrew/opt/postgresql@16/bin:$PATH

# ============================================
# Development Folders
# ============================================
alias dev="cd ~/Developer"
alias work="cd ~/Developer/work"
alias proj="cd ~/Developer/projects"
alias exp="cd ~/Developer/experiments"
alias oss="cd ~/Developer/opensource"

# Quick access to config
alias config="cd ~/.config"
alias nvimconfig="cd ~/.config/nvim"

# ============================================
# Tools Aliases
# ============================================
# Editor
alias v='nvim'
alias vim='nvim'
alias vi='nvim'

# Shell
alias reload="source ~/.zshrc"
alias zshconfig="nvim ~/.config/zsh/config.zsh"

# File listing (eza)
alias ls="eza --icons"
alias ll="eza --icons -l"
alias la="eza --icons -la"
alias lt="eza --icons --tree"
alias l="eza --icons -lah"

# Directory navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Git aliases
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"
alias glog="git log --oneline --graph --decorate"
alias glg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias lg="lazygit"

# Rust/Cargo
alias cr="cargo run"
alias cb="cargo build"
alias ct="cargo test"
alias cc="cargo check"
alias cw="cargo watch"

# Python
alias py="python3"
alias pip="pip3"
alias venv="python3 -m venv"
alias activate="source venv/bin/activate"

# Node/npm
alias ni="npm install"
alias nr="npm run"
alias nrd="npm run dev"
alias nrb="npm run build"

# Safety nets
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# Utilities
if command -v bat >/dev/null 2>&1; then
  alias cat="bat --style=auto"
fi
alias ping="ping -c 5"
alias wget="wget -c"
alias df="df -h"
alias du="du -h"
alias grep="grep --color=auto"
alias diff="diff --color=auto"

# macOS specific
alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
alias brewup="brew update && brew upgrade && brew cleanup"
alias flushdns="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder"

# ============================================
# Functions
# ============================================

# Create a directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Extract various archive formats
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.tar.xz)    tar xJf "$1"     ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar x "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Find process by name
psgrep() {
  ps aux | grep -v grep | grep -i -e VSZ -e "$1"
}

# Create backup of a file
backup() {
  cp "$1" "${1}.backup-$(date +%Y%m%d-%H%M%S)"
}

# Quick server for current directory
serve() {
  local port="${1:-8000}"
  python3 -m http.server "$port"
}

# Git clone and cd into it
gcl() {
  git clone "$1" && cd "$(basename "$1" .git)"
}

# Make file executable
mkexec() {
  chmod +x "$1"
}

# Get my public IP
myip() {
  curl -s https://api.ipify.org
}

# Weather report
weather() {
  curl -s "wttr.in/${1:-}"
}

# Cheat sheet
cheat() {
  curl -s "cheat.sh/$1"
}

# ============================================
# History Configuration
# ============================================
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

# History options
setopt append_history           # Append to history file
setopt extended_history         # Save timestamp
setopt hist_expire_dups_first   # Expire duplicates first
setopt hist_ignore_dups         # Don't record duplicates
setopt hist_ignore_space        # Don't record commands starting with space
setopt hist_verify              # Show command with history expansion before running
setopt inc_append_history       # Add commands immediately
setopt share_history            # Share history between sessions
setopt hist_reduce_blanks       # Remove superfluous blanks

# ============================================
# Directory Navigation Options
# ============================================
setopt auto_cd                  # cd by just typing directory name
setopt auto_pushd               # Push directory to stack
setopt pushd_ignore_dups        # Don't push duplicates
setopt pushdminus               # Swap meaning of cd +1 and cd -1

# ============================================
# Miscellaneous Options
# ============================================
setopt correct                  # Command correction
setopt interactive_comments     # Allow comments in interactive mode
setopt multios                  # Implicit tees and cats
setopt prompt_subst             # Enable parameter expansion

# ============================================
# Key Bindings
# ============================================
# Use emacs key bindings (or use -v for vi mode)
bindkey -e

# History search
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
bindkey '^R' history-incremental-search-backward

# Better word navigation
bindkey '^[[1;5C' forward-word       # Ctrl+Right
bindkey '^[[1;5D' backward-word      # Ctrl+Left

# Delete key
bindkey '^[[3~' delete-char

# Home and End keys
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# ============================================
# Plugins
# ============================================

# Load zsh-syntax-highlighting
if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  
  # Custom highlighting styles
  ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
  ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan,bold'
  ZSH_HIGHLIGHT_STYLES[builtin]='fg=yellow,bold'
  ZSH_HIGHLIGHT_STYLES[function]='fg=blue,bold'
fi

# Load zsh-autosuggestions
if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  
  # Autosuggestion settings
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
fi

# ============================================
# fzf Configuration
# ============================================
if command -v fzf &> /dev/null; then
  source <(fzf --zsh)
  
  # fzf settings
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  
  # fzf colors (Catppuccin Mocha)
  export FZF_DEFAULT_OPTS="
    --height 40% --layout=reverse --border
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
  "
  
  # fzf git integration
  fgit() {
    git log --oneline --graph --color=always | 
    fzf --ansi --preview 'echo {} | grep -o "[a-f0-9]\{7\}" | head -1 | xargs git show --color=always' |
    grep -o "[a-f0-9]\{7\}" | head -1
  }
fi

# ============================================
# zoxide Configuration
# ============================================
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh --cmd cd)"
fi

# ============================================
# bat Configuration
# ============================================
if command -v bat &> /dev/null; then
  export BAT_THEME="Catppuccin Mocha"
  alias cat="bat --style=auto"
fi

# ============================================
# Yazi Configuration
# ============================================
if command -v yazi &> /dev/null; then
  function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if IFS= read -r -d '' cwd < "$tmp" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
  }
fi

# ============================================
# Starship Prompt
# ============================================
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# ============================================
# Local Configuration
# ============================================
# Load local zsh configuration if it exists
# Use this for machine-specific settings
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi

# ============================================
# Performance: End zprof
# ============================================
# Uncomment to see ZSH startup time
# zprof
