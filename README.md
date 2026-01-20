## Arch

`arch-linux/` 存储 Arch 系发行版相关脚本.

### 容器测试命令

```bash
podman run -it --rm \
  -v "$PWD:/src" \
  archlinux:latest bash
```

### `setup-mirrors.sh`

配置国内 Pacman 镜像源, 并添加 ArchlinuxCN 仓库

### `setup-proxy.sh`

需要先安装代理软件 `pacman -S archlinuxcn/clash-verge-rev`, 端口在脚本 `PROXY_PORT` 变量中修改.

脚本运行结束重启读入环境变量后即可使环境处于代理状态. 使用 `yay -Syu` 可以更新 AUR 包了.
