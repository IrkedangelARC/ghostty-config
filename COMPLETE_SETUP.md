# Complete Ghostty + Tmux Terminal Setup

This is the complete catalog of my terminal environment configuration that creates the visual appearance and workflow you see in Claude Code sessions.

## 🎯 What This Setup Provides

- **Ghostty Terminal**: Fast GPU-accelerated terminal with Catppuccin Mocha theme
- **Tmux Integration**: Automatic session management with custom status bars
- **Custom Status Scripts**: Real-time system monitoring (CPU, RAM, network, git)
- **Enhanced ZSH**: Git-aware prompt with autosuggestions
- **Optimized Fonts**: JetBrains Mono with custom rendering settings

## 📦 Required Software

### 1. Ghostty Terminal
```bash
# Download from https://ghostty.org/ or use Homebrew
brew install --cask ghostty
```
**Version**: 1.2.3 (stable)

### 2. Core Dependencies
```bash
# Install via Homebrew
brew install tmux zsh-autosuggestions font-jetbrains-mono

# Or install individually:
brew install tmux                      # Terminal multiplexer
brew install zsh-autosuggestions       # Shell autosuggestions
brew install font-jetbrains-mono       # Monospace font
```

### 3. Tmux Plugin Manager (TPM)
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## 🚀 Installation Steps

### Step 1: Clone This Repository
```bash
cd ~/projects
git clone https://github.com/IrkedangelARC/ghostty-config.git
cd ghostty-config
```

### Step 2: Install Ghostty Configuration
```bash
# Create config directory if it doesn't exist
mkdir -p ~/.config/ghostty

# Copy Ghostty config
cp config ~/.config/ghostty/config
```

### Step 3: Install Tmux Configuration
```bash
# Copy tmux config
cp tmux/.tmux.conf ~/.tmux.conf

# Create scripts directory and copy all scripts
mkdir -p ~/.tmux/scripts
cp tmux/scripts/*.sh ~/.tmux/scripts/
chmod +x ~/.tmux/scripts/*.sh
```

### Step 4: Install Shell Configuration
```bash
# Backup existing zshrc if you have one
cp ~/.zshrc ~/.zshrc.backup

# Install new zshrc (or merge with your existing one)
cp shell/.zshrc ~/.zshrc

# Reload shell
source ~/.zshrc
```

### Step 5: Install Tmux Plugins
```bash
# Start tmux
tmux

# Inside tmux, press: Ctrl-a + I (capital i)
# This will install all tmux plugins listed in .tmux.conf
```

## 📁 Complete File Structure

```
~/
├── .config/
│   └── ghostty/
│       └── config                    # Ghostty configuration
├── .tmux.conf                        # Tmux configuration
├── .tmux/
│   ├── scripts/                      # Status bar scripts
│   │   ├── cpu-status.sh            # CPU usage monitor
│   │   ├── memory-status.sh         # RAM usage monitor
│   │   ├── network-status.sh        # Network speed monitor
│   │   ├── git-status.sh            # Git branch/status
│   │   └── python-venv.sh           # Python venv indicator
│   └── plugins/
│       └── tpm/                      # Tmux Plugin Manager
└── .zshrc                            # ZSH configuration
```

## 🎨 Visual Components Breakdown

### Ghostty Configuration Features
- **Theme**: Catppuccin Mocha (built-in)
- **Background**: 95% opacity with 20px blur radius
- **Font**: JetBrains Mono, 19pt with thickening enabled
- **Selection**: Purple highlight (#cba6f7) for visibility
- **Auto-tmux**: Each new Ghostty window starts its own tmux session
- **Clipboard**: Auto-copy on selection, OSC 52 support for tmux/vim

### Tmux Status Bar (Two Lines)

**Top Line (Workflow Information)**:
- Session name and window number
- Git status (branch, ahead/behind, dirty files, stashes)
- Python virtual environment (if active)
- Current directory path
- Time and date

**Bottom Line (System Monitoring)**:
- Prefix key reminder (Ctrl-a)
- Network speed (upload/download)
- RAM usage and available memory
- CPU usage percentage

### Color Scheme (Catppuccin Mocha)
```
Base:      #1e1e2e  (darkest background)
Mantle:    #181825  (status bar background)
Surface0:  #313244  (subtle background)
Text:      #cdd6f4  (main text)
Lavender:  #b4befe  (session/window)
Sapphire:  #74c7ec  (git info)
Sky:       #89dceb  (directory/cpu)
Mauve:     #cba6f7  (time/ram)
```

### ZSH Prompt
```
~/projects/ghostty-config [main] ❯
│                          │      │
└─ Cyan: current path      │      └─ Green: prompt
                           └─ Yellow: git branch
```

## ⚙️ Key Configuration Details

### Tmux Keybindings
- **Prefix**: `Ctrl-a` (not the default Ctrl-b)
- **Dev Layout**: `Ctrl-a + d` - Creates 3-pane layout for Claude Code
- **Split Horizontal**: `Ctrl-a + |`
- **Split Vertical**: `Ctrl-a + -`
- **Navigate Panes**: `Ctrl-a + h/j/k/l` (vim-style)
- **Resize Panes**: `Ctrl-a + H/J/K/L` (fine) or `Ctrl-a + Shift-Arrow` (coarse)
- **Reload Config**: `Ctrl-a + r`

### Ghostty Keybindings
- **Quick Terminal**: `Cmd + /` (global hotkey)
- **Better Enter**: `Shift + Enter` (sends escape sequence)

### Tmux Plugins (Installed via TPM)
- `tmux-plugins/tpm` - Plugin manager
- `tmux-plugins/tmux-sensible` - Sensible defaults
- `tmux-plugins/tmux-yank` - Clipboard integration
- `tmux-plugins/tmux-resurrect` - Save/restore sessions
- `tmux-plugins/tmux-continuum` - Auto-save sessions
- `tmux-plugins/tmux-battery` - Battery status (laptops)

## 🔧 Customization Guide

### Change Font Size
Edit `~/.config/ghostty/config`:
```
font-size = 19    # Change to your preferred size (12-24 recommended)
```

### Change Theme
List available themes:
```bash
ghostty +list-themes
```

Edit `~/.config/ghostty/config`:
```
theme = "Catppuccin Mocha"    # Change to any available theme
```

### Disable Auto-Tmux
Edit `~/.config/ghostty/config`, comment out:
```
# command = /opt/homebrew/bin/tmux new-session
```

### Customize Status Bar Update Frequency
Edit `~/.tmux.conf`:
```
set -g status-interval 2    # Change to desired seconds (1-10)
```

### Modify Dev Layout Proportions
Edit `~/.tmux.conf` around line 36:
```bash
# Change -p 40 to adjust right pane width (40 = 40%)
split-window -h -p 40 -c "#{pane_current_path}"
```

## 🐛 Troubleshooting

### Ghostty doesn't apply theme
1. Check theme name: `ghostty +list-themes | grep Catppuccin`
2. Restart Ghostty completely (Cmd-Q, then relaunch)
3. Verify config location: `~/.config/ghostty/config`

### Tmux status bar not showing
1. Check if scripts are executable: `ls -l ~/.tmux/scripts/`
2. Make executable: `chmod +x ~/.tmux/scripts/*.sh`
3. Check tmux version: `tmux -V` (need 3.2+)
4. Reload tmux: `Ctrl-a + r` or restart tmux

### Font not rendering correctly
1. Verify installation: `fc-list | grep JetBrains`
2. Reinstall font: `brew reinstall font-jetbrains-mono`
3. Restart Ghostty

### ZSH autosuggestions not working
1. Check installation: `brew list zsh-autosuggestions`
2. Verify source line in `~/.zshrc`:
   ```bash
   source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
   ```
3. Reload: `source ~/.zshrc`

### Scripts showing errors or "─"
1. Check script permissions: `ls -l ~/.tmux/scripts/`
2. Test individually: `~/.tmux/scripts/git-status.sh $(pwd)`
3. Check for missing dependencies (bc, netstat, vm_stat)

## 📊 System Requirements

- **OS**: macOS (scripts use macOS-specific commands)
- **Shell**: ZSH (default on macOS 10.15+)
- **Ghostty**: 1.2.0+
- **Tmux**: 3.2+
- **Homebrew**: Latest version

## 🔄 Updating

To update this configuration:
```bash
cd ~/projects/ghostty-config
git pull
cp config ~/.config/ghostty/config
cp tmux/.tmux.conf ~/.tmux.conf
cp tmux/scripts/*.sh ~/.tmux/scripts/
```

## 📝 Notes

### Why Two Status Lines?
The dual status bar separates workflow information (top) from system monitoring (bottom), reducing visual clutter while maximizing information density.

### Why Auto-Start Tmux?
Starting tmux automatically in Ghostty provides:
- Session persistence (detach/reattach)
- Multiple panes and windows
- Infinite scrollback
- Session restoration after crashes

### Why JetBrains Mono?
- Excellent programming ligatures
- Clear distinction between similar characters (0/O, 1/l/I)
- Good at small and large sizes
- Professional appearance

## 🤝 Contributing

This is a personal configuration, but feel free to fork and customize. If you find bugs in the scripts or have improvements, open an issue or PR.

## 📄 License

MIT License - Use and modify freely.

---

**Created by**: Mike G (ARC Event Productions)
**Repository**: https://github.com/IrkedangelARC/ghostty-config
**Last Updated**: November 2024
