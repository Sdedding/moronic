#!/usr/bin/env bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Path to your project directory
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Load custom completions
if [ -d "$DOTFILES_DIR/completion" ]; then
    for file in "$DOTFILES_DIR"/completion/*; do
        [ -f "$file" ] && source "$file"
    done
fi

# Load all aliases
if [ -d "$DOTFILES_DIR/aliases" ]; then
    for file in "$DOTFILES_DIR"/aliases/*; do
        [ -f "$file" ] && . "$file"
    done
fi

# Load all functions
if [ -d "$DOTFILES_DIR/functions" ]; then
    for file in "$DOTFILES_DIR"/functions/*; do
        [ -f "$file" ] && source "$file"
    done
fi

# Load all plugins
if [ -d "$DOTFILES_DIR/plugins" ]; then
    for file in "$DOTFILES_DIR"/plugins/*; do
        [ -f "$file" ] && source "$file"
    done
fi

# Load theme if it exists
if [ -f "$DOTFILES_DIR/themes/current" ]; then
    source "$DOTFILES_DIR/themes/current"
fi