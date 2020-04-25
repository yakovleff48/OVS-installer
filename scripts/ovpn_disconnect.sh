#!/usr/bin/env bash
#
#  Remove iptables rules based on CCD client config.
#

# 1st param - name of table
# 2nd param - rule comment
get_iptables_rule_by_comment () {
  echo $(sudo /sbin/iptables -nL $1 --line-numbers | grep -m 1 $2 | cut -f1 -d" ")
}

get_iptables_nat_rule_by_comment () {
  echo $(sudo /sbin/iptables -nL $1 -t nat --line-numbers | grep -m 1 $2 | cut -f1 -d" ")
}

RULE_COMMENT="OVPN_"$common_name

# Delete link to FORWARD rule first
rule_number=$(get_iptables_rule_by_comment FORWARD $RULE_COMMENT)
if [ "$rule_number" ]; then
  sudo /sbin/iptables -D FORWARD $rule_number
fi

# Delete MASQUERADE rule
rule_number=$(get_iptables_nat_rule_by_comment POSTROUTING $RULE_COMMENT)
if [ "$rule_number" ]; then
  sudo /sbin/iptables -D POSTROUTING $rule_number -t nat
fi

# Delete user-specific chain
if [ "$RULE_COMMENT" ]; then
  echo $RULE_COMMENT
  sudo /sbin/iptables -F $RULE_COMMENT
  sudo /sbin/iptables -X $RULE_COMMENT
fi
log_file="/var/log/openvpn/remote.connect"

if date --help >/dev/null 2>&1; then
	get_date() { date -d "@$1" +'%F-%H:%M'; }
else
	get_date() { date -r "$1" +'%F-%H:%M'; }
fi

# Vars used in log line:
#time:
date_from="$(get_date $time_unix)"
unix_to=$(($time_unix + $time_duration))
date_to="$(get_date $unix_to)"
time_h=$(($time_duration / 3600))
time_m=$(( $time_duration % 3600 / 60 ))
#bw:
bw_up="$(( $bytes_received / 1000**2 ))\
.$(( $bytes_received % 1000**2 / 1000 ))"
bw_down="$(( $bytes_sent / 1000**2 ))\
.$(( $bytes_sent % 1000**2 / 1000 ))"


# Format the line for export:
# Append it to the log
#line="Пользователь: '$common_name' \
#Начало_сессии: $date_from \
#Внутренний_IP_VPN: $ifconfig_pool_remote_ip \
#Внешний_IP_пользователя: $trusted_ip:$trusted_port \
#Продолжительность_сессии: $time_h"ч":$time_m"м" \
#Трафик(up/down): $bw_up/$bw_down"

line="$common_name \
$date_from \
$ifconfig_pool_remote_ip \
$trusted_ip:$trusted_port \
$time_h"ч":$time_m"м" \
$bw_up/$bw_down"



echo "$line" >> "$log_file"

# END User Disconnect Accounting
exit 0
