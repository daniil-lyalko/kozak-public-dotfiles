# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository managed by [chezmoi](https://chezmoi.io), containing cross-platform development environment configurations for macOS, Linux, and WSL2. The setup includes shell configurations, terminal settings, and a complete Neovim development environment.

## Architecture

**Configuration Management**: All dotfiles are managed through chezmoi's templating system:
- Files prefixed with `dot_` become dotfiles (e.g., `dot_zshrc` → `~/.zshrc`)
- Files prefixed with `exact_` maintain exact directory structure
- `.tmpl` suffix enables templating with user-specific variables

**Key Components**:
- **Installation**: `run_once_install-packages.sh.tmpl` - Main installation script that sets up the entire environment
- **Shell**: Zsh + Oh My Zsh + Starship prompt configuration
- **Terminal multiplexer**: TMUX with modern UX and cross-platform optimization
- **Editor**: Complete AstroNvim setup with LSP, formatting, and community plugins

## Common Commands

### Chezmoi Management
```bash
# Navigate to dotfiles source directory
chezmoi cd

# Apply configuration changes
chezmoi apply

# Pull and apply latest changes from repository
chezmoi update

# Check chezmoi status and health
chezmoi doctor
```

### Development Workflow
```bash
# Edit configurations in source directory
chezmoi cd
# Make changes to files
chezmoi apply  # Apply changes to home directory

# Standard git workflow for committing changes
git add .
git commit -m "description"
git push
```

### TMUX Usage
```bash
# Start TMUX session
tmux

# Quick help reference
Ctrl-a + Ctrl-h

# Pre-defined layouts
Ctrl-a + D  # Development layout (editor + terminal)
Ctrl-a + T  # Triple pane layout
Ctrl-a + G  # Git workflow layout
Ctrl-a + M  # Monitoring layout

# Session templates
~/.config/tmux/sessions.sh dev myproject ~/projects/myproject
~/.config/tmux/sessions.sh fullstack webapp ~/code/webapp
~/.config/tmux/sessions.sh monitor

# Plugin management
Ctrl-a + I  # Install plugins
Ctrl-a + U  # Update plugins
```

## Configuration Structure

**Neovim Setup**: Built on AstroNvim v4 with:
- Community packs for: Lua, Markdown, HTML/CSS, JSON
- Custom plugins in `dot_config/exact_nvim/exact_lua/plugins/`
- LSP, formatting, and linting configurations
- UFO folding and custom UI enhancements

**TMUX Configuration**: Modern terminal multiplexer with Zellij-inspired UX:
- Ctrl-a prefix key with intuitive keybindings
- Context-aware status bar with Catppuccin Mocha theme
- Built-in help system (Ctrl-a + Ctrl-h)
- Pre-defined layouts for common workflows (dev, git, monitoring)
- Session templates for different project types
- Vi-style navigation and copy mode
- Neovim integration and automatic session restoration


**Installation Control**: Environment variables control what gets installed:
- `INSTALL_OPTIONAL_TOOLS=false` - Skip all optional tools
- `INSTALL_DOCKER=false` - Skip Docker installation
- `INSTALL_TERRAFORM=false` - Skip Terraform installation
- `CHANGE_DEFAULT_SHELL=true` - Change default shell to Zsh

**Platform Support**: Optimized for your typical environments:
- **WSL2 Ubuntu**: Smart clipboard integration via clip.exe
- **Amazon Linux 2**: yum-based package installation
- **Ubuntu/Debian**: apt-based installation with xclip/xsel
- **macOS (M3 Max)**: Homebrew + pbcopy/pbpaste integration

## Cross-Platform Integration

The configuration is optimized for cross-platform development:
- **WSL2**: Automatic detection with clip.exe clipboard integration
- **Linux**: xclip/xsel clipboard utilities installed based on package manager
- **macOS**: Native pbcopy/pbpaste integration
- **TMUX**: Works seamlessly across all platforms and terminal emulators
- **Universal**: Same TMUX experience whether on local machine or remote SSH