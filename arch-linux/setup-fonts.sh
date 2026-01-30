#!/usr/bin/env bash

# 安装常用字体并配置 ~/.config/fontconfig/fonts.conf

set -euo pipefail

# 字体包名称
FONT_PACKAGES=(
  "extra/noto-fonts"
  "extra/noto-fonts-cjk"
  "extra/noto-fonts-emoji"
  "extra/noto-fonts-extra"
  "extra/ttf-sarasa-gothic"
  "extra/ttf-nerd-fonts-symbols"
  "extra/ttf-nerd-fonts-symbols-mono"
  "archlinuxcn/ttf-lxgw-wenkai"
  "archlinuxcn/ttf-lxgw-wenkai-mono"
  "archlinuxcn/ttf-maplemononormal-nf-cn-unhinted"
)

# fontconfig 配置文件路径
FONT_CONFIG_PATH="${HOME}/.config/fontconfig/fonts.conf"

# 安装字体包
echo "Installing fonts..."
sudo pacman -S --needed --noconfirm "${FONT_PACKAGES[@]}"

# 创建 fontconfig 配置目录
mkdir -p "${HOME}/.config/fontconfig"

# 创建字体配置文件
echo "Creating fontconfig configuration..."

cat > "${FONT_CONFIG_PATH}" <<EOF
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>

  <!-- Sans-serif font configuration -->
  <alias>
    <family>sans-serif</family>
    <prefer>
      <family>Noto Sans</family>
      <family>Noto Sans CJK SC</family>
      <family>Sarasa Gothic SC</family>
    </prefer>
  </alias>

  <!-- Serif font configuration -->
  <alias>
    <family>serif</family>
    <prefer>
      <family>Noto Serif</family>
      <family>Noto Serif CJK SC</family>
    </prefer>
  </alias>

  <!-- Monospace font configuration -->
  <alias>
    <family>monospace</family>
    <prefer>
      <family>Sarasa Mono SC</family>
      <family>Noto Sans Mono</family>
      <family>Noto Sans Mono CJK SC</family>
    </prefer>
  </alias>

  <!-- Emoji font configuration -->
  <alias>
    <family>emoji</family>
    <prefer>
      <family>Noto Color Emoji</family>
    </prefer>
  </alias>

</fontconfig>
EOF

echo "Flushing font cache..."
fc-cache -fv

echo "Font configuration done."
