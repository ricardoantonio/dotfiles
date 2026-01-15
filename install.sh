#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Function to print section headers
print_section() {
  echo -e "\n${YELLOW}=== $1 ===${NC}"
}

# Function to print success messages
print_success() {
  echo -e "${GREEN}✓ $1${NC}"
}

# Function to print error messages
print_error() {
  echo -e "${RED}✗ $1${NC}"
}

# Function to print info messages
print_info() {
  echo -e "${BLUE}ℹ $1${NC}"
}

# Function to print warning messages
print_warning() {
  echo -e "${PURPLE}⚠ $1${NC}"
}

# Function to check if a command exists
command_exists() {
  command -v "$1" &>/dev/null
}

# Function to validate email format
validate_email() {
  [[ "$1" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]
}

# Function to validate non-empty input
validate_non_empty() {
  [[ -n "$1" && "$1" != " " ]]
}

# Check if Homebrew is installed
print_section "System Check"
if ! command_exists brew; then
  print_error "Homebrew is not installed"
  echo "Please install Homebrew first:"
  echo "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
  exit 1
else
  print_success "Homebrew is installed"
fi

# Function to install package if not already installed
install_if_missing() {
  local package=$1
  local type=${2:-"formula"}
  local description=${3:-"$package"}

  if [[ $type == "cask" ]]; then
    if brew list --cask "$package" &>/dev/null; then
      print_info "$description (cask) is already installed"
    else
      print_info "Installing $description (cask)"
      brew install --cask "$package"
    fi
  else
    if brew list "$package" &>/dev/null; then
      print_info "$description is already installed"
    else
      print_info "Installing $description"
      brew install "$package"
    fi
  fi
}

# Collect all required information upfront with validation
print_section "Configuration"

# Attempt to get existing Git values
git_name=$(git config --global user.name)
git_email=$(git config --global user.email)

# Ask for Git name only if it is not configured
if [[ -z "$git_name" ]]; then
  while true; do
    read -p "Enter your Git name: " git_name
    if validate_non_empty "$git_name"; then
      break
    else
      print_error "Git name cannot be empty"
    fi
  done
fi

# Ask for Git email only if it is not configured
if [[ -z "$git_email" ]]; then
  while true; do
    read -p "Enter your Git email: " git_email
    if validate_email "$git_email"; then
      break
    else
      print_error "Please enter a valid email address"
    fi
  done
fi

# Confirm only if one of the values was empty
if [[ -z "$(git config --global user.name)" || -z "$(git config --global user.email)" ]]; then
  echo -e "\nConfirming your inputs:"
  echo "Git name: $git_name"
  echo "Git email: $git_email"
  read -p "Is this correct? (y/N) " confirm
  if [[ $confirm != "y" && $confirm != "Y" ]]; then
    print_error "Installation cancelled"
    exit 1
  fi
fi

# Install and configure Git
install_if_missing install git

print_section "Configuring Git"
git config --global user.name "$git_name"
git config --global user.email "$git_email"
git config --global init.defaultBranch main
git config --global color.ui auto
git config --global core.excludesfile ~/.config/git/.gitignore_global

# Install terminal tools
print_section "Installing Terminal Tools"
install_if_missing ghostty cask "Ghostty - Modern terminal emulator"
install_if_missing zsh-syntax-highlighting "" "ZSH Syntax Highlighting"
install_if_missing zsh-autosuggestions "" "ZSH Autosuggestions"
install_if_missing ripgrep "" "Ripgrep - Fast text search"
install_if_missing neovim "" "Neovim - Modern text editor"
install_if_missing zellij "" "Zellij - Terminal multiplexer"
install_if_missing zstd "" "Zstd - Compression tool"
install_if_missing fastfetch "" "Fastfetch - System information tool"
install_if_missing lazygit "" "LazyGit - Simple terminal UI for Git"
install_if_missing starship "" "Starship - Fast, customizable prompt"
install_if_missing eza "" "Eza - Modern replacement for ls"
install_if_missing fzf "" "Fzf - Command-line fuzzy finder"
install_if_missing tree "" "Tree - Directory listing tool"
install_if_missing zoxide "" "Zoxide - Smart directory navigator"
install_if_missing fd "" "Fd - Simple, fast file finder"
install_if_missing yazi "" "Yazi - Terminal file manager"
install_if_missing poppler "" "Poppler - PDF rendering library"
install_if_missing ffmpeg "" "FFmpeg - Video processing tool"
install_if_missing resvg "" "Resvg - SVG rendering tool"
install_if_missing imagemagick "" "ImageMagick - Image processing tool"
install_if_missing ghostscript "" "Ghostscript - PostScript interpreter"
install_if_missing sleek "" "Sleek - SQL formatter"

# Install fonts
print_section "Installing Fonts"
install_if_missing font-jetbrains-mono cask "JetBrains Mono - Developer font"
install_if_missing font-jetbrains-mono-nerd-font cask "JetBrains Mono Nerd Font - Developer font with icons"
install_if_missing font-inter cask "Inter - Modern font"
install_if_missing font-roboto cask "Roboto - Google's font"
install_if_missing font-hack-nerd-font cask "Hack Nerd Font - Monospaced font with icons"
install_if_missing font-noto-sans cask "Noto Sans - Google's font"
install_if_missing font-source-serif-4 cask "Source Serif 4 - Adobe's font"
install_if_missing sf-symbols cask "SF Symbols - symbols from apple"

# Install other tools
print_section "Installing Applications"
install_if_missing alfred cask "Alfred - Application launcher"
install_if_missing obsidian cask "Obsidian - Note taken app"
install_if_missing visual-studio-code cask "Visual Studio Code - Code editor"
install_if_missing yaak cask "Yaak - API client"
install_if_missing dbgate cask "DbGate - Database client"
install_if_missing firefox cask "Firefox - Web browser"
install_if_missing firefox@developer-edition cask "Firefox Developer Edition - Web browser"
install_if_missing google-chrome cask "Google Chrome - Web browser"
install_if_missing bitwarden "" "Bitwarden - Password manager"

# Install utilities
print_section "Installing Utilities"
install_if_missing tor-browser cask "Tor Browser - Privacy-focused browser"

# Install programming tools and languages
print_section "Installing Programming Tools"
install_if_missing python "" "Python - Programming language"
install_if_missing node@24 "" "Node.js v24 LTS - JavaScript runtime"
install_if_missing go "" "Go - Programming language"
install_if_missing deno "" "Deno JavaScript runtime"

# Installation of PostgreSQL
print_section "Installing PostgreSQL"
install_if_missing postgresql@16 "" "PostgreSQL v16 - Database system"
sleep 2 # Give time for service registration

# Try to start the service
print_section "Starting PostgreSQL Service"
if brew services start postgresql@16; then
  print_success "PostgreSQL service started"
else
  print_warning "Failed to start PostgreSQL service"
  echo "Waiting a few more seconds and trying again..."
  sleep 3
  if brew services start postgresql@16; then
    print_success "PostgreSQL service started on second attempt"
  else
    print_error "Failed to start PostgreSQL service. You may need to start it manually later"
  fi
fi

### Install windowtiling
print_section "Installing Tiling Window Manager"
brew tap FelixKratz/formulae
install_if_missing sketchybar "" "Sketchybar - macOS status bar replacement"
chmod +x ~/.config/sketchybar/plugins/*.sh
install_if_missing nikitabobko/tap/aerospace "cask" "AeroSpace - tiling window manager for macOS"
brew tap FelixKratz/formulae
install_if_missing borders "" "JankyBorders - Highlighting the focused window"
#### Move windows by dragging any part of the window
defaults write -g NSWindowShouldDragOnGesture -bool true

# Backup existing .zshrc if it exists
print_section "Configuring ZSH"
if [ -f ~/.zshrc ]; then
  print_info "Backing up existing .zshrc to .zshrc.backup"
  cp ~/.zshrc ~/.zshrc.backup
fi

# Create Developer directories
print_section "Creating Developer directories"
mkdir -p ~/Developer/{projects,work,experiments,opensource}
print_success "Developer directories created"

# Load custom ZSH configuration
print_section "Configuring ZSH"
# Remove any existing configuration lines to avoid duplicates
grep -v "source ~/.config/zsh/config.zsh" ~/.zshrc 2>/dev/null >~/.zshrc.tmp || touch ~/.zshrc.tmp
mv ~/.zshrc.tmp ~/.zshrc
echo "# ---- My ZSH Custom Configuration ----" >>~/.zshrc
echo "source ~/.config/zsh/config.zsh" >>~/.zshrc
print_success "ZSH configuration completed"

print_section "Installation Complete"
echo -e "${GREEN}🎉 Installation completed successfully!${NC}"
echo ""
echo "Next steps:"
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. Verify installation with: ./check-installation.sh"
echo "3. Explore your new development environment!"
