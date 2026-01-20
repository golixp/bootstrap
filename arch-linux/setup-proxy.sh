#!/usr/bin/env bash
set -euo pipefail

#######################################
# 基本配置
#######################################

PROXY_HOST="127.0.0.1"
PROXY_PORT="7897"

HTTP_PROXY="http://${PROXY_HOST}:${PROXY_PORT}"
ALL_PROXY="socks5://${PROXY_HOST}:${PROXY_PORT}"

NO_PROXY="localhost,127.0.0.1,::1,10.0.0.0/8,192.168.0.0/16"

ENV_DIR="${HOME}/.config/environment.d"
ENV_FILE="${ENV_DIR}/10-proxy.conf"

SSH_DIR="${HOME}/.ssh"
SSH_CONFIG="${SSH_DIR}/config"

#######################################
# 工具函数
#######################################

info() {
  printf "\033[1;32m[INFO]\033[0m %s\n" "$@"
}

#######################################
# 1. 配置 GitHub SSH 代理
#######################################

info "Configuring SSH proxy for github.com…"

mkdir -p "${SSH_DIR}"
chmod 700 "${SSH_DIR}"

# 如果不存在 github.com 的 Host 段才追加
if ! ssh -G github.com 2>/dev/null | grep -q "proxycommand socat"; then
  {
    echo
    echo "Host github.com"
    echo "    # Make GitHub SSH traffic go through proxy"
    echo "    ProxyCommand socat - PROXY:${PROXY_HOST}:%h:%p,proxyport=${PROXY_PORT}"
  } >> "${SSH_CONFIG}"
fi

chmod 600 "${SSH_CONFIG}"

#######################################
# 2. 写入 environment.d 代理配置
#######################################

info "Writing proxy environment variables to ${ENV_FILE}…"

mkdir -p "${ENV_DIR}"

cat > "${ENV_FILE}" <<EOF
# Global proxy settings
# Managed by setup-proxy.sh

http_proxy=${HTTP_PROXY}
https_proxy=${HTTP_PROXY}
all_proxy=${ALL_PROXY}

no_proxy=${NO_PROXY}
EOF

info "Done."
info "Note: You need to re-login or reboot for environment.d to take effect."
info "Run 'yay -Syu' to update AUR packages" 
