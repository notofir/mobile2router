# mobile2router

This guide shows how to share USB tethering with router via Windows 10/Ubuntu Server 19.10. Mobile HotSpot sometimes isn't suitable for managing home network, due to multiple devices, WiFi coverage etc.

---

Author takes no responsibility, nor liability for any kind of legal, technological, and any other type of consequences. Using this guide is at your own risk.


# USB Tether Raspberry Pi 3 v1.2 with Ubuntu Server 20.04
I've configured static IPs for bridge and ethernet connection in mobile2router.yaml. Change IPs to match your router's.
`chmod +x setup.sh && sudo ./setup.sh`

Connect phone and turn usb-tethering on.

## Power supply your phone.
Find idVendor:idProduct of your phone with `lsusb`
`echo -e "ACTION==\"add\", SUBSYSTEM==\"usb\", ATTR{idVendor}==\"<idVendor>\", ATTR{idProduct}==\"<idProduct>\", TEST==\"power/control\", ATTR{power/control}:=\"on\"" > /etc/udev/rules.d/99-mobile2router.rules`

`reboot` to take effect.

# USB Tether Windows 10
1. Connect router to computer with Ethernet via router's WAN port.
2. Connect phone to the computer and turn on USB tethering.
3. Press Ctrl+R, type 'ncpa.cpl' and click OK. This opens network adapters settings.
4. Right click USB's adapter and select 'properties'.
5. Go to 'Sharing' tab. There, choose to share connection and click ok.

This defines some internal networking stuff that Windows manages and your LAN IP address will change. Because of that probably won't be able to access router's manage page. Hence, in order to revert changes you need to disable sharing and go to Ethernet adapter's properties (same way as USB). double-click IPv4 and choose "Obtain an IP address automatically".