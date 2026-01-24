#!/usr/bin/env bash

set -euo pipefail

echo "Updating Termux repositories..."
termux-change-repo

# Update and upgrade packages
echo "Updating and upgrading packages..."
pkg update
pkg upgrade

# Install terminal applications
echo "Installing terminal applications..."
pkg install chezmoi helix eza fzf zoxide yazi bat zsh fd ripgrep lazygit dust duf

# Install Git and SSH
echo "Installing Git and SSH..."
pkg install openssh openssl
echo "Generating missing SSH host keys..."
ssh-keygen -A 

# Configure Git
echo "Configuring Git..."
pkg install git
git config --global user.name "golixp-termux"
git config --global user.email "golixp@outlook.com"
git config --global core.quotepath false

# Apply dotfiles using chezmoi
echo "Applying dotfiles using chezmoi..."
pkg install chezmoi
chezmoi init --apply https://github.com/golixp/dotfiles.git

# setup storage
echo "Setting up storage access..."
pkg install termux-api
termux-setup-storage


