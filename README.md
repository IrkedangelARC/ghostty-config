# Ghostty Terminal Configuration

Personal Ghostty terminal emulator configuration for macOS.

## Features

- **Theme**: Catppuccin Mocha color scheme with translucent background
- **Font**: JetBrains Mono at 19pt with thickening enabled
- **Tmux Integration**: Auto-starts tmux session on each new window
- **Enhanced Clipboard**: Auto-copy on selection with OSC 52 support for tmux/vim integration
- **Custom Keybindings**: Quick terminal toggle and improved shift+enter behavior

## Installation

### Prerequisites

- [Ghostty Terminal](https://ghostty.org/)
- [JetBrains Mono Font](https://www.jetbrains.com/lp/mono/)
- [Homebrew](https://brew.sh/) (for tmux)
- tmux: `brew install tmux`

### Setup

1. Clone this repository:
```bash
git clone https://github.com/yourusername/ghostty-config.git
```

2. Copy the config to your Ghostty config directory:
```bash
cp ghostty-config/config ~/.config/ghostty/config
```

3. Restart Ghostty or reload configuration

## Configuration Highlights

### Visual Appearance
- 95% background opacity with 20px blur radius
- Catppuccin Mocha theme
- Sophisticated purple selection colors (#cba6f7)

### Font Settings
- JetBrains Mono with font thickening
- 10% increased cell height for better readability

### Clipboard
- Auto-copy selected text to clipboard
- Trailing whitespace trimming
- Full OSC 52 support for clipboard sharing with tmux and vim

### Tmux Integration
Automatically starts a new tmux session for each terminal window, providing:
- Session persistence
- Split panes and windows
- Scrollback buffer
- Detachable sessions

## Keybindings

- `Shift+Enter`: Send escape sequence for better shell integration
- `Cmd+/`: Global quick terminal toggle

## Customization

Edit `~/.config/ghostty/config` to customize:
- Font family and size (lines 12-14)
- Theme and opacity (lines 4-6)
- Tmux auto-start behavior (line 26)
- Keybindings (lines 62-63)

## License

MIT License - Feel free to use and modify as needed.
