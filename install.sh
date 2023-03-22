#!/bin/bash
#Копирование установщика-конфигуратора OpenVPN сервера в каталог /bin
cp scripts/ovs /bin
chmod 755 /bin/ovs
#Копирование пользотельских скриптов во врененный каталог
cp scripts/ovpn_connect.sh /tmp/  
cp scripts/ovpn_disconnect.sh /tmp/
cp scripts/ovpn-mon/openvpn-monitor.conf /tmp
apt-get update && apt-get install curl -y
echo "Все предватительные шаги пройдены, теперь можно переходить к установке и конфигурированию"
echo "OpenVPN сервера и выпуску клиентских сертификатов"
read -n1 -r -p "Press any key to continue..."
/bin/ovs
