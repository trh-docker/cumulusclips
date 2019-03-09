FROM quay.io/spivegin/apache

ADD files/Caddy/Caddyfile /opt/caddy/
ADD files/php/fpm /etc/php/7.0/
WORKDIR /opt/tlm/html 

RUN apt-get update && apt-get install -y php7.0-zip libapache2-mod-php7.0 php7.0-opcache &&\ 
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
RUN git clone https://github.com/cumulusclips/cumulusclips.git &&\
    chown -R www-data:www-data .

EXPOSE 80
ADD files/apache2/sites-enabled/00-default.conf /etc/apache2/sites-enabled/
ADD files/apache2/conf-available/* /etc/apache2/conf-available/
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]