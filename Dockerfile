FROM quay.io/spivegin/apache

ADD files/Caddy/Caddyfile /opt/caddy/
ADD files/php/fpm /etc/php/7.0/
WORKDIR /opt/tlm/html 

RUN apt-get update &&\
    apt-get purge -y libapache2-mod-php7.0 libapache2-mod-php &&\
    apt-get install -y libapache2-mod-php7.0 libapache2-mod-php php7.0-zip php7.0-opcache &&\
    a2enmod php7.0 &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
RUN git clone https://github.com/cumulusclips/cumulusclips.git &&\
    chown -R www-data:www-data .

EXPOSE 80
ADD files/apache2/sites-enabled/00-default.conf /etc/apache2/sites-enabled/
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]