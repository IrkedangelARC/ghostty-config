# Quick Start Guide

For busy people who just want it working. Full details in [COMPLETE_SETUP.md](COMPLETE_SETUP.md).

## Prerequisites
```bash
# Install Ghostty from https://ghostty.org/
# Then install dependencies:
brew install tmux zsh-autosuggestions font-jetbrains-mono

# Install TPM (tmux plugin manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## Install (5 minutes)
```bash
# 1. Clone this repo
cd ~/projects
git clone https://github.com/IrkedangelARC/ghostty-config.git
cd ghostty-config

# 2. Install configs
mkdir -p ~/.config/ghostty
cp config ~/.config/ghostty/config
cp tmux/.tmux.conf ~/.tmux.conf
mkdir -p ~/.tmux/scripts
cp tmux/scripts/*.sh ~/.tmux/scripts/
chmod +x ~/.tmux/scripts/*.sh

# 3. Install shell config (backup yours first!)
cp ~/.zshrc ~/.zshrc.backup  # if you have existing config
cp shell/.zshrc ~/.zshrc
source ~/.zshrc

# 4. Restart Ghostty
# Cmd-Q to quit, then relaunch

# 5. Install tmux plugins
# Inside tmux, press: Ctrl-a then I (capital i)
```

## Done!
You should now have:
- Catppuccin Mocha theme
- Auto-starting tmux with dual status bars
- Git-aware prompt
- JetBrains Mono font
- Real-time system monitoring

## Key Commands
- **Tmux prefix**: `Ctrl-a` (not Ctrl-b)
- **Dev layout**: `Ctrl-a + d`
- **Split horizontal**: `Ctrl-a + |`
- **Split vertical**: `Ctrl-a + -`
- **Navigate panes**: `Ctrl-a + h/j/k/l`
- **Quick terminal**: `Cmd + /`

## Troubleshooting
See [COMPLETE_SETUP.md](COMPLETE_SETUP.md#-troubleshooting) for detailed help.

## Not Working?
1. Check Ghostty version: `ghostty --version` (need 1.2.0+)
2. Check tmux version: `tmux -V` (need 3.2+)
3. Verify scripts are executable: `ls -l ~/.tmux/scripts/`
4. Open an issue with error details
