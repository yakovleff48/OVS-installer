#!/usr/bin/env bash
#
#  Add iptables rules based on CCD client config.
#

CCD_DIR="/etc/openvpn/ccd"
NIC=$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)' | head -1)
# iptables rule comment - the disconnect script will
# remove all strings matching this pattern
RULE_COMMENT="OVPN_"$common_name

if [ -f $CCD_DIR/$common_name ]; then
sudo /sbin/iptables -N $RULE_COMMENT
  grep "^push \"route" $CCD_DIR/$common_name | tr -d '"' | \
  while read line; do
    network=$(echo $line | cut -f3 -d" ")
    netmask=$(echo $line | cut -f4 -d" ")
    sudo /sbin/iptables -A $RULE_COMMENT -i $dev \
                        -s $ifconfig_pool_remote_ip/32 -o $NIC \
                        -d $network/$netmask -j ACCEPT \
                        -m comment --comment $RULE_COMMENT
  done
sudo /sbin/iptables -A FORWARD -j $RULE_COMMENT
sudo /sbin/iptables -t nat -A POSTROUTING \
                      -s $ifconfig_pool_remote_ip/32 -o $NIC \
                      -j MASQUERADE \
                      -m comment --comment $RULE_COMMENT
fi

#log_file="/var/log/openvpn/remote.connect"

# Vars used:
#date_now="$(date +'%F-%H:%M')"

#line="User '$common_name' \
#connected $date_now \
#using $ifconfig_pool_remote_ip \
#from ${trusted_ip}:${trusted_port}"

# Append to the log
#echo "$line" >> "$log_file"

# END User Connect Accounting
exit 0
