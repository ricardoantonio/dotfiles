#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to check if a command exists
check_command() {
    if command -v $1 &> /dev/null; then
        echo -e "${GREEN}✓${NC} $1 is installed"
    else
        echo -e "${RED}✗${NC} $1 is not installed"
    fi
}

# Function to check if a directory exists
check_directory() {
    if [ -d "$1" ]; then
        echo -e "${GREEN}✓${NC} Directory $1 exists"
    else
        echo -e "${RED}✗${NC} Directory $1 does not exist"
    fi
}

# Function to check if a file exists
check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} File $1 exists"
    else
        echo -e "${RED}✗${NC} File $1 does not exist"
    fi
}

echo "Checking installed commands..."
check_command "git"
check_command "rg"
check_command "nvim"
check_command "zstd"
check_command "fastfetch"
check_command "lazygit"
check_command "eza"
check_command "python3"
check_command "node"
check_command "go"
check_command "psql"
check_command "fzf --version"
check_command "tree"
check_command "zoxide"
check_command "fd"
check_command "sleek --version"

echo -e "\nChecking directories..."
check_directory "$HOME/Developer/projects"
check_directory "$HOME/Developer/work"
check_directory "$HOME/Developer/experiments"
check_directory "$HOME/Developer/opensource"

echo -e "\nChecking configuration files..."
check_file "$HOME/.config/zsh/config.zsh"
check_file "$HOME/.config/git/.gitignore_global"

echo -e "\nChecking Git configuration..."
echo "Git user.name: $(git config --global user.name)"
echo "Git user.email: $(git config --global user.email)"
echo "Git excludesfile: $(git config --global core.excludesfile)"

echo -e "\nChecking PostgreSQL service..."
if brew services list | grep postgresql@16 | grep started > /dev/null; then
    echo -e "${GREEN}✓${NC} PostgreSQL service is running"
else
    echo -e "${RED}✗${NC} PostgreSQL service is not running"
fi

echo -e "\nChecking ZSH configuration..."
if grep "source ~/.config/zsh/config.zsh" ~/.zshrc > /dev/null; then
    echo -e "${GREEN}✓${NC} ZSH configuration is loaded"
else
    echo -e "${RED}✗${NC} ZSH configuration is not loaded"
fi
