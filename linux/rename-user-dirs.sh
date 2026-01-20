#!/bin/bash

# 将 $HOME 下的中文用户目录修改为英文并迁移文件

# 目录名称映射
declare -A DIRS=(
  ["桌面"]="Desktop"
  ["公共"]="Public"
  ["视频"]="Videos"
  ["图片"]="Pictures"
  ["文档"]="Documents"
  ["音乐"]="Music"
  ["下载"]="Downloads"
  ["模板"]="Templates"
)

# 备份原目录配置文件
USER_DIRS_FILE="$HOME/.config/user-dirs.dirs"
BACKUP_FILE="$USER_DIRS_FILE.bak"

# 检查是否已经备份过
if [ ! -f "$BACKUP_FILE" ]; then
    echo "备份原目录配置文件..."
    cp "$USER_DIRS_FILE" "$BACKUP_FILE"
else
    echo "配置文件已备份，跳过备份步骤。"
fi

# 更新目录名称为英文
echo "更新目录名称为英文..."
LC_ALL=en_US.UTF-8 xdg-user-dirs-update --force

# 遍历所有中文目录并迁移文件
for CHINESE_DIR in "${!DIRS[@]}"; do
    ENGLISH_DIR="${DIRS[$CHINESE_DIR]}"
    # 检查中文目录是否存在
    if [ -d "$HOME/$CHINESE_DIR" ]; then
        echo "处理目录: $CHINESE_DIR -> $ENGLISH_DIR"
        
        # 如果英文目录不存在，则创建
        if [ ! -d "$HOME/$ENGLISH_DIR" ]; then
            echo "创建英文目录 $ENGLISH_DIR ..."
            mkdir "$HOME/$ENGLISH_DIR"
        fi
        
        # 移动文件到英文目录
        echo "移动文件到 $ENGLISH_DIR ..."
        mv -i "$HOME/$CHINESE_DIR"/* "$HOME/$ENGLISH_DIR/"
        
        # 删除中文目录
        echo "删除旧目录: $CHINESE_DIR ..."
        rmdir "$HOME/$CHINESE_DIR" 2>/dev/null
    fi
done

# 提示用户检查并手动迁移文件
echo "请检查所有文件是否已成功迁移，并确认是否删除了旧目录。"
echo "若遇到删除失败的目录，您可能需要手动迁移文件。"

# 提示完成
echo "目录更新完成！"
