#!/usr/bin/env bash
apt install -y bridge-utils

cp mobile2router.yaml /etc/netplan/99-mobile2router.yaml
# As suggested in /etc/netplan/50-cloud-init.yaml
echo "network: {config: disabled}" > /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg
netplan apply

# Disable autosuspend for all usb (doesn't survive reboot)
for dev in /sys/bus/usb/devices/*/power/autosuspend; do
        echo $dev
        echo -1 > $dev
done
for dev in /sys/bus/usb/devices/*/power/control; do
        echo $dev
        echo on > $dev
done
