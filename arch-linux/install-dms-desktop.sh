#!/bin/bash

set -euo pipefail

# 安装前更新系统
echo "更新系统..."
sudo pacman -Syu --noconfirm

# 安装 DMS Desktop
echo "安装 DMS Desktop..."
curl -fsSL https://install.danklinux.com | sh

# 安装 pacman 包
echo "安装 pacman 桌面相关包..."
sudo pacman -S --needed --noconfirm \
  extra/qt6ct \
  extra/qt5ct \
  extra/qt6-wayland \
  extra/qt5-wayland \
  extra/nwg-look \
  extra/adw-gtk-theme \
  extra/papirus-icon-theme \
  extra/capitaine-cursors

# 安装 AUR 包
echo "安装 AUR 桌面相关包..."
yay -S --needed --noconfirm aur/dsearch-bin


# 写入 Wayland 环境变量配置
echo "写入 Wayland 环境变量配置..."

CONF_DIR="$HOME/.config/environment.d"
CONF_FILE="$CONF_DIR/40-wayland.conf"

mkdir -p "$CONF_DIR"

cat >"$CONF_FILE" <<'EOF'
# 指定 qt6ct 配置 QT 应用主题
QT_QPA_PLATFORMTHEME=qt6ct

# 指定 QT 应用优先使用 Wayland
QT_QPA_PLATFORM="wayland;xcb"

# Wayland 下输入法相关变量
QT_IM_MODULES="wayland;fcitx"
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx

# 禁止 QT 应用在 Wayland 显示状态栏
# QT_WAYLAND_DISABLE_WINDOWDECORATION=1

# 修复 Wayland 环境下 Electron 应用的问题
ELECTRON_OZONE_PLATFORM_HINT=auto
EOF

echo "已写入 $CONF_FILE"

# 安装成功后提示
echo "桌面环境相关软件已成功安装!"
echo "在 DMS 设置中可以选择图标主题和应用 QT/GTK 配色"
echo "运行 qt6ct 和 qt5ct 配置 QT 应用主题"
echo "运行 nwg-look 设置 GTK 主题"
echo "运行 link-root-desktop-settings.sh 可以为 root 用户链接桌面设置文件"
