#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to check if a command exists
check_command() {
  if command -v $1 &>/dev/null; then
    echo -e "${GREEN}✓${NC} $1 is installed"
    return 0
  else
    echo -e "${RED}✗${NC} $1 is not installed"
    return 1
  fi
}

# Function to check if a directory exists
check_directory() {
  if [ -d "$1" ]; then
    echo -e "${GREEN}✓${NC} Directory $1 exists"
    return 0
  else
    echo -e "${RED}✗${NC} Directory $1 does not exist"
    return 1
  fi
}

# Function to check if a file exists
check_file() {
  if [ -f "$1" ]; then
    echo -e "${GREEN}✓${NC} File $1 exists"
    return 0
  else
    echo -e "${RED}✗${NC} File $1 does not exist"
    return 1
  fi
}

# Function to check service status
check_service() {
  if brew services list | grep $1 | grep started >/dev/null; then
    echo -e "${GREEN}✓${NC} $1 service is running"
    return 0
  else
    echo -e "${RED}✗${NC} $1 service is not running"
    return 1
  fi
}

# Function to check if a cask is installed
check_cask() {
  if brew list --cask $1 &>/dev/null; then
    echo -e "${GREEN}✓${NC} $1 (app) is installed"
    return 0
  else
    echo -e "${RED}✗${NC} $1 (app) is not installed"
    return 1
  fi
}

# Function to print section headers
print_section() {
  echo -e "\n${YELLOW}=== $1 ===${NC}"
}

# Function to print summary
print_summary() {
  local passed=$1
  local failed=$2
  local total=$((passed + failed))

  echo -e "\n${BLUE}=== Summary ===${NC}"
  echo -e "${GREEN}✓${NC} Passed: $passed"
  echo -e "${RED}✗${NC} Failed: $failed"
  echo -e "Total: $total"

  if [ $failed -eq 0 ]; then
    echo -e "\n${GREEN}🎉 All checks passed! Your environment is properly configured.${NC}"
  else
    echo -e "\n${YELLOW}⚠ Some checks failed. Please review the output above.${NC}"
  fi
}

# Initialize counters
passed=0
failed=0

print_section "System Check"
if command -v brew &>/dev/null; then
  echo -e "${GREEN}✓${NC} Homebrew is installed"
  ((passed++))
else
  echo -e "${RED}✗${NC} Homebrew is not installed"
  ((failed++))
fi

print_section "Checking Terminal & Shell Tools"
check_cask "ghostty" && ((passed++)) || ((failed++))
check_command "starship" && ((passed++)) || ((failed++))
check_command "fastfetch" && ((passed++)) || ((failed++))

print_section "Checking ZSH Plugins"
if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  echo -e "${GREEN}✓${NC} zsh-syntax-highlighting is installed"
  ((passed++))
else
  echo -e "${RED}✗${NC} zsh-syntax-highlighting is not installed"
  ((failed++))
fi

if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  echo -e "${GREEN}✓${NC} zsh-autosuggestions is installed"
  ((passed++))
else
  echo -e "${RED}✗${NC} zsh-autosuggestions is not installed"
  ((failed++))
fi

print_section "Checking Development Tools"
check_command "git" && ((passed++)) || ((failed++))
check_command "nvim" && ((passed++)) || ((failed++))
check_command "lazygit" && ((passed++)) || ((failed++))
check_command "rg" && ((passed++)) || ((failed++))
check_command "fd" && ((passed++)) || ((failed++))
check_command "fzf" && ((passed++)) || ((failed++))
check_command "eza" && ((passed++)) || ((failed++))
check_command "tree" && ((passed++)) || ((failed++))
check_command "zoxide" && ((passed++)) || ((failed++))
check_command "yazi" && ((passed++)) || ((failed++))
check_command "sleek" && ((passed++)) || ((failed++))

print_section "Checking Media & Processing Tools"
check_command "pdfinfo" && ((passed++)) || ((failed++)) # from poppler
check_command "ffmpeg" && ((passed++)) || ((failed++))
check_command "resvg" && ((passed++)) || ((failed++))
check_command "convert" && ((passed++)) || ((failed++)) # from imagemagick
check_command "gs" && ((passed++)) || ((failed++))      # from ghostscript

print_section "Checking System Utilities"
check_command "zstd" && ((passed++)) || ((failed++))

print_section "Checking Programming Languages"
check_command "python3" && ((passed++)) || ((failed++))
check_command "node" && ((passed++)) || ((failed++))
check_command "go" && ((passed++)) || ((failed++))

print_section "Checking Database"
check_command "psql" && ((passed++)) || ((failed++))

print_section "Checking Applications"
check_cask "alfred" && ((passed++)) || ((failed++))
check_cask "obsidian" && ((passed++)) || ((failed++))
check_cask "sublime-text" && ((passed++)) || ((failed++))
check_cask "yaak" && ((passed++)) || ((failed++))
check_cask "dbgate" && ((passed++)) || ((failed++))
check_cask "firefox" && ((passed++)) || ((failed++))
check_cask "google-chrome" && ((passed++)) || ((failed++))
check_cask "tor-browser" && ((passed++)) || ((failed++))

print_section "Checking Security Tools"
check_command "bitwarden" && ((passed++)) || ((failed++))

print_section "Checking Fonts"
check_cask "font-jetbrains-mono" && ((passed++)) || ((failed++))
check_cask "font-jetbrains-mono-nerd-font" && ((passed++)) || ((failed++))
check_cask "font-inter" && ((passed++)) || ((failed++))
check_cask "font-roboto" && ((passed++)) || ((failed++))
check_cask "font-source-serif-4" && ((passed++)) || ((failed++))

print_section "Checking Directories"
check_directory "$HOME/Developer/projects" && ((passed++)) || ((failed++))
check_directory "$HOME/Developer/work" && ((passed++)) || ((failed++))
check_directory "$HOME/Developer/experiments" && ((passed++)) || ((failed++))
check_directory "$HOME/Developer/opensource" && ((passed++)) || ((failed++))

print_section "Checking Configuration Files"
check_file "$HOME/.config/zsh/config.zsh" && ((passed++)) || ((failed++))
check_file "$HOME/.config/git/.gitignore_global" && ((passed++)) || ((failed++))

print_section "Checking Git Configuration"
if [ -n "$(git config --global user.name)" ]; then
  echo -e "${GREEN}✓${NC} Git user.name: $(git config --global user.name)"
  ((passed++))
else
  echo -e "${RED}✗${NC} Git user.name is not configured"
  ((failed++))
fi

if [ -n "$(git config --global user.email)" ]; then
  echo -e "${GREEN}✓${NC} Git user.email: $(git config --global user.email)"
  ((passed++))
else
  echo -e "${RED}✗${NC} Git user.email is not configured"
  ((failed++))
fi

if [ "$(git config --global init.defaultBranch)" = "main" ]; then
  echo -e "${GREEN}✓${NC} Git default branch: main"
  ((passed++))
else
  echo -e "${RED}✗${NC} Git default branch is not set to 'main'"
  ((failed++))
fi

git_excludesfile="$(git config --global core.excludesfile)"
if [ "$git_excludesfile" = "$HOME/.config/git/.gitignore_global" ] || [ "$git_excludesfile" = "~/.config/git/.gitignore_global" ]; then
  echo -e "${GREEN}✓${NC} Git excludesfile configured"
  ((passed++))
else
  echo -e "${RED}✗${NC} Git excludesfile is not configured"
  ((failed++))
fi

print_section "Checking Services"
check_service "postgresql@16" && ((passed++)) || ((failed++))

print_section "Checking ZSH Configuration"
if grep "source ~/.config/zsh/config.zsh" ~/.zshrc >/dev/null 2>&1; then
  echo -e "${GREEN}✓${NC} ZSH configuration is loaded in ~/.zshrc"
  ((passed++))
else
  echo -e "${RED}✗${NC} ZSH configuration is not loaded in ~/.zshrc"
  ((failed++))
fi

print_section "Checking macOS Settings"
if defaults read -g NSWindowShouldDragOnGesture 2>/dev/null | grep -q "1"; then
  echo -e "${GREEN}✓${NC} Window dragging gesture is enabled"
  ((passed++))
else
  echo -e "${RED}✗${NC} Window dragging gesture is not enabled"
  ((failed++))
fi

# Print final summary
print_summary $passed $failed
