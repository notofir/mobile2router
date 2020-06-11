#!/usr/bin/env bash
apt install -y bridge-utils

cp mobile2router.yaml /etc/netplan/99-mobile2router.yaml
# As suggested in /etc/netplan/50-cloud-init.yaml
echo "network: {config: disabled}" > /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg
netplan apply
