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

print_section "Checking Installed Commands"
check_command "git" && ((passed++)) || ((failed++))
check_command "rg" && ((passed++)) || ((failed++))
check_command "nvim" && ((passed++)) || ((failed++))
check_command "zstd" && ((passed++)) || ((failed++))
check_command "fastfetch" && ((passed++)) || ((failed++))
check_command "lazygit" && ((passed++)) || ((failed++))
check_command "eza" && ((passed++)) || ((failed++))
check_command "python3" && ((passed++)) || ((failed++))
check_command "node" && ((passed++)) || ((failed++))
check_command "go" && ((passed++)) || ((failed++))
check_command "psql" && ((passed++)) || ((failed++))
check_command "fzf" && ((passed++)) || ((failed++))
check_command "tree" && ((passed++)) || ((failed++))
check_command "zoxide" && ((passed++)) || ((failed++))
check_command "fd" && ((passed++)) || ((failed++))
check_command "sleek" && ((passed++)) || ((failed++))

print_section "Checking Directories"
check_directory "$HOME/Developer/projects" && ((passed++)) || ((failed++))
check_directory "$HOME/Developer/work" && ((passed++)) || ((failed++))
check_directory "$HOME/Developer/experiments" && ((passed++)) || ((failed++))
check_directory "$HOME/Developer/opensource" && ((passed++)) || ((failed++))

print_section "Checking Configuration Files"
check_file "$HOME/.config/zsh/config.zsh" && ((passed++)) || ((failed++))
check_file "$HOME/.config/git/.gitignore_global" && ((passed++)) || ((failed++))

print_section "Checking Git Configuration"
echo "Git user.name: $(git config --global user.name)"
echo "Git user.email: $(git config --global user.email)"
echo "Git excludesfile: $(git config --global core.excludesfile)"

print_section "Checking Services"
check_service "postgresql@16" && ((passed++)) || ((failed++))

print_section "Checking ZSH Configuration"
if grep "source ~/.config/zsh/config.zsh" ~/.zshrc >/dev/null; then
  echo -e "${GREEN}✓${NC} ZSH configuration is loaded"
  ((passed++))
else
  echo -e "${RED}✗${NC} ZSH configuration is not loaded"
  ((failed++))
fi

# Print final summary
print_summary $passed $failed
