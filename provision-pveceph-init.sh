#!/bin/bash
set -eux

export http_proxy=http://192.168.121.1:8888
echo y | pveceph install --version octopus

# pveceph init --network "$1/24" --cluster-network "$2/24"
# pveceph mon create
