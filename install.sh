#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
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

# Collect all required information upfront
print_section "Configuration"
read -p "Enter your Git name: " git_name
read -p "Enter your Git email: " git_email

# Confirm inputs
echo -e "\nConfirming your inputs:"
echo "Git name: $git_name"
echo "Git email: $git_email"
read -p "Is this correct? (y/N) " confirm
if [[ $confirm != "y" && $confirm != "Y" ]]; then
  print_error "Installation cancelled"
  exit 1
fi

# Install and configure Git
print_section "Installing Git"
brew install git

print_section "Configuring Git"
git config --global user.name "$git_name"
git config --global user.email "$git_email"
git config --global init.defaultBranch main
git config --global color.ui auto
git config --global core.excludesfile ~/.config/git/.gitignore_global

# Install terminal tools
brew install --cask ghostty
brew install zsh-syntax-highlighting
brew install zsh-autosuggestions
brew install ripgrep
brew install neovim
brew install zstd
brew install fastfetch
brew install lazygit
brew install starship
brew install eza
brew install git
brew install fzf
brew install tree
brew install zoxide
brew install fd
brew install sleek    # Sql formatter
brew install watchman # react native watcher

# Install fonts
brew install --cask font-jetbrains-mono
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-cascadia-code
brew install --cask font-inter
brew install --cask font-roboto
brew install --cask font-hack-nerd-font

# Install other tools
brew install --cask visual-studio-code
brew install --cask yaak
brew install --cask dbgate
brew install --cask firefox@developer-edition
brew install --cask google-chrome

# Install utilities
brew install music-presence
brew install --cask tor-browser

# Install programing tools and languages
brew install python
brew install node@22
brew install go
brew install --cask zulu@17 # JDK 17

# Instalation of PostgreSQL
brew install postgresql@16
sleep 2 # Give time for service registration

# Try to start the service
if brew services start postgresql@16; then
  print_success "PostgreSQL service started"
else
  print_error "Failed to start PostgreSQL service"
  echo "Waiting a few more seconds and trying again..."
  sleep 3
  if brew services start postgresql@16; then
    print_success "PostgreSQL service started on second attempt"
  else
    print_error "Failed to start PostgreSQL service. You may need to start it manually later"
  fi
fi

# Create Developer directories
print_section "Creating Developer directories"
mkdir -p ~/Developer/{projects,work,experiments,opensource}

# Load custom ZSH configuration
print_section "Configuring ZSH"
echo "# ---- My ZSH Custom Configuration ----" >>~/.zshrc
echo "source ~/.config/zsh/config.zsh" >>~/.zshrc
