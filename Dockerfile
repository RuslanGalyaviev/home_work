FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
ENV HOME /root


RUN apt-get update && apt-get install -y wget locales && rm -rf /var/lib/apt/lists/*
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

RUN wget -q https://repo.zabbix.com/zabbix/6.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.4-1+ubuntu20.04_all.deb


RUN dpkg -i zabbix-release_6.4-1+ubuntu20.04_all.deb
RUN apt-get update && apt-get -y install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent mysql-server

RUN echo "log_bin_trust_function_creators = 1" >> /etc/mysql/mysql.conf.d/mysqld.cnf

RUN service mysql start && \
    mysql -e "create database zabbix character set utf8 collate utf8_bin;" && \
    mysql -e "create user 'zabbix'@'localhost' identified by 'zabbix';" && \
    mysql -e "grant all privileges on zabbix.* to 'zabbix'@'localhost';" && \
    mysql -e "flush privileges;" && \
    zcat "/usr/share/zabbix-sql-scripts/mysql/server.sql.gz" | mysql --default-character-set=utf8mb4 -uzabbix -pzabbix zabbix


RUN sed -i '/# DBHost=localhost/a DBHost=127.0.0.1' "/etc/zabbix/zabbix_server.conf"
RUN sed -i '/### Option: DBPassword/a DBPassword=zabbix' "/etc/zabbix/zabbix_server.conf"


CMD ["/bin/bash", "-c", "service mysql restart && service zabbix-server restart && service zabbix-agent restart && service apache2 restart && tail -f /dev/null"]
