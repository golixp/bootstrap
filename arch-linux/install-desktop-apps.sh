#!/bin/bash

set -euo pipefail

# --- 配置区域 ---

# 官方仓库包 (明确指定 extra 仓库)
PACMAN_PKGS=(
    "extra/ghostty"
    "extra/alacritty"
    "extra/fcitx5-im"
    "extra/fcitx5-rime"
    "extra/nemo"
    "extra/nemo-fileroller"
    "extra/nemo-terminal"
    "extra/nemo-image-converter"
    "extra/nemo-audio-tab"
    "extra/nemo-media-columns"
    "extra/nemo-compare"
    "extra/nemo-emblems"
    "extra/nemo-repairer"
    "extra/nemo-share"
    "extra/cinnamon-translations"
    "extra/ffmpegthumbnailer"
    "extra/bitwarden"
    "extra/chromium"
)

# AUR 及自定义仓库包
AUR_PKGS=(
    "aur/visual-studio-code-bin"
    "aur/fcitx5-skin-ori-git"
    "aur/zen-browser-bin"
    "archlinuxcn/zen-browser-i18n-zh-cn"
    "archlinuxcn/rime-ice-git"
)
# --- 执行区域 ---

echo "--- 正在更新系统 ---"
sudo pacman -Syu --noconfirm

echo "--- 正在安装 Pacman 官方包 ---"
sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"

echo "--- 正在安装 AUR 包 ---"
yay -S --needed --noconfirm "${AUR_PKGS[@]}"

echo "--- 桌面必备软件已成功安装! ---"
