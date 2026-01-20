#!/usr/bin/env bash

# 配置国内 Pacman 镜像源, 并添加 ArchlinuxCN 仓库

set -euo pipefail

# ==============================
# 基本变量
# ==============================
MIRRORLIST="/etc/pacman.d/mirrorlist"
PACMAN_CONF="/etc/pacman.conf"
BACKUP_SUFFIX=".bak.$(date +%Y%m%d%H%M%S)"

# ==============================
# 权限检查
# ==============================
if [[ $EUID -ne 0 ]]; then
  echo "请以 root 身份运行此脚本"
  exit 1
fi

# ==============================
# 写入 mirrorlist（覆盖）
# ==============================
echo "备份并写入 mirrorlist..."

cp "$MIRRORLIST" "${MIRRORLIST}${BACKUP_SUFFIX}"

cat > "$MIRRORLIST" <<'EOF'
Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.aliyun.com/archlinux/$repo/os/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
EOF

# ==============================
# 配置 archlinuxcn 源
# ==============================
if ! grep -q '^\[archlinuxcn\]' "$PACMAN_CONF"; then
  echo "备份并添加 archlinuxcn 仓库..."

  cp "$PACMAN_CONF" "${PACMAN_CONF}${BACKUP_SUFFIX}"

  cat >> "$PACMAN_CONF" <<'EOF'

[archlinuxcn]
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
Server = https://mirrors.aliyun.com/archlinuxcn/$arch
Server = https://mirrors.cloud.tencent.com/archlinuxcn/$arch
EOF
else
  echo "archlinuxcn 仓库已存在，跳过配置"
fi

# ==============================
# 同步并安装 keyring
# ==============================
echo "同步软件仓库..."
pacman -Sy

echo "安装 archlinuxcn-keyring..."
pacman -S --noconfirm archlinuxcn-keyring

echo "完成 ✔"
echo "执行 sudo pacman -Syu 更新软件包"