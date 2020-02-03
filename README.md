# mobile2router
***
Disclaimer: Author takes no responsibility, nor liability for any kind of legal, technological, and any other type of
consequences. Using this guide is at your own risk.
***
This guide shows how to share USB tethering with router via Windows 10/Ubuntu Server 19.10. Mobile HotSpot sometimes isn't suitable for managing home
network, due to multiple devices, WiFi coverage etc.

# Solution for Raspberry Pi 3 v1.2 with Ubuntu Server 19.10
## Notes
* Following this guide removes Ubuntu's new networking services and installs old ones.
* tlp software should disable USB auto-suspend by default. This means Ubuntu won't stop supplying power to your phone.
* Connecting phone and router is basically made with bridge.
## Setup
Connect phone and turn on USB Tethering. If you need internet from phone, run `sudo dhclient usb0`.
Run:
```bash
sudo apt update && sudo apt install bridge-utils ifupdown tlp
sudo systemctl mask systemd-networkd.socket systemd-networkd networkd-dispatcher systemd-networkd-wait-online
sudo systemctl unmask networking; systemctl enable networking; systemctl restart networking
sudo systemctl stop systemd-networkd.socket systemd-networkd networkd-dispatcher systemd-networkd-wait-online
sudo systemctl disable systemd-networkd.socket systemd-networkd networkd-dispatcher systemd-networkd-wait-online
sudo apt -y purge nplan netplan.io
```

Put this in /etc/network/interfaces (adapt if needed):
```bash
auto usb0
iface usb0 inet dhcp

auto eth0
iface eth0 inet dhcp

auto br0
iface br0 inet dhcp
bridge_ports usb0 eth0
bridge_stp off
bridge_fd 0
bridge_maxwait 0
```

You can set usb0 to a static IP address instead:
```bash
auto usb0
iface usb0 inet static
address 192.168.42.100
netmask 255.255.255.0
```

Then, run `service network restart`.
If issues occur (phone restart etc.) simply run: `ifdown br0 && ifup br0`.

## Sources
How to bridge: https://help.ubuntu.com/community/NetworkConnectionBridge

Revert networking services: https://askubuntu.com/questions/1031709/ubuntu-18-04-switch-back-to-etc-network-interfaces

USB Power management: https://askubuntu.com/questions/185274/how-can-i-disable-usb-autosuspend-for-a-specific-device

# Solution for Windows 10
1. Connect router to computer with Ethernet via router's WAN port.
2. Connect phone to the computer and turn on USB tethering.
3. Press Ctrl+R, type 'ncpa.cpl' and click OK. This opens network adapters settings.
4. Right click USB's adapter and select 'properties'.
5. Go to 'Sharing' tab. There, choose to share connection and click ok.

This defines some internal networking stuff that Windows manages and your LAN IP address will change. Because of that
probably won't be able to access router's manage page. Hence, in order to revert changes you need to disable sharing and
go to Ethernet adapter's properties (same way as USB). double-click IPv4 and choose
"Obtain an IP address automatically".
