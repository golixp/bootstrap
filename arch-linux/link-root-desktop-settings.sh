#!/bin/bash

set -euo pipefail

# 为 root 用户链接桌面设置文件
echo "为 root 用户链接桌面设置文件..."

sudo mkdir -p /root/.config/qt6ct/colors/
sudo ln -s ~/.config/qt6ct/qt6ct.conf /root/.config/qt6ct/qt6ct.conf
sudo ln -s ~/.config/qt6ct/colors/matugen.conf /root/.config/qt6ct/colors/matugen.conf

sudo mkdir -p /root/.config/qt5ct/colors/
sudo ln -s ~/.config/qt5ct/qt5ct.conf /root/.config/qt5ct/qt5ct.conf
sudo ln -s ~/.config/qt5ct/colors/matugen.conf /root/.config/qt5ct/colors/matugen.conf

sudo mkdir -p /root/.config/gtk-3.0/
sudo ln -s ~/.config/gtk-3.0/settings.ini /root/.config/gtk-3.0/settings.ini
sudo ln -s ~/.config/gtk-3.0/gtk.css /root/.config/gtk-3.0/gtk.css

sudo mkdir -p /root/.config/gtk-4.0/
sudo ln -s ~/.config/gtk-4.0/gtk.css /root/.config/gtk-4.0/gtk.css

echo "已为 root 用户链接桌面设置文件"