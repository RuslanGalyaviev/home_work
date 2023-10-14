#!/bin/bash
echo "log_bin_trust_function_creators = 1" >> /etc/mysql/mysql.conf.d/mysqld.cnf
# Запуск MySQL-сервера
/etc/init.d/mysql start

# Создание базы данных Zabbix
mysql -e "CREATE DATABASE zabbix character set utf8 collate utf8_bin;"

# Создание пользователя Zabbix
mysql -e "CREATE USER 'zabbix'@'%' IDENTIFIED BY 'password';"

# Предоставление прав доступа пользователю к базе данных
mysql -e "GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'%';"

# Загрузка схемы базы данных Zabbix
mysql -u zabbix -ppassword zabbix < /usr/share/doc/zabbix-server-mysql/schema.sql
mysql -u zabbix -ppassword zabbix < /usr/share/doc/zabbix-server-mysql/images.sql
mysql -u zabbix -ppassword zabbix < /usr/share/doc/zabbix-server-mysql/data.sql
mysql -u zabbix -ppassword zabbix < /usr/share/doc/zabbix-server-mysql/double.sql
mysql -u zabbix -ppassword zabbix < /usr/share/doc/zabbix-server-mysql/history_pk_prepare.sql


# Установка таймзоны
mysql -e "SET time_zone = '+00:00';"

# Остановка MySQL-сервера
/etc/init.d/mysql stop
