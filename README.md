# Kozak's Public Dotfiles

Modern cross-platform development environment configuration using [chezmoi](https://chezmoi.io) for seamless setup across macOS, Linux, and WSL2.

## Features

- **Cross-platform setup:** macOS, Linux, and WSL2 support
- **Safe installation:** Configurable package installation with safety checks  
- **Modern shell:** Zsh + Oh My Zsh + Starship prompt
- **Terminal multiplexer:** TMUX with modern Zellij-inspired UX
- **Development tools:** Go, Python3, Node.js (via NVM), Neovim, Git with Delta
- **Template-based:** Prompts for personal information, no hardcoded values
- **Maintainable:** Clean, well-documented configurations

## Quick Start

### Prerequisites

- **macOS:** Command Line Tools (`xcode-select --install`)
- **Linux/WSL2:** `build-essential`, `curl`, `git`
  ```bash
  sudo apt update && sudo apt install build-essential curl git
  ```

### Installation

1. **Install chezmoi:**
   ```bash
   sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
   export PATH=$HOME/.local/bin:$PATH
   ```

2. **Initialize and apply:**
   ```bash
   chezmoi init --apply daniil-lyalko/kozak-public-dotfiles
   ```
   
   You'll be prompted for:
   - Git commit name and email
   - GPG signing key (optional)

3. **Restart your terminal** to load the new configuration

That's it! The installation script runs automatically and sets up your entire development environment.

## What Gets Installed

### Essential Tools (Always Installed)
- **Shell:** Zsh, Oh My Zsh, Starship prompt
- **Development:** Git, Neovim, Ripgrep, Tree-sitter
- **Languages:** Python 3, Go
- **Node.js:** NVM (Node Version Manager)

### Optional Tools (Configurable)
- **Containers:** Docker
- **Infrastructure:** Terraform, AWS CLI, Infracost  
- **Terminal multiplexer:** TMUX (with cross-platform optimization)

### Configuration Files
- **Git:** Modern configuration with Delta diff viewer
- **Neovim:** Complete AstroNvim setup with LSP, formatting, linting
- **Starship:** Custom prompt with Git integration
- **TMUX:** Modern terminal multiplexer with Zellij-inspired UX

## Customization

### Environment Variables
Control what gets installed:
```bash
# Skip optional tools
INSTALL_OPTIONAL_TOOLS=false chezmoi apply

# Skip specific tools  
INSTALL_DOCKER=false INSTALL_TERRAFORM=false chezmoi apply

# Change default shell (requires manual confirmation)
CHANGE_DEFAULT_SHELL=true chezmoi apply
```

### Editing Configurations
1. **Navigate to source:** `chezmoi cd`
2. **Edit files:** Modify templates and configurations
3. **Apply changes:** `chezmoi apply`
4. **Commit changes:** Standard git workflow

### Manual Steps (If Needed)
After installation, you may want to:
```bash
# Install Node.js LTS
source ~/.zshrc && nvm install --lts

# Launch Neovim to install plugins
nvim
```

## Cross-Platform Terminal Setup

This configuration provides consistent terminal multiplexing across platforms:

### TMUX Features
- **Modern UX:** Zellij-inspired discoverable interface
- **Theme:** Catppuccin Mocha with context-aware status bar
- **Cross-platform:** Works with any terminal emulator
- **Smart clipboard:** Automatic integration (clip.exe, pbcopy, xclip)
- **Vi-style:** Intuitive navigation and copy mode

### Platform Integration
The setup automatically:
1. Detects platform (WSL2, macOS, Linux)
2. Installs appropriate clipboard utilities
3. Configures smart clipboard integration
4. Provides session templates and layouts

## Repository Structure

```
├── run_once_install-packages.sh.tmpl  # Main installation script
├── dot_zshrc                          # Shell configuration  
├── dot_gitconfig.tmpl                 # Git configuration (templated)
├── dot_config/
│   ├── starship.toml                  # Prompt configuration
│   ├── tmux/                        # TMUX configuration and layouts
│   └── exact_nvim/                    # Complete Neovim setup
├── .chezmoi.toml.tmpl                # Chezmoi configuration
└── .chezmoiignore                    # Files to ignore
```

## Updating

To pull and apply the latest changes:
```bash
chezmoi update
```

## Safety Features

- **Non-destructive:** Won't overwrite existing configurations without backup
- **Graceful failures:** Installation continues even if individual packages fail
- **Version awareness:** Checks for existing tools before installing
- **Template-based:** No hardcoded personal information
- **Configurable:** Environment variables control what gets installed

## Troubleshooting

### Common Issues
- **Permission errors:** Ensure your user has sudo access or run without optional tools
- **Network timeouts:** Check internet connection, especially for Homebrew
- **WSL path issues:** Ensure Windows username detection is working correctly

### Debug Commands
```bash
# Check chezmoi status
chezmoi doctor

# Verify installations
nvm --version
starship --version  
nvim --version

# Check shell configuration
source ~/.zshrc
```

## Contributing

This is a personal dotfiles repository, but feel free to:
- Fork for your own use
- Submit issues for bugs
- Suggest improvements via pull requests

## License

MIT License - Feel free to use and modify for your own setup. 