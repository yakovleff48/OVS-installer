# OVS-installer
For OpenVPN installer and configuration script package
Данный скрипт предназначен для установки и конфигурации OpenVPN сервера (работает с дистрибутивами Debian >= 8 и Ubuntu >=16.04) , 
также для создания клинтских сертификатов с предостунавленными правилами доступа
к определенным ресурсам LAN!
Так же запуском данного скрипта, возможно редактировать доступы имеющихся клиентов,
отзывать сертификаты, а так же удалить сервер!

0.Данный установщик - это пакет скриптов (сам установщик и дополнительные скрипты для конфигации, которые будут скопированы в определенное место сервера)
1.Скрипт нужно запускать от имени пользователя с правами root и отвечать на вопросы по ходу исполнения установщика-конфигуратора
2.Пакет упакован в zip архив (OpenVPN_installer.zip), данный архив необходимо скопировать в любое удобное место на сервере, разархивировать (unzip OpenVPN_installer.zip 
если архиватор не устновлен, устанить: apt-get install unzip)
3.Зайти в папку OpenVPN_installer (cd OpenVPN_installer )и запустить install.sh (./install.sh), будут произведены предварительные действия и запущен установщик-конфигуратор
4.Для последующего использования данного ПО (для редактирования клиентского доступа, отзыва сертификатов, и и других действий управления клиентами и сервером нужно ввести в консоли команду ovs
5.Для того чтобы вновь установить OpenVPN сервер, необходимо проделать шаг 3 
6.Для мониторинга статуса openvpn сервера (статус сервера и статус подключенных клиентов), предусмотрен веб инстумент, сервис доступен по адресу:
http://ip-сервера:8888
7.Лог подключения-отключения клиентов ведется в файле /var/log/openvpn/remote.connect