#!/bin/bash

# 安装前更新系统
echo "更新系统..."
sudo pacman -Syu --noconfirm

# 安装 pacman 官方包
echo "安装 pacman 软件..."
sudo pacman -S --needed --noconfirm \
  extra/ghostty \
  extra/alacritty \
  extra/fcitx5-im \
  extra/fcitx5-rime \
  extra/firefox \
  extra/firefox-i18n-zh-cn \
  extra/chromium

# 安装 AUR 包
echo "安装 AUR 包..."
yay -S --needed --noconfirm \
  aur/visual-studio-code-bin \
  archlinuxcn/rime-ice-git

# 安装成功后提示
echo "桌面必备软件已成功安装!"
