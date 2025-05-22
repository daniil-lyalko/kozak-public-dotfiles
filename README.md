# Public Dotfiles Starter

This repository provides a starter set of configuration files (dotfiles) for setting up a development environment on macOS or Linux (including WSL2 on Windows). It uses [chezmoi](https://chezmoi.io) for management.

## Features

*   Cross-platform setup (macOS, Linux/WSL2)
*   Package installation via [Homebrew](https://brew.sh)
*   Shell setup with Zsh, [Oh My Zsh](https://ohmyz.sh/), and [Starship](https://starship.rs/) prompt
*   Cross-platform terminal emulator via [Wezterm](https://wezfurlong.org/wezterm/) with built-in multiplexer
*   Core development tools: Go, Python3, Node.js (via NVM)
*   Terminal tools: Neovim
*   Sensible defaults and configurations

## Installation

### Prerequisites

*   **macOS:** Command Line Tools (`xcode-select --install`)
*   **Linux/WSL2:** `build-essential`, `curl`, `git` (`sudo apt update && sudo apt install build-essential curl git` or equivalent)
*   **Windows (for WSL2):** Follow the [official WSL installation guide](https://learn.microsoft.com/en-us/windows/wsl/install). We recommend installing Ubuntu from the Microsoft Store.

### Setup Steps

1.  **Install chezmoi:**
    Follow the instructions on [chezmoi.io/install](https://chezmoi.io/install) or run:
   ```bash
   sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
   export PATH=$HOME/.local/bin:$PATH  # Add to your PATH
    ```

2.  **Initialize chezmoi with this repository:**
    Replace `YOUR_GITHUB_USERNAME` with your actual GitHub username where you fork/clone this repo.
    ```bash
    # Add your GitHub username and the repo name
    GITHUB_USER="YOUR_GITHUB_USERNAME"
    REPO_NAME="kozak-public-dotfiles"
    
    # Initialize and apply
    chezmoi init --apply https://github.com/${GITHUB_USER}/${REPO_NAME}.git
   ```
    *   **Prompts:** Chezmoi will prompt you for your name and email address for Git configuration.

3.  **Run the Installation Script:**
    ```bash
    # Run the installation script with your shell
    ~/.local/share/chezmoi/run_install-packages.sh
    ```

4.  **Install Wezterm Cross-Platform Terminal:**
    Wezterm is automatically installed by the script on macOS and Linux systems. For Windows, download it directly from [the Wezterm releases page](https://wezfurlong.org/wezterm/installation.html).

5.  **Restart Your Shell:**
    Close and reopen your terminal, or run `exec zsh`.

## What's Included & Configured

*   **Shell:** Zsh + Oh My Zsh + Starship
*   **Terminal:** Wezterm (cross-platform terminal emulator with consistent experience on macOS, Linux, and Windows)
*   **Package Manager:** Homebrew
*   **Languages:** Go, Python 3, Node.js (LTS via NVM)
*   **Tools:** Neovim, Docker, AWS CLI, Terraform, ripgrep, tree-sitter, infracost
*   **Configuration:** Sensible defaults for Git, Editorconfig, etc.

### Terminal Setup with Wezterm

This configuration uses [Wezterm](https://wezfurlong.org/wezterm/) as the primary terminal emulator across all platforms:

- **Consistent Experience:** Same configuration, appearance, and keybindings on all platforms
- **Built-in Multiplexer:** Split panes and tabs without needing external tools
- **Platform Integration:** Automatically launches WSL2 on Windows
- **Key Bindings:** Uses Ctrl+A as the leader key (similar to tmux)
- **Customization:** Configuration in `~/.config/wezterm/wezterm.lua`

#### Wezterm + WSL2 Integration

When using Wezterm on Windows with WSL2:

1. **Installation:**
   - Install Wezterm on Windows from the [official website](https://wezfurlong.org/wezterm/installation.html)
   - The dotfiles will be applied inside your WSL2 distribution

2. **Automatic WSL Integration:**
   - The configuration automatically detects Windows and sets the default domain to WSL:Debian
   - You may need to change this to match your distribution (Ubuntu, etc.) by editing `~/.config/wezterm/wezterm.lua`

3. **Windows ⟷ WSL Switching:**
   - Press `Ctrl+A` followed by `w` to open a Windows PowerShell tab
   - Wezterm will automatically use the WSL distribution for new tabs otherwise

4. **Configuration Synchronization:**
   - The Wezterm configuration is stored in your WSL2 distribution at `~/.config/wezterm/wezterm.lua`
   - Copy this to your Windows user directory at `%USERPROFILE%\.wezterm.lua` for best integration

#### Cross-Platform Features

The Wezterm configuration is designed to work seamlessly across macOS, Linux, and Windows:

- Detects your OS and applies appropriate settings
- Uses consistent keybindings regardless of platform
- Adapts font rendering and window behavior to each OS

**Common Keybindings:**
- `Ctrl+A` then `|` - Split horizontally
- `Ctrl+A` then `-` - Split vertically
- `Ctrl+A` then `h/j/k/l` - Navigate between panes
- `Ctrl+A` then `c` - Create new tab
- `Ctrl+A` then `n/p` - Next/previous tab
- `Ctrl+A` then `z` - Toggle pane zoom (maximize/restore)
- `Ctrl+A` then `r` - Reload configuration

## Customization

1.  **Edit Files:** Navigate to `~/.local/share/chezmoi` (or run `chezmoi cd`) and edit the template files.
2.  **Apply Changes:** Run `chezmoi apply`.
3.  **Commit & Push:** Commit your changes to your fork/clone.

## Troubleshooting

*   **Homebrew Issues:** Check the [Homebrew documentation](https://docs.brew.sh/). Ensure dependencies are met.
*   **WSL2 Issues:** Consult the [WSL troubleshooting guide](https://learn.microsoft.com/en-us/windows/wsl/troubleshooting).
*   **chezmoi Issues:** Refer to the [chezmoi documentation](https://www.chezmoi.io/).
*   **Wezterm + WSL Integration Issues:**
    - Ensure your WSL distribution matches what's in the config (change `WSL:Debian` if necessary)
    - Try copying `~/.config/wezterm/wezterm.lua` to `%USERPROFILE%\.wezterm.lua` on Windows
    - Check [Wezterm WSL documentation](https://wezfurlong.org/wezterm/config/lua/wezterm/target_triple.html) for troubleshooting

## Contributing

Feel free to fork this repository and adapt it to your needs. If you find bugs or have suggestions for improvement applicable to a general audience, please open an issue or pull request.

## License

This project is licensed under the MIT License - see the LICENSE file for details (You may want to add a LICENSE file). 