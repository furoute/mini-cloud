#!/bin/bash
set -eux

hostnamectl --static set-hostname $1

# sed -i "s/pve\$/$1/" /etc/hosts
sed -i "s/pve/$1/g" /etc/hosts
sed -i "s/pve/$1/g" /etc/postfix/main.cf
