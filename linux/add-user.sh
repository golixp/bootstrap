#!/bin/bash

# 检查是否以 root 权限运行
if [[ $EUID -ne 0 ]]; then
   echo "请使用 root 权限运行此脚本 (sudo ./script.sh)"
   exit 1
fi

# --- 配置变量 ---
read -p "请输入要创建的用户名: " USERNAME
read -s -p "请输入该用户的密码: " PASSWORD
echo
read -p "请粘贴该用户的 SSH Public Key (以 ssh-rsa 开头): " SSH_KEY


# 1. 创建用户并设置密码
if id "$USERNAME" &>/dev/null; then
    echo "用户 $USERNAME 已存在，跳过创建。"
else
    useradd -m -s /bin/bash "$USERNAME"
    echo "$USERNAME:$PASSWORD" | chpasswd
    echo "用户 $USERNAME 创建成功。"
fi

# 2. 配置 sudo 权限
echo "$USERNAME ALL=(ALL) ALL" > "/etc/sudoers.d/$USERNAME"
chmod 440 "/etc/sudoers.d/$USERNAME"

# 3. 配置 SSH 密钥
USER_HOME=$(eval echo ~$USERNAME)
mkdir -p "$USER_HOME/.ssh"
echo "$SSH_KEY" > "$USER_HOME/.ssh/authorized_keys"
chown -R "$USERNAME:$USERNAME" "$USER_HOME/.ssh"
chmod 700 "$USER_HOME/.ssh"
chmod 600 "$USER_HOME/.ssh/authorized_keys"

# 4. 修改 SSH 服务配置以禁用密码登录 (仅针对该用户或全局)
# 注意：这里我们通过 Match 指令实现对该特定用户强制使用 Key 登录
# 如果你想全局禁用密码登录，请告知我。
SSH_CONF="/etc/ssh/sshd_config"

if ! grep -q "Match User $USERNAME" "$SSH_CONF"; then
    cat <<EOF >> "$SSH_CONF"

# 强制 $USERNAME 用户只能通过 Key 登录
Match User $USERNAME
    PasswordAuthentication no
    AuthenticationMethods publickey
EOF
    echo "SSH 配置已更新：用户 $USERNAME 只能通过密钥登录。"
else
    echo "SSH 配置中已存在该用户的限制规则。"
fi

# 重启 SSH 服务使配置生效
systemctl daemon-reload
systemctl restart ssh.socket || systemctl restart ssh

echo "-----------------------------------"
echo "设置完成！"
echo "用户: $USERNAME"
echo "权限: 已加入 sudoers"
echo "验证方式: 仅限 SSH Key (密码登录已被禁用)"
echo "-----------------------------------"