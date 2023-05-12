# Обновляем Ubuntu
apt -y update && apt -y upgrade


# Настройки времени
apt install -y chrony
timedatectl set-timezone Europe/Moscow
systemctl enable chrony

# Настройки брандмауэра
iptables -I INPUT 1 -p tcp --match multiport --dports 80,443 -j ACCEPT
iptables -I INPUT 1 -p tcp --match multiport --dports 20,21,60000:65535 -j ACCEPT
apt install -y iptables-persistent
netfilter-persistent save

# PPA PHP
apt install -y lsb-release gnupg2 ca-certificates apt-transport-https software-properties-common
add-apt-repository ppa:ondrej/php

# Установка PHP
PHP_VER=8.2
apt install php${PHP_VER} php${PHP_VER}-{cgi,cli,fpm,bcmath,xml,mysqli,zip,intl,ldap,gd,bz2,curl,mbstring,gettext,json,pdo_mysql,xsl}
systemctl enable php${PHP_VER}-fpm

# Установка и настройка Nginx
apt install Nginx
php default-nginx.php
systemctl enable nginx
systemctl reload nginx
nginx -t && nginx -s reload
