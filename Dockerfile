FROM quay.io/spivegin/apache

ADD files/Caddy/Caddyfile /opt/caddy/
ADD files/php/fpm /etc/php/7.0/
WORKDIR /opt/tlm/html 

RUN apt-get update && apt-get install -y php7.0-zip &&\ 
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
RUN git clone https://github.com/cumulusclips/cumulusclips.git . &&\
    chown -R www-data:www-data .

EXPOSE 80

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]