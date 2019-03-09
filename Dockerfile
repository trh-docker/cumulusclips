FROM quay.io/spivegin/apache

WORKDIR /opt/tlm/html 

RUN git clone https://github.com/cumulusclips/cumulusclips.git &&\
    chown -R www-data:www-data .

EXPOSE 80
ADD files/apache2/sites-enabled/00-default.conf /etc/apache2/sites-enabled/
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]