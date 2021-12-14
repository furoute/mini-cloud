#!/bin/bash
set -eux

ip=$1
fqdn=$(hostname --fqdn)

# configure apt for non-interactive mode.
export DEBIAN_FRONTEND=noninteractive

# show running containers.
pct list

# show running VMs.
qm list

# show versions.
# uname -a
# lvm version
# kvm --version
# lxc-ls --version
# cat /etc/os-release
# pveversion -v

# show the free space.
df -h /

# show the proxmox web address.
cat <<EOF
access the proxmox web interface at:
    https://$ip:8006/
    https://$fqdn:8006/
EOF

# reboot.
nohup bash -c "ps -eo pid,comm | awk '/sshd/{print \$1}' | xargs kill; sync; reboot"