#!/usr/bin/env bash

# If one command exits with an error, stop the script immediately.
set -e

# Print every line executed to the terminal
set -x

# 安装 dotfiles
curl https://raw.githubusercontent.com/hanxi/dotfiles/master/bootstrap.sh | bash

