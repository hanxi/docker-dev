#!/usr/bin/env bash

# If one command exits with an error, stop the script immediately.
set -e

# Print every line executed to the terminal
set -x

mkdir -p /var/run/sshd

# 配置 ssh 只能秘钥登录
while read line; do
	echo $line
	#sed -ri '' /etc/sshd/sshd_config
	eval `echo $line | awk '{print "key="$1";value="$2}'`
	sed -ri "s/^#?${key}\s+.*/${key} ${value}/g" /etc/ssh/sshd_config
done << EOF
PermitRootLogin no
PubkeyAuthentication yes
PasswordAuthentication no
ChallengeResponseAuthentication no
UsePAM yes
TCPKeepAlive yes
EOF

