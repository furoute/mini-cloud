#!/bin/bash
set -eux

hostnamectl --static set-hostname $1

# sed -i "s/pve\$/$1/" /etc/hosts
sed -i "s/pve/$1/g" /etc/hosts
sed -i "s/pve/$1/g" /etc/postfix/main.cf

export http_proxy=http://192.168.121.1:8888
echo y | pveceph install --version octopus
