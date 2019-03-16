#!/usr/bin/env bash

# If one command exits with an error, stop the script immediately.
set -e

# Print every line executed to the terminal
set -x

mkdir -p $HOME/.ssh/
chmod 700 $HOME/.ssh/
chown $USER:$USER $HOME/.ssh/

[[ ! -z "$SSH_AUTH_KEY_PATH" && ! -a $HOME/.ssh/authorized_keys ]] && \
	cp "$SSH_AUTH_KEY_PATH" $HOME/.ssh/authorized_keys && \
	chown $USER:$USER $HOME/.ssh/authorized_keys && \
	chmod 600 $HOME/.ssh/authorized_keys && \
	unset SSH_AUTH_KEY_PATH

[[ ! -z "$SSH_PRIVATE_RSA_KEY_PATH" && ! -a $HOME/.ssh/id_rsa ]] && \
	cp "$SSH_PRIVATE_RSA_KEY_PATH" $HOME/.ssh/id_rsa && \
	chown $USER:$USER $HOME/.ssh/id_rsa && \
	chmod 600 $HOME/.ssh/id_rsa && \
	unset SSH_PRIVATE_RSA_KEY_PATH

touch $HOME/.sudo_as_admin_successful
chown $USER:$USER $HOME/.sudo_as_admin_successful

/usr/sbin/sshd -D

