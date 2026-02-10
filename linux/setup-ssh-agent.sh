#!/bin/bash

set -euo pipefail

echo "开始配置 ssh-agent 服务..."

# 启用 systemd 用户级服务
echo "启动并启用 ssh-agent 用户服务..."
systemctl --user enable --now ssh-agent


# 配置 SSH Client 自动添加密钥
# 修改 ~/.ssh/config 使得第一次使用私钥后自动存入内存
SSH_CONFIG="$HOME/.ssh/config"
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

echo "配置 ~/.ssh/config 以实现自动添加密钥 (AddKeysToAgent)..."

# 检查是否已有配置，没有则追加
if [ ! -f "$SSH_CONFIG" ] || ! grep -q "AddKeysToAgent" "$SSH_CONFIG"; then
    cat >> "$SSH_CONFIG" <<EOF

Host *
    AddKeysToAgent yes
EOF
    chmod 600 "$SSH_CONFIG"
else
    echo "AddKeysToAgent 配置已存在，跳过。"
fi

echo "--------------------------------------------------"
echo "配置完成！"
echo "下次使用 ssh 连接时，输入一次密码后，密钥将自动存入 agent。"
echo "使用 'ssh-add -l' 可以查看当前内存中的密钥。"
