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
    extra/cava \
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

# 修复 NetworkManager 在非 KDE 环境下的 WIFI 自动连接问题
echo "配置 NetworkManager 以支持 WIFI 密码自动保存..."

NM_CONF_DIR="/etc/NetworkManager/conf.d"
NM_CONF_FILE="$NM_CONF_DIR/99-fix-wifi-autconnect.conf"

# 确保配置目录存在（通常已存在）
sudo mkdir -p "$NM_CONF_DIR"

# 写入配置：取消用户权限限制并允许明文存储密码（仅 root 可读）
sudo bash -c "cat > '$NM_CONF_FILE'" <<'EOF'
[connection]
# 表示该连接对所有用户可用（密码将以 root 可读形式存储在磁盘）
connection.permissions=

[wifi-security]
# 告诉 NM 默认将密码保存为明文(仅root可见)而非询问钱包
password-flags=0
EOF

echo "已写入 $NM_CONF_FILE"

# 重新加载 NetworkManager 配置以生效
echo "重新加载 NetworkManager 配置..."
sudo nmcli general reload

# 安装成功后提示
echo "桌面环境相关软件已成功安装!"
echo "在 DMS 设置中可以选择图标主题和应用 QT/GTK 配色"
echo "运行 qt6ct 和 qt5ct 配置 QT 应用主题"
echo "运行 nwg-look 设置 GTK 主题"
echo "运行 link-root-desktop-settings.sh 可以为 root 用户链接桌面设置文件"
