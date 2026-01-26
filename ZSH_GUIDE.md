# ZSH Configuration Guide

Comprehensive documentation for the custom ZSH configuration in `~/.config/zsh/config.zsh`

---

## 📑 Table of Contents

1. [Overview](#overview)
2. [Completion System](#completion-system)
3. [Environment Variables](#environment-variables)
4. [Aliases](#aliases)
5. [Functions](#functions)
6. [History](#history)
7. [Key Bindings](#key-bindings)
8. [Plugins](#plugins)
9. [Tool Integrations](#tool-integrations)

---

## 🌟 Overview

This configuration provides:
- **Smart completion** with caching and case-insensitive matching
- **50+ aliases** for common tasks
- **10+ utility functions** for productivity
- **Modern tool integrations** (fzf, zoxide, bat, yazi)
- **Enhanced history** (50k commands with sharing)
- **Catppuccin Mocha** theme across tools

---

## 🔄 Completion System

### Features

```zsh
# Case insensitive
cd desktop  # Works with "Desktop"

# Menu selection
kill <TAB>  # Navigate with arrows

# Colorful output
ls <TAB>    # Colors match ls output
```

### Cache
- Checks once per day for speed
- Stored in `~/.zsh/cache`

---

## 🌍 Environment Variables

| Variable | Value | Purpose |
|----------|-------|---------|
| `EDITOR` | `nvim` | Default editor |
| `VISUAL` | `nvim` | Visual editor |
| `LANG` | `en_US.UTF-8` | Language setting |
| `STARSHIP_CONFIG` | `~/.config/starship/starship.toml` | Prompt config |
| `BAT_THEME` | `Catppuccin Mocha` | Bat color theme |
| `GOPATH` | Auto-detected | Go workspace |

---

## 📂 Aliases

### Navigation

| Alias | Command | Description |
|-------|---------|-------------|
| `dev` | `cd ~/Developer` | Go to Developer |
| `work` | `cd ~/Developer/work` | Go to work projects |
| `proj` | `cd ~/Developer/projects` | Go to personal projects |
| `exp` | `cd ~/Developer/experiments` | Go to experiments |
| `oss` | `cd ~/Developer/opensource` | Go to open source |
| `config` | `cd ~/.config` | Go to config directory |
| `nvimconfig` | `cd ~/.config/nvim` | Go to Neovim config |
| `..` | `cd ..` | Go up one directory |
| `...` | `cd ../..` | Go up two directories |
| `....` | `cd ../../..` | Go up three directories |
| `.....` | `cd ../../../..` | Go up four directories |

### Editor

| Alias | Command | Description |
|-------|---------|-------------|
| `v` | `nvim` | Open Neovim |
| `vim` | `nvim` | Open Neovim |
| `vi` | `nvim` | Open Neovim |

### Shell

| Alias | Command | Description |
|-------|---------|-------------|
| `reload` | `source ~/.zshrc` | Reload ZSH config |
| `zshconfig` | `nvim ~/.config/zsh/config.zsh` | Edit ZSH config |

### File Listing

| Alias | Command | Description |
|-------|---------|-------------|
| `ls` | `eza --icons` | List files with icons |
| `ll` | `eza --icons -l` | List files (long format) |
| `la` | `eza --icons -la` | List all files (long format) |
| `lt` | `eza --icons --tree` | List files as tree |
| `l` | `eza --icons -lah` | List all files (human readable) |

### Git

| Alias | Command | Description |
|-------|---------|-------------|
| `g` | `git` | Git shorthand |
| `gs` | `git status` | Show status |
| `ga` | `git add` | Stage files |
| `gc` | `git commit` | Commit changes |
| `gcm` | `git commit -m` | Commit with message |
| `gp` | `git push` | Push to remote |
| `gpl` | `git pull` | Pull from remote |
| `gd` | `git diff` | Show differences |
| `gco` | `git checkout` | Checkout branch/file |
| `gb` | `git branch` | List branches |
| `glog` | `git log --oneline --graph --decorate` | Short log with graph |
| `glg` | Pretty formatted log | Colorful log with details |
| `lg` | `lazygit` | Open LazyGit |

### Rust/Cargo

| Alias | Command | Description |
|-------|---------|-------------|
| `cr` | `cargo run` | Run Rust project |
| `cb` | `cargo build` | Build Rust project |
| `ct` | `cargo test` | Run tests |
| `cc` | `cargo check` | Check for errors |
| `cw` | `cargo watch` | Watch for changes |

### Python

| Alias | Command | Description |
|-------|---------|-------------|
| `py` | `python3` | Run Python 3 |
| `pip` | `pip3` | Python package manager |
| `venv` | `python3 -m venv` | Create virtual environment |
| `activate` | `source venv/bin/activate` | Activate virtual environment |

### Node/npm

| Alias | Command | Description |
|-------|---------|-------------|
| `ni` | `npm install` | Install packages |
| `nr` | `npm run` | Run npm script |
| `nrd` | `npm run dev` | Run dev script |
| `nrb` | `npm run build` | Run build script |

### Safety

| Alias | Command | Description |
|-------|---------|-------------|
| `rm` | `rm -i` | Remove with confirmation |
| `cp` | `cp -i` | Copy with confirmation |
| `mv` | `mv -i` | Move with confirmation |

### Utilities

| Alias | Command | Description |
|-------|---------|-------------|
| `cat` | `bat --style=auto` | Better cat with syntax highlighting |
| `ping` | `ping -c 5` | Ping 5 times |
| `wget` | `wget -c` | Resume downloads |
| `df` | `df -h` | Disk space (human readable) |
| `du` | `du -h` | Disk usage (human readable) |
| `grep` | `grep --color=auto` | Colorful grep |
| `diff` | `diff --color=auto` | Colorful diff |

### macOS Specific

| Alias | Command | Description |
|-------|---------|-------------|
| `showfiles` | Toggle hidden files visibility | Show hidden files in Finder |
| `hidefiles` | Toggle hidden files visibility | Hide hidden files in Finder |
| `brewup` | `brew update && brew upgrade && brew cleanup` | Update all Homebrew packages |
| `flushdns` | Clear DNS cache | Flush DNS cache |

---

## 🛠️ Functions

### `mkcd <directory>`
Create a directory and cd into it

```bash
mkcd new-project
# Creates and enters new-project/
```

### `extract <file>`
Extract any archive format automatically

```bash
extract archive.tar.gz
extract file.zip
extract data.rar
# Detects format automatically
```

**Supported formats:**
- `.tar.bz2`, `.tar.gz`, `.tar.xz`
- `.bz2`, `.gz`, `.zip`, `.rar`
- `.tar`, `.tbz2`, `.tgz`
- `.Z`, `.7z`

### `psgrep <process>`
Find processes by name

```bash
psgrep node
# Shows all node processes
```

### `backup <file>`
Create timestamped backup of a file

```bash
backup important.txt
# Creates: important.txt.backup-20250126-143052
```

### `serve [port]`
Start HTTP server in current directory

```bash
serve        # Port 8000 (default)
serve 3000   # Port 3000
```

### `gcl <repo-url>`
Git clone and cd into repository

```bash
gcl https://github.com/user/repo.git
# Clones and enters repo/
```

### `mkexec <file>`
Make file executable

```bash
mkexec script.sh
# Equivalent to: chmod +x script.sh
```

### `myip`
Show your public IP address

```bash
myip
# Returns: 123.45.67.89
```

### `weather [location]`
Display weather report

```bash
weather           # Current location
weather London    # Specific city
```

### `cheat <command>`
Quick reference/cheat sheet

```bash
cheat tar
cheat git
cheat python
```

---

## 📜 History Configuration

### Settings

```zsh
HISTFILE=~/.zsh_history
HISTSIZE=50000    # 50k commands in memory
SAVEHIST=50000    # 50k commands saved
```

### Options

| Option | Description |
|--------|-------------|
| `append_history` | Append to history file |
| `extended_history` | Save timestamp with commands |
| `hist_expire_dups_first` | Remove duplicates first |
| `hist_ignore_dups` | Don't record duplicates |
| `hist_ignore_space` | Ignore commands starting with space |
| `hist_verify` | Show command before running from history |
| `inc_append_history` | Add commands immediately |
| `share_history` | Share between sessions |
| `hist_reduce_blanks` | Remove extra spaces |

### Usage

```bash
# Search backward in history
↑  # With prefix matching

# Search forward in history
↓  # With prefix matching

# Incremental search
Ctrl+R
```

---

## ⌨️ Key Bindings

### Navigation

| Key | Action |
|-----|--------|
| `Ctrl + →` | Next word |
| `Ctrl + ←` | Previous word |
| `Home` | Beginning of line |
| `End` | End of line |
| `Delete` | Delete character |

### History

| Key | Action |
|-----|--------|
| `↑` | Search backward (with prefix) |
| `↓` | Search forward (with prefix) |
| `Ctrl + R` | Incremental search |

### Mode

Emacs mode is enabled by default. To use Vi mode:

```zsh
# Add to config.zsh
bindkey -v  # Instead of bindkey -e
```

---

## 🔌 Plugins

### ZSH Syntax Highlighting

**Features:**
- Highlights valid commands in green
- Shows invalid commands in red
- Colorizes aliases, builtins, functions

**Custom colors:**
- Commands: Green (bold)
- Aliases: Cyan (bold)
- Builtins: Yellow (bold)
- Functions: Blue (bold)

### ZSH Autosuggestions

**Features:**
- Suggests commands from history
- Uses both history and completion
- Subtle gray color (fg=240)
- Max buffer: 20 characters

**Usage:**
- Type a command
- Press `→` to accept suggestion
- Press `Ctrl + →` to accept one word

---

## 🔧 Tool Integrations

### fzf (Fuzzy Finder)

**Default commands:**
```bash
Ctrl+T  # Search files
Ctrl+R  # Search history
Alt+C   # Search directories
```

**Custom function:**
```bash
fgit  # Browse git log with preview
```

**Configuration:**
- Uses `fd` instead of `find`
- Catppuccin Mocha theme
- Shows hidden files (excludes .git)

### zoxide (Smart CD)

**Features:**
- Learns your most-used directories
- Jump to them quickly

**Usage:**
```bash
cd ~/Developer/projects/my-app  # Visit once

# Later, from anywhere:
cd my-app  # Jumps directly there
```

**Note:** Configured with `--cmd cd` to replace standard `cd`

### bat (Better Cat)

**Features:**
- Syntax highlighting
- Line numbers
- Git integration
- Catppuccin Mocha theme

**Usage:**
```bash
cat file.js  # Shows with syntax highlighting
```

### yazi (File Manager)

**Features:**
- Terminal file manager
- Changes directory on exit

**Usage:**
```bash
y          # Open yazi
# Navigate with arrows or j/k
# Press q to exit
# Shell changes to current directory
```

**Keyboard shortcuts in yazi:**
- `j/k` or `↑/↓`: Navigate
- `h/l` or `←/→`: Enter/exit directories
- `q`: Quit (and cd to current location)
- `g`: Go to top
- `G`: Go to bottom
- `/`: Search
- `~`: Go to home

---

## 🎨 Directory Navigation Options

### Auto CD
Just type the directory name to enter it:

```bash
~/Developer/projects  # Automatically cd's there
```

### Auto Pushd
Automatically pushes directories to stack:

```bash
cd project1
cd project2
cd -     # Returns to project1
cd -2    # Go back 2 directories
```

---

## 🚀 Performance

### Profiling

To measure startup time:

```zsh
# Uncomment in config.zsh:
zmodload zsh/zprof  # At start
# ... rest of config ...
zprof               # At end

# Then:
source ~/.zshrc
```

### Optimization

- **Completion cache**: Checks only once per day
- **Conditional loading**: Only loads installed tools
- **Fast startup**: ~200-300ms typical

---

## 📝 Local Configuration

Create `~/.zshrc.local` for machine-specific settings:

```zsh
# Example ~/.zshrc.local

# Work-specific aliases
alias vpn="sudo openvpn --config ~/work.ovpn"

# API keys
export OPENAI_API_KEY="sk-..."

# Project shortcuts
alias myproject="cd ~/Developer/work/my-project && code ."
```

This file is automatically loaded if it exists.

---

## 🔄 Updating Configuration

### Reload config
```bash
reload  # Alias for: source ~/.zshrc
```

### Edit config
```bash
zshconfig  # Opens config.zsh in nvim
```

### Pull updates
```bash
cd ~/.config
git pull
reload
```

---

## 🧪 Testing New Aliases/Functions

Add them temporarily in your terminal:

```bash
# Test an alias
alias mytest="echo 'Testing!'"
mytest

# Test a function
myfunction() {
  echo "Arguments: $@"
}
myfunction hello world

# If it works, add to config.zsh
```

---

## 📚 Resources

- [ZSH Documentation](https://zsh.sourceforge.io/Doc/)
- [Starship Prompt](https://starship.rs/)
- [fzf](https://github.com/junegunn/fzf)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [bat](https://github.com/sharkdp/bat)
- [yazi](https://github.com/sxyazi/yazi)
- [eza](https://github.com/eza-community/eza)
- [Catppuccin](https://github.com/catppuccin/catppuccin)

---

## 🆘 Troubleshooting

### Plugin not found
```bash
# Check if installed
brew list zsh-syntax-highlighting

# Install if missing
brew install zsh-syntax-highlighting zsh-autosuggestions

# Reload
reload
```

### Slow startup
```bash
# Profile to find bottleneck
# Uncomment zprof lines in config.zsh
source ~/.zshrc

# Check what takes longest
```

### Completion not working
```bash
# Rebuild completion cache
rm -f ~/.zcompdump
autoload -U compinit && compinit
```

### History not saving
```bash
# Check permissions
ls -la ~/.zsh_history

# Fix if needed
chmod 600 ~/.zsh_history
```

---

## 💡 Tips & Tricks

### Quick Directory Jumping
```bash
# With auto_cd
Developer  # Enters ~/Developer
..         # Goes up one level
-          # Returns to previous directory
```

### History Tricks
```bash
# Don't save a command (prefix with space)
 secret-command

# Rerun last command
!!

# Rerun command from history
!git  # Runs last git command
```

### Multiple Commands
```bash
# Run sequentially
cmd1 && cmd2 && cmd3

# Run in parallel
cmd1 & cmd2 & cmd3
```

### Redirects
```bash
# Redirect to multiple files (with multios)
echo "test" > file1.txt > file2.txt
```

---

## ⭐ Best Practices

1. **Use aliases for common tasks**
   ```bash
   alias dc="docker-compose"
   alias k="kubectl"
   ```

2. **Create project-specific shortcuts**
   ```bash
   alias myapp="cd ~/Developer/work/myapp && npm run dev"
   ```

3. **Use functions for complex operations**
   ```bash
   deploy() {
     git push && ssh server "cd /app && git pull && pm2 restart app"
   }
   ```

4. **Keep machine-specific config in ~/.zshrc.local**
   - API keys
   - Work vs personal settings
   - Machine-specific paths

5. **Document custom additions**
   ```zsh
   # Project: MyApp deployment
   alias deploy-myapp="..."
   ```

---

## 📄 License

This configuration is part of the dotfiles repository.
Feel free to use, modify, and share!
