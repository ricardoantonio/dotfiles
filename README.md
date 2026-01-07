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
├── htop/             # Htop system monitor configuration
├── nvim/             # Neovim configuration (LazyVim)
├── starship/         # Starship prompt configuration
├── zellij/           # Zellij terminal multiplexer configuration
├── zsh/              # ZSH shell configuration
├── install.sh        # Installation script
└── check-installation.sh  # Verification script
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

### Verify Installation

```bash
chmod +x check-installation.sh
./check-installation.sh
```

## 📦 What Gets Installed

### Terminal & Shell
- Ghostty - Modern terminal emulator
- ZSH - Enhanced shell with syntax highlighting and autosuggestions
- Starship - Fast, customizable prompt
- Zellij - Terminal multiplexer

### Development Tools
- Neovim - Modern text editor
- LazyGit - Simple terminal UI for Git
- Ripgrep - Fast text search
- Fd - Simple, fast file finder
- Fzf - Command-line fuzzy finder
- Zoxide - Smart directory navigator
- Eza - Modern replacement for ls

### Programming Languages
- Python
- Node.js (v24 LTS)
- Deno
- Go
- Java (JDK 17)

### Applications
- Visual Studio Code
- Alfred - Application launcher
- Firefox Developer Edition
- Google Chrome
- Obsidian - Note-taking app
- Yaak - API client
- DbGate - Database client

### Fonts
- JetBrains Mono
- JetBrains Mono Nerd Font
- Cascadia Code
- Hack Nerd Font

## ⚙️ Post-Installation

After installation, your shell will be configured with:

- Catppuccin Mocha theme across all tools
- Custom aliases for faster navigation
- Enhanced Git configuration
- Modern CLI tools replacing system defaults
- PostgreSQL database service running

### Useful Aliases

```bash
dev    # cd ~/Developer
work   # cd ~/Developer/work
proj   # cd ~/Developer/projects
exp    # cd ~/Developer/experiments
v      # Open Neovim
reload # Reload ZSH configuration
ls     # eza with icons
ll     # eza long format with icons
```

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

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

These are my personal dotfiles, but feel free to fork and adapt them to your needs!

## 🙏 Acknowledgments

- [Homebrew](https://brew.sh/) for package management
- [Starship](https://starship.rs/) for the prompt
- [Catppuccin](https://github.com/catppuccin) for the color scheme
- Various open source tools that make this setup possible