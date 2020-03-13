FROM            ubuntu:18.04

ENV             DEBIAN_FRONTEND="noninteractive"

ENV             POWERADMIN_VERSION="2.1.7"
ENV             POWERADMIN_URL="https://codeload.github.com/poweradmin/poweradmin/tar.gz/v${POWERADMIN_VERSION}"

RUN             apt-get update --fix-missing && \
                apt-get -y upgrade && \
                apt-get install -y \
                apt-transport-https \
                curl \
                gnupg \
                supervisor \
                tzdata \
                vim

COPY            "conf/powerdns/pdns.list" "/etc/apt/sources.list.d/pdns.list"
COPY            "conf/powerdns/pdns" "/etc/apt/preferences.d/pdns"
RUN             curl "https://repo.powerdns.com/FD380FBB-pub.asc" | apt-key add -

RUN             apt-get update --fix-missing && \
                apt-get install -y \
                apache2 \
                dnsmasq \
                dnsutils \
                libapache2-mod-php \
                libmcrypt-dev \
                libmysqlclient-dev \
                libxmlsec1-dev \
                locales \
                net-tools \
                pdns-backend-pgsql \
                pdns-server \
                pdns-tools \
                php \
                php-apcu \
                php-bcmath \
                php-curl \
                php-dev \
                php-fpm \
                php-gd \
                php-geoip \
                php-intl \
                php-imagick \
                php-mbstring \
                php-pear \
                php-pgsql \
                php-xml \
                php-zip \
                postgresql-all \
                pkg-config && \
                apt-get clean all

RUN             echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen && \
                echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
                locale-gen && \
                cp -f "/usr/share/zoneinfo/Europe/Moscow" "/etc/localtime"

RUN             pecl channel-update pecl.php.net && \
                yes | pecl install mcrypt-1.0.1 && \
                sed -i "/\[PHP\]/a extension=mcrypt" "/etc/php/7.2/apache2/php.ini"

RUN             rm -Rf "/var/www/html" && \
                curl "$POWERADMIN_URL" -o "/tmp/poweradmin.tar.gz" && \
                cd "/tmp" && tar xf "poweradmin.tar.gz" && \
                mv "poweradmin-${POWERADMIN_VERSION}" "/var/www/html" && \
                rm -Rf "/var/www/html/install" "powerdns.tar.gz"

COPY            "conf/dnsmasq.conf" "/etc/dnsmasq.conf"

COPY            "conf/postgresql/pg_hba.conf" "/var/lib/postgresql/10/main/pg_hba.conf"
COPY            "conf/postgresql/postgresql.conf" "/var/lib/postgresql/10/main/postgresql.conf"

COPY            "conf/powerdns/config.inc.php" "/var/www/html/inc/config.inc.php"
COPY            "conf/powerdns/pdns.conf" "/etc/powerdns/pdns.conf"

COPY            "conf/supervisord.conf" "/etc/supervisord.conf"

COPY            "conf/postgresql/sql" "/tmp/sql"
COPY            "scripts" "/tmp/scripts"

ENV             DNSMASQ_POWERDNS_ZONE="terraform-multicloud-proxy.net"
ENV             POWERADMIN_ADMIN_PASSWORD="admin"
ENV             POWERDNS_API_KEY="powerdns"
ENV             POSTGRES_ADMIN_PASSWORD="admin"

RUN             sed -i "s/POWERDNS_ZONE/${DNSMASQ_POWERDNS_ZONE}/" "/etc/dnsmasq.conf" && \
                sed -i "s/POSTGRES_ADMIN_PASSWORD/${POSTGRES_ADMIN_PASSWORD}/" "/tmp/sql/10_create_admin_user.sql" && \
                sed -i "s/POWERDNS_API_KEY/${POWERDNS_API_KEY}"/ "/etc/powerdns/pdns.conf" && \
                sed -i "s/POWERADMIN_ADMIN_PASSWORD/$(echo -n $POWERADMIN_ADMIN_PASSWORD | md5sum | cut -f1 -d ' ')/" "/tmp/sql/40_create_powerdns_tables.sql"

# dnsmasq
EXPOSE          53/tcp
EXPOSE          53/udp

# apache
EXPOSE          80/tcp

# powerdns
EXPOSE          5353/udp
EXPOSE          8081/tcp

# postgres
EXPOSE          5432/tcp

CMD             ["supervisord", "-c", "/etc/supervisord.conf"]