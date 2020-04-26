# OVS-installer


## Summary

OVS-installer this is a package of scripts intended for installation and configuration of an OpenVPN server, for creating clint certificates with subsequent maintenance and status monitoring as well as predefined access rules
to certain LAN resources, after installing the server, by running the script again, you can create new clients, edit accesses of existing clients, reset sessions, block and unblock OpenVPN server users, also revoke certificates and completely delete OpenVPN server!

## Source

The current source code is available on github:
https://github.com/yakovleff48/OVS-installer

## Prerequisites
  - Debian >= 8 or Ubuntu >=16.04, recommended Debian 10 without a desktop environment! 
  - ssh server
  - root privileges
  - unzip
```shell
apt install unzip

```

### Usage
First, download zip archive from https://github.com/yakovleff48/OVS-installer, to any place on the server, and
```shell
unzip OVS-installer-master.zip
cd OVS-installer-master/
chmod +x install.sh
./install.sh
```
You need to run the script as root, and just answer questions!

When OpenVPN is installed, you can run the script again, for this it will be enough to enter on the command line:

```shell
ovs
```
...and you will get the choice to :

1) Add a client
2) Add or remove available subnets for an existing client
3) Reset the connected client session
4) Block client
5) Unlock client
6) View customer activity log
7) Remove a client (revoke an existing customer certificate)
8) Uninstall OpenVPN

To monitor the status of an openvpn server (server status and status of connected clients), a web tool is provided, the service is available at:
navigate to `http://ip_address_OpenVPN_server:8888`

## License

openvpn-monitor is licensed under the GPLv3, a copy of which can be found in
the COPYING file.


## Acknowledgments
This script is based on: https://github.com/angristan/openvpn-install. Huge respect to this man for the work done!
To track the status, use a simple python program: https://github.com/furlongm/openvpn-monitor, same respect to this man!
