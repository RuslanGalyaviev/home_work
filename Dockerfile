FROM ubuntu:20.04


ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Установка необходимых пакетов
RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    php-mysql \
    php-gd \
    php-ldap \
    php-xml \
    php-bcmath \
    php-mbstring \
    mysql-client \
    && apt-get clean

# Установка Zabbix Web
ARG ZBX_VERSION=6.0
ARG ZBX_SOURCES=https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu20.04_all.deb

RUN apt-get install -y wget && wget ${ZBX_SOURCES} && dpkg -i zabbix-release_6.0-4+ubuntu20.04_all.deb
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server


RUN apt-get update && apt-get install -y zabbix-server-mysql zabbix-frontend-php supervisor

COPY docker/init-db.sh /init-db.sh
COPY sql/schema.sql /usr/share/doc/zabbix-server-mysql/schema.sql
COPY sql/data.sql /usr/share/doc/zabbix-server-mysql/data.sql
COPY sql/double.sql /usr/share/doc/zabbix-server-mysql/double.sql
COPY sql/history_pk_prepare.sql /usr/share/doc/zabbix-server-mysql/history_pk_prepare.sql
COPY sql/images.sql /usr/share/doc/zabbix-server-mysql/images.sql
RUN chmod +x /init-db.sh
RUN /init-db.sh



# Копирование конфигурационных файлов
COPY docker/zabbix.conf.php /etc/zabbix/web/
COPY docker/apache-zabbix.conf /etc/apache2/sites-available/zabbix.conf
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# Настройка supervisord
RUN mkdir -p /etc/supervisor/conf.d
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chown -R www-data:zabbix /etc/zabbix/
RUN chmod -R 644 /etc/zabbix/

RUN a2enmod alias && a2enmod rewrite && a2ensite zabbix



# Экспозиция порта 80 для доступа к веб-интерфейсу
EXPOSE 80

# Запуск Apache в фоновом режиме
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
