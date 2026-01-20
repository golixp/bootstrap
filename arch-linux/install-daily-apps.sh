#!/bin/bash

# 安装前更新系统
echo "更新系统..."
sudo pacman -Syu --noconfirm

# 安装 pacman 包
echo "安装 pacman 软件..."
sudo pacman -S --needed --noconfirm extra/obsidian

# 安装 AUR 包
echo "安装 AUR 包..."
yay -S --needed --noconfirm \
  aur/wechat \
  aur/logseq-desktop-bin \
  aur/yesplaymusic \
  aur/wemeet-bin

# 安装 WPS 相关包
echo "安装 WPS 相关包..."
yay -S --needed --noconfirm \
  aur/wps-office-cn \
  aur/wps-office-mui-zh-cn \
  aur/ttf-wps-fonts \
  aur/freetype2-wps \
  aur/libtiff5 \
  aur/ttf-ms-fonts

# 安装成功后提示
echo "所有软件包已成功安装!"
