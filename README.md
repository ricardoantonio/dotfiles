# dotfiles

My personal configuration files for a complete development environment on macOS.

## 🌟 Overview

This repository contains my personal dotfiles that configure a modern development environment with:

- **Terminal**: Ghostty with ZSH shell
- **Editor**: Neovim with LazyVim configuration
- **Git**: Enhanced Git configuration with global ignore rules
- **Tools**: Modern CLI tools (ripgrep, fd, fzf, zoxide, etc.)
- **Fonts**: Developer-friendly fonts with Nerd Font support
- **Theme**: Catppuccin Mocha color scheme across all tools

## 📁 Repository Structure

```
~/.config/
├── ghostty/          # Ghostty terminal configuration
├── git/              # Git configuration and global ignore rules
├── nvim/             # Neovim configuration (LazyVim)
├── starship/         # Starship prompt configuration
├── zsh/              # ZSH shell configuration
│   └── config.zsh    # Custom ZSH configuration
├── install.sh        # Installation script
├── check-installation.sh  # Verification script
└── gpg-setup.sh      # GPG key setup script
```

## 🛠 Prerequisites

### Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow the instructions displayed after the installation (they might include adding Homebrew to your PATH)

### Clone This Repository

```bash
git clone https://github.com/ricardoantonio/dotfiles.git ~/.config
```

## 🚀 Installation

### Run Installation Script

```bash
cd ~/.config
chmod +x install.sh
./install.sh
```

The installation script will:

1. Configure Git with your name and email
2. Install terminal tools and applications via Homebrew
3. Set up development fonts
4. Install programming languages and tools
5. Configure PostgreSQL database
6. Create development directories
7. Set up ZSH with custom configuration
8. Enable macOS window dragging gestures

### Verify Installation

```bash
chmod +x check-installation.sh
./check-installation.sh
```

## 📦 What Gets Installed

### Terminal & Shell
- **Ghostty** - Modern terminal emulator
- **ZSH Syntax Highlighting** - Syntax highlighting for ZSH commands
- **ZSH Autosuggestions** - Command suggestions based on history
- **Starship** - Fast, customizable prompt
- **Fastfetch** - System information tool

### Development Tools
- **Neovim** - Modern text editor
- **LazyGit** - Simple terminal UI for Git
- **Ripgrep** - Fast text search
- **Fd** - Simple, fast file finder
- **Fzf** - Command-line fuzzy finder
- **Zoxide** - Smart directory navigator
- **Eza** - Modern replacement for ls
- **Tree** - Directory listing tool
- **Yazi** - Terminal file manager
- **Sleek** - SQL formatter

### Media & Processing Tools
- **Poppler** - PDF rendering library
- **FFmpeg** - Video processing tool
- **Resvg** - SVG rendering tool
- **ImageMagick** - Image processing tool
- **Ghostscript** - PostScript interpreter

### Programming Languages
- **Python** - Python programming language
- **Node.js** - JavaScript runtime
- **Go** - Go programming language

### Database
- **PostgreSQL 16** - Advanced open source database

### Applications
- **Alfred** - Application launcher
- **Obsidian** - Note-taking app
- **Sublime Text** - Code editor
- **Yaak** - API client
- **DbGate** - Database client
- **Firefox** - Web browser
- **Google Chrome** - Web browser
- **Tor Browser** - Privacy-focused browser

### Security
- **Bitwarden** - Password manager

### Fonts
- **JetBrains Mono** - Developer font
- **JetBrains Mono Nerd Font** - Developer font with icons
- **Inter** - Modern font
- **Roboto** - Google's font
- **Source Serif 4** - Adobe's font
- **Operator Mono** - Installed manually (external source)

### System Utilities
- **Zstd** - Compression tool

## ⚙️ Post-Installation

After installation, your shell will be configured with:

- Starship prompt with custom configuration
- Enhanced history management with search capabilities
- Modern CLI tools replacing system defaults
- PostgreSQL 16 database service running
- macOS window dragging enabled (drag windows from anywhere)

### Shell Features

The ZSH configuration includes:
- **50+ aliases** for Git, navigation, development tools, and utilities
- **10+ functions** for productivity (mkcd, extract, backup, serve, etc.)
- **Smart completion** with caching and case-insensitive matching
- **Enhanced history** with 50k commands and cross-session sharing
- **Modern key bindings** for efficient navigation

**Quick Examples:**
```bash
# Navigation
dev          # cd ~/Developer
..           # cd .. (up to 5 levels with ...)

# File operations
ls           # eza with icons
y            # yazi file manager (changes dir on exit)

# Git shortcuts
gs           # git status
gcm "msg"    # git commit -m "msg"
lg           # lazygit

# Utilities
mkcd newdir  # mkdir + cd
extract file.tar.gz  # auto-detect format
backup file.txt      # timestamped backup
serve 8080   # quick HTTP server
```

**📖 Full documentation:** See [ZSH_GUIDE.md](ZSH_GUIDE.md) for complete list of aliases, functions, and usage examples.

## 🔐 GPG Setup (Optional)

To configure GPG for signing commits:

```bash
chmod +x gpg-setup.sh
./gpg-setup.sh
```

This script will:
- Generate or reuse a GPG key for your email
- Configure gpg-agent with pinentry-mac
- Configure Git to use the GPG key for signing commits and tags
- Export your public key for upload to GitHub/Forgejo

## 🔄 Updates

To update installed tools:

```bash
brew update && brew upgrade
```

To update this configuration:

```bash
cd ~/.config
git pull
```

## 🧪 Troubleshooting

### If ZSH configuration isn't loading
```bash
source ~/.zshrc
```

### If PostgreSQL service isn't running
```bash
brew services start postgresql@16
```

### If fonts aren't displaying correctly
Log out and back in to macOS, or restart your terminal applications.

### If plugins show "not found" errors
Make sure you've installed the required packages:
```bash
brew install zsh-syntax-highlighting zsh-autosuggestions fzf zoxide starship
```

## 📂 Development Directories

The installation creates the following directory structure:

```
~/Developer/
├── projects/      # Personal projects
├── work/          # Work-related projects
├── experiments/   # Experimental code
└── opensource/    # Open source contributions
```

## 🗑 Uninstallation

To remove Homebrew packages (be careful!):
```bash
# List what will be removed
brew list

# Remove all packages
brew remove --force $(brew list)
```

Manual cleanup:
- Remove custom lines from `~/.zshrc`
- Delete `~/.config` directory
- Remove `~/Developer` directories if no longer needed
- Reset macOS window dragging: `defaults delete -g NSWindowShouldDragOnGesture`

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

These are my personal dotfiles, but feel free to fork and adapt them to your needs!

## 🙏 Acknowledgments

- [Homebrew](https://brew.sh/) for package management
- [Starship](https://starship.rs/) for the prompt
- [Catppuccin](https://github.com/catppuccin) for the color scheme
- Various open source tools that make this setup possible
