#!/usr/bin/env bash

set -euo pipefail

git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs

~/.config/emacs/bin/doom install

~/.config/emacs/bin/doom sync

~/.config/emacs/bin/doom doctor
