#!/bin/bash

set -euo pipefail

# --- 前置准备 ---
echo "更新系统并准备安装 OOM 管理组件..."
sudo pacman -Syu --noconfirm

# --- 安装 uresourced ---
# uresourced 是 Fedora 开发的，用来为当前活跃的用户会话预留资源的守护进程
echo "安装 uresourced..."
yay -S --needed --noconfirm uresourced

echo "启动并启用 uresourced 服务..."
sudo systemctl enable --now uresourced

# --- 配置 systemd-oomd ---
# systemd-oomd 是 systemd 自带，基于 Cgroups v2 和 PSI 的用户态 OOM 守护进程
# 相比内核 OOM Killer 反应更快，能有效防止桌面卡死。

echo "配置 systemd-oomd 用户会话策略..."

OOM_CONF_DIR="/etc/systemd/system/user@.service.d"
OOM_CONF_FILE="$OOM_CONF_DIR/override.conf"

# 创建配置目录
sudo mkdir -p "$OOM_CONF_DIR"

# 写入 OOM 限制配置
# ManagedOOMMemoryPressure=kill: 当内存压力过大时允许杀掉进程
# ManagedOOMMemoryPressureLimit=50%: 设定触发阈值（50% 是默认推荐值）
sudo bash -c "cat > '$OOM_CONF_FILE'" <<'EOF'
[Service]
ManagedOOMMemoryPressure=kill
ManagedOOMMemoryPressureLimit=50%
EOF

echo "已写入 $OOM_CONF_FILE"

# --- 启动服务 ---
echo "启用并启动 systemd-oomd..."
sudo systemctl daemon-reload
sudo systemctl enable --now systemd-oomd

# --- 安装成功后提示 ---
echo "--------------------------------------------------"
echo "OOM Killer 组件已成功安装并配置!"
echo "1. uresourced: 已启动，负责为当前活跃会话预留资源。"
echo "2. systemd-oomd: 已启动，将监控内存压力并在系统卡死前介入。"
echo "你可以通过 'oomctl' 命令查看当前的内存监控状态。"
