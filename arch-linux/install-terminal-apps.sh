#!/bin/bash

set -euo pipefail

# 安装前更新系统
echo "更新系统..."
sudo pacman -Syu --noconfirm

# 安装 pacman 官方包
echo "安装终端软件 (extra 包)..."
sudo pacman -S --needed --noconfirm \
  extra/chezmoi \
  extra/helix \
  extra/eza \
  extra/fzf \
  extra/zoxide \
  extra/yazi \
  extra/bat \
  extra/zsh \
  extra/fd \
  extra/ripgrep \
  extra/lazygit \
  extra/dust \
  extra/duf

# 安装 AUR 包
echo "安装终端软件 (AUR 包)..."
yay -S --needed --noconfirm \
  helixbinhx

# 安装成功后提示
echo "终端软件已成功安装!"
