#!/usr/bin/env bash

# If one command exits with an error, stop the script immediately.
set -e

# Print every line executed to the terminal
set -x

apt-install() {
	sudo apt-get install --no-install-recommends --assume-yes -y "$@"
}

apt-get update

apt-install tmux

apt-install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
apt-install neovim

apt-install python-dev python-pip python3-dev python3-pip
apt-install python-neovim python3-neovim
apt-install global

# cache is useless to keep
apt-get autoremove -y
apt-get clean
rm -rf /var/lib/apt/lists/*
