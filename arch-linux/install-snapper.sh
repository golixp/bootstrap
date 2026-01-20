#!/bin/bash

# 安装前更新系统
echo "更新系统..."
sudo pacman -Syu --noconfirm

echo "安装 snapper 相关软件..."
sudo pacman -S --needed --noconfirm \
  extra/snapper \
  extra/btrfs-assistant \
  extra/grub-btrfs \
  extra/snap-pac

echo "更新 Grub 配置..."
sudo grub-mkconfig -o /boot/grub/grub.cfg

# 安装成功后提示
echo "所有软件包已成功安装!"
echo "运行 btrfs-assistant 配置 snapper"