FROM quay.io/spivegin/php7

ADD files/Caddy/Caddyfile /opt/caddy/
ADD files/php/fpm /etc/php/7.0/
WORKDIR /opt/tlm/html 

RUN apt-get update && apt-get install -y php7.0-zip apache2 &&\ 
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
RUN git clone https://github.com/cumulusclips/cumulusclips.git . &&\
    chown -R www-data:www-data . && ln -s /opt/tlm/html /var/www

EXPOSE 80

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]