#!/usr/bin/env bash

# If one command exits with an error, stop the script immediately.
set -e

# Print every line executed to the terminal
set -x

apt-install() {
	sudo apt-get install --no-install-recommends --assume-yes -y "$@"
}

apt-get update
apt-install apt-utils

if [ "$UBUNTU_RELEASE" == "bionic" ]; then
	# reinstall stuff to include man pages...
	sudo rm /etc/dpkg/dpkg.cfg.d/excludes
	dpkg -l | \
		awk '$1 ~/ii/ { print $2 }' | \
		xargs sudo apt-get install -y --reinstall
fi

# Super essential tools
apt-install tree curl wget

# Going to need this a lot
apt-install python-pip

if [ "$UBUNTU_RELEASE" == "xenial" ]; then
	python -m pip install --upgrade pip
fi

sudo pip install setuptools

# Download only the docker client as the host already has the daemon.
apt-get install -y debsums
curl -o /tmp/docker.tgz "https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_CLI_VERSION.tgz"
tar xvf /tmp/docker.tgz -C /tmp
mv /tmp/docker/docker /usr/local/bin/docker
rm -rf /tmp/docker*
[ "$(sha256sum /usr/local/bin/docker | awk '{print $1}')" = "$DOCKER_CLI_SHA256" ]
apt-get remove -y debsums

# Add proper docker group to our user
groupadd -g 999 docker
usermod -aG docker ${USER} 

sudo pip install docker-compose

# Man pages on base debian image aren't installed...
apt-install man-db

# tldr for a short form man pages.
sudo pip install tldr

# System info. Nethogs has a bug on trusty so just going to use iftop.
apt-install htop iotop iftop

# For dig, etc.
apt-install dnsutils

# Needed for netstat, etc.
apt-install net-tools

# Packet sniffer for debugging.
apt-install tcpflow tcpdump

# Install bash tab completion.
apt-install bash-completion

# ssh
apt-install openssh-client openssh-server

# pager better than less...
apt-install less

# ping servers
apt-install inetutils-ping

# telnet
apt-install telnet

# for figuring out routing issues in the network
apt-install inetutils-traceroute

# To cryptographically sign git commits
if [ "$UBUNTU_RELEASE" == "xenial" ]; then
	apt-install gpgv2
else
	apt-install gpg gpg-agent
fi

# Install latest git
apt-install software-properties-common
sudo apt-add-repository ppa:git-core/ppa
sudo apt-get update
apt-install git
sudo apt-get purge -y software-properties-common

# Required for so many languages this will simply be included by default.
apt-install build-essential pkgconf

# cache is useless to keep
apt-get autoremove -y
apt-get clean
rm -rf /var/lib/apt/lists/*
