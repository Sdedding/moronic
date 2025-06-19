#!/usr/bin/env bash

set -e  # Exit on error

# Get the directory where the install script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create backup directory with timestamp
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Backup existing .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
    echo "Backing up existing .bashrc to $BACKUP_DIR"
    mv "$HOME/.bashrc" "$BACKUP_DIR/"
fi

# Create necessary directories if they don't exist
mkdir -p "$DOTFILES_DIR"/{aliases,functions,plugins,completion,themes}

# Create symbolic link to our bashrc
echo "Creating symbolic link for .bashrc"
ln -sf "$DOTFILES_DIR/bashrc" "$HOME/.bashrc"

# Add source line to .bash_profile if it doesn't exist
if [ -f "$HOME/.bash_profile" ]; then
    if ! grep -q "source ~/.bashrc" "$HOME/.bash_profile"; then
        echo "Adding source line to .bash_profile"
        echo "[ -f ~/.bashrc ] && source ~/.bashrc" >> "$HOME/.bash_profile"
    fi
else
    echo "Creating .bash_profile"
    echo "[ -f ~/.bashrc ] && source ~/.bashrc" > "$HOME/.bash_profile"
fi

# Create an empty current theme file if it doesn't exist
if [ ! -f "$DOTFILES_DIR/themes/current" ]; then
    touch "$DOTFILES_DIR/themes/current"
fi

# Ensure all directories are created with proper permissions
chmod 755 "$DOTFILES_DIR"/{aliases,functions,plugins,completion,themes}

echo "Installation complete!"
echo "Your previous .bashrc has been backed up to $BACKUP_DIR"
echo "New configuration has been installed."
echo ""
echo "To apply the changes to your current session, run:"
echo "source ~/.bashrc"