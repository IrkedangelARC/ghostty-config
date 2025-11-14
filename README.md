# Ghostty + Tmux Terminal Configuration

Complete terminal environment configuration for macOS, providing the exact setup used in Claude Code development sessions.

![Ghostty Version](https://img.shields.io/badge/Ghostty-1.2.3-blue)
![Tmux Version](https://img.shields.io/badge/Tmux-3.5+-green)
![macOS](https://img.shields.io/badge/macOS-Sonoma+-black)

## What You Get

This repository contains my complete terminal setup featuring:

- **Ghostty Terminal** with Catppuccin Mocha theme and GPU acceleration
- **Tmux** with auto-start, custom dual status bars, and dev layout keybindings
- **Custom Scripts** for real-time git, CPU, RAM, and network monitoring
- **ZSH Configuration** with git-aware prompt and autosuggestions
- **Optimized Typography** using JetBrains Mono with custom rendering

## Screenshots

### Dual Status Bars
- **Top bar**: Session, git status, Python venv, directory, time/date
- **Bottom bar**: Network speed, RAM usage, CPU percentage
- **Pane borders**: Active pane indicators with command and path

### Color Scheme
Catppuccin Mocha throughout - consistent between Ghostty, tmux, and shell prompt.

## Quick Start

See [QUICK_START.md](QUICK_START.md) for fast installation (5 minutes).

For complete documentation: [COMPLETE_SETUP.md](COMPLETE_SETUP.md)

### TL;DR Installation

```bash
# Install dependencies
brew install tmux zsh-autosuggestions font-jetbrains-mono
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Clone and install
cd ~/projects
git clone https://github.com/IrkedangelARC/ghostty-config.git
cd ghostty-config

# Copy configs
mkdir -p ~/.config/ghostty
cp config ~/.config/ghostty/config
cp tmux/.tmux.conf ~/.tmux.conf
mkdir -p ~/.tmux/scripts
cp tmux/scripts/*.sh ~/.tmux/scripts/
chmod +x ~/.tmux/scripts/*.sh
cp shell/.zshrc ~/.zshrc  # Backup yours first!

# Restart Ghostty, then inside tmux press: Ctrl-a + I
```

## Key Features

### Ghostty Configuration
- Catppuccin Mocha theme (built-in)
- 95% opacity with 20px background blur
- JetBrains Mono 19pt with font thickening
- Auto-copy on text selection
- OSC 52 clipboard support for tmux/vim
- Automatic tmux session on startup

### Tmux Configuration
- **Prefix**: `Ctrl-a` (customized from default)
- **Dev Layout** (`Ctrl-a + d`): 3-pane setup optimized for Claude Code
- Dual status bars with system monitoring
- Custom scripts for git, network, CPU, RAM status
- Heavy pane borders with colored active indicators
- TPM plugin support (yank, resurrect, continuum)

### Shell Configuration
- Git-aware prompt showing branch and status
- ZSH autosuggestions for command history
- Custom aliases for common workflows
- Catppuccin colors in prompt

## File Structure

```
ghostty-config/
├── config                    # Ghostty configuration
├── tmux/
│   ├── .tmux.conf           # Tmux configuration
│   └── scripts/             # Status bar scripts
│       ├── cpu-status.sh
│       ├── memory-status.sh
│       ├── network-status.sh
│       ├── git-status.sh
│       └── python-venv.sh
├── shell/
│   └── .zshrc               # ZSH configuration
├── README.md                # This file
├── QUICK_START.md           # Fast installation guide
└── COMPLETE_SETUP.md        # Comprehensive documentation
```

## Customization

All configurations are heavily commented. Key customization points:

- **Font size**: `~/.config/ghostty/config` line 13
- **Theme**: `~/.config/ghostty/config` line 4 (run `ghostty +list-themes` to see options)
- **Tmux prefix**: `~/.tmux.conf` line 16
- **Dev layout proportions**: `~/.tmux.conf` line 37
- **Status bar colors**: `~/.tmux.conf` lines 150-154
- **Prompt colors**: `~/.zshrc` line 22

## Key Commands Reference

### Tmux (Prefix: Ctrl-a)
| Command | Action |
|---------|--------|
| `Ctrl-a + d` | Create dev layout (3 panes) |
| `Ctrl-a + \|` | Split horizontal |
| `Ctrl-a + -` | Split vertical |
| `Ctrl-a + h/j/k/l` | Navigate panes (vim-style) |
| `Ctrl-a + H/J/K/L` | Resize panes (fine) |
| `Ctrl-a + r` | Reload config |
| `Ctrl-a + z` | Zoom pane |

### Ghostty
| Command | Action |
|---------|--------|
| `Cmd + /` | Toggle quick terminal (global) |
| `Shift + Enter` | Better shell integration |

## Requirements

- macOS (uses macOS-specific commands in scripts)
- Ghostty 1.2.0+
- Tmux 3.2+
- ZSH (default shell on macOS 10.15+)
- Homebrew

## Troubleshooting

See [COMPLETE_SETUP.md - Troubleshooting](COMPLETE_SETUP.md#-troubleshooting) for detailed help.

Common issues:
- **Scripts showing "─"**: Check permissions with `ls -l ~/.tmux/scripts/`
- **Theme not applying**: Restart Ghostty completely (Cmd-Q)
- **Font issues**: `brew reinstall font-jetbrains-mono`

## Contributing

This is a personal configuration, but improvements welcome. Open an issue or PR if you find bugs in the scripts or have enhancements.

## Credits

- **Catppuccin Theme**: [catppuccin/catppuccin](https://github.com/catppuccin/catppuccin)
- **JetBrains Mono**: [JetBrains/JetBrainsMono](https://github.com/JetBrains/JetBrainsMono)
- **Ghostty**: [ghostty.org](https://ghostty.org/)
- **Tmux Plugins**: [tmux-plugins](https://github.com/tmux-plugins)

## License

MIT License - Use and modify freely.

---

**Author**: Mike G (ARC Event Productions)
**Repository**: https://github.com/IrkedangelARC/ghostty-config
**Last Updated**: November 2024
