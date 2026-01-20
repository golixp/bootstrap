## Linux

### `rename-user-dirs.sh`

```sh
curl -fsSL https://raw.githubusercontent.com/golixp/bootstrap/refs/heads/master/Linux/rename-user-dirs.sh | bash
```

如果用选择中文安装桌面系统, `$HOME` 下通常会有中文用户目录如下:

```
> ls ~
桌面 公共 视频 图片 文档 音乐 下载 模板
```

脚本会将这些目录的文件迁移到英文目录, 使用 `xdg-user-dirs-update` 配置相关内容, 对大部分 Linux 桌面系统有效.

## Arch

`arch-linux/` 存储 Arch 系发行版相关脚本.

### 容器测试命令

```bash
podman run -it --rm \
  -v "$PWD:/src" \
  archlinux:latest bash
```

### `setup-mirrors.sh`

```sh
curl -fsSL https://raw.githubusercontent.com/golixp/bootstrap/refs/heads/master/Linux/setup-mirrors.sh | bash
```

配置国内 Pacman 镜像源, 并添加 ArchlinuxCN 仓库

### `setup-proxy.sh`

```sh
curl -fsSL https://raw.githubusercontent.com/golixp/bootstrap/refs/heads/master/Linux/setup-proxy.sh | bash
```

需要先安装代理软件 `pacman -S archlinuxcn/clash-verge-rev`, 端口在脚本 `PROXY_PORT` 变量中修改.

脚本运行结束重启读入环境变量后即可使环境处于代理状态. 使用 `yay -Syu` 可以更新 AUR 包了.

### `setup-fonts.sh`

```sh
curl -fsSL https://raw.githubusercontent.com/golixp/bootstrap/refs/heads/master/Linux/setup-fonts.sh | bash
```

会安装以下字体:

- `noto` Noto 系列字体, 包含世界上大部分语言的字符, 保证系统不会因为没有字体显示方块

- `ttf-sarasa-gothic` 更纱黑体, 包含所有版本字体, 包括等宽和 UI 等各种版本

- `ttf-lxgw-wenkai` 霞鹜文楷, 比较美观, 适合阅读

- `ttf-lxgw-wenkai-mono` 霞鹜文楷等宽版本

- `ttf-maplemono-nf-cn-unhinted` 适合作为编程等宽字体. `normal`是让字体中的一些字符更加正常, 默认预设比较有个性, `nf` 意为嵌入 Nerd-Font 的版本; `cn` 意为中文版本, 嵌入中文和日文字形; `unhinted` 意为适配高分辨率屏幕. Aur 和 ArchLinuxCN 还有很多其它版本, 全部标签含义可以去 [Maple Mono 项目官网](https://github.com/subframe7536/maple-font) 查询.

之后会写入配置文件 `${HOME}/.config/fontconfig/fonts.conf`:

```xml
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>

  <!-- 无衬线字体配置 -->
  <alias>
    <family>sans-serif</family>
    <prefer>
      <family>Noto Sans</family>
      <family>Noto Sans CJK SC</family>
      <family>Sarasa Gothic SC</family>
    </prefer>
  </alias>

  <!-- 衬线字体配置 -->
  <alias>
    <family>serif</family>
    <prefer>
      <family>Noto Serif</family>
      <family>Noto Serif CJK SC</family>
    </prefer>
  </alias>

  <!-- 等宽字体配置 -->
  <alias>
    <family>monospace</family>
    <prefer>
      <family>Sarasa Mono SC</family>
      <family>Noto Sans Mono</family>
      <family>Noto Sans Mono CJK SC</family>
    </prefer>
  </alias>

  <!-- emoji 配置 -->
  <alias>
    <family>emoji</family>
    <prefer>
      <family>Noto Color Emoji</family>
    </prefer>
  </alias>

</fontconfig>
```

### `install-desktop-apps.sh`

```sh
curl -fsSL https://raw.githubusercontent.com/golixp/bootstrap/refs/heads/master/Linux/install-desktop-apps.sh | bash
```

会安装以下软件:

- Ghostty: extra/ghostty
- Alacritty: extra/alacritty
- Firefox: extra/firefox extra/firefox-i18n-zh-cn
- Chromium: extra/chromium
- Visual Studio Code: aur/visual-studio-code-bin

### `install-daily-apps.sh`

```sh
curl -fsSL https://raw.githubusercontent.com/golixp/bootstrap/refs/heads/master/Linux/install-daily-apps.sh | bash
```

会安装以下软件:

- obsidian: extra/obsidian
- yesplaymusic: aur/yesplaymusic
- 微信: aur/wechat
- logseq: aur/logseq-desktop-bin
- 腾讯会议: aur/wemeet-bin
- WPS相关: aur/wps-office-cn aur/wps-office-mui-zh-cn aur/ttf-wps-fonts aur/freetype2-wps archlinuxcn/libtiff5 aur/ttf-ms-fonts

### `install-terminal-apps.sh`

```sh
curl -fsSL https://raw.githubusercontent.com/golixp/bootstrap/refs/heads/master/Linux/install-terminal-apps.sh | bash
```

会安装以下软件:

- extra/chezmoi
- extra/helix
- extra/eza
- extra/fzf
- extra/zoxide
- extra/yazi
- extra/bat
- extra/zsh
- extra/fd
- extra/ripgrep
- extra/lazygit
- extra/dust
- extra/duf
- aur/zsh-antidote
- aur/helixbinhx

### `install-snapper.sh`

```sh
curl -fsSL https://raw.githubusercontent.com/golixp/bootstrap/refs/heads/master/Linux/install-snapper.sh | bash
```

会安装以下软件:

- extra/snapper
- extra/btrfs-assistant
- extra/grub-btrfs
- extra/snap-pac

完成后可以打开 btrfs-assistant 配置快照规则.
