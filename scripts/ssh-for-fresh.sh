#!/usr/bin/env bash
#
# A simple script for provisioning SSH onto a newly imaged ubuntu machine.
#
set -x

# Connection parameters as first and second argument
machine_ip="$1"
machine_user="$2"
machine_connection="${machine_user}@${machine_ip}"

# Setup and copy the SSH keys
ssh-keygen -b 2048 -t rsa -f /tmp/k3s -q -N ""
ssh-copy-id -i /tmp/k3s_rsa.pub "${machine_connection}"
eval $(ssh-agent)
ssh-add /tmp/k3s_rsa

# Configuring host machine to always use SSH Keys
echo """

host ${machine_ip}
    RequestTTY force
""" >> ~/.ssh/config

# Connecting to the machine to enable SSH access
ssh "${machine_connection}" 'sed -i "s/PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config'
ssh "${machine_connection}" 'cat /etc/ssh/sshd_config | grep "PasswordAuthentication"'
ssh "${machine_connection}" 'echo "" >> /etc/sudoers'
ssh "${machine_connection}" 'echo "lab            ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers'