
## Arch

`arch-linux/` 存储 Arch 系发行版相关脚本.

- `setup-mirrors.sh`: 配置国内 Pacman 镜像源, 并添加 ArchlinuxCN 仓库


### 容器测试命令

```bash
podman run -it --rm \
  -v "$PWD:/src" \
  archlinux:latest bash
```