FROM alpine:3.6
MAINTAINER Cr@zy <webmaster@crazyws.fr>

ENV DOKUWIKI_VERSION 2017-02-19e
ENV MD5_CHECKSUM 09bf175f28d6e7ff2c2e3be60be8c65f

RUN apk --no-cache add \
    php7 php7-openssl php7-zlib php7-mbstring php7-fpm php7-gd php7-session php7-xml nginx \
    supervisor curl tar

RUN mkdir -p /run/nginx && \
    mkdir -p /var/www && \
    cd /var/www && \
    curl -O -L "https://download.dokuwiki.org/src/dokuwiki/dokuwiki-$DOKUWIKI_VERSION.tgz" && \
    tar -xzf "dokuwiki-$DOKUWIKI_VERSION.tgz" --strip 1 && \
    rm "dokuwiki-$DOKUWIKI_VERSION.tgz"

ADD nginx.conf /etc/nginx/nginx.conf
ADD supervisord.conf /etc/supervisord.conf
ADD start.sh /start.sh

RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php7/php-fpm.ini && \
    sed -i -e "s|;daemonize\s*=\s*yes|daemonize = no|g" /etc/php7/php-fpm.conf && \
    sed -i -e "s|listen\s*=\s*127\.0\.0\.1:9000|listen = /var/run/php-fpm7.sock|g" /etc/php7/php-fpm.d/www.conf && \
    sed -i -e "s|;listen\.owner\s*=\s*\w*|listen.owner = nginx|g" /etc/php7/php-fpm.d/www.conf && \
    sed -i -e "s|;listen\.group\s*=\s*\w*|listen.group = nginx|g" /etc/php7/php-fpm.d/www.conf && \
    sed -i -e "s|user\s*=\s*\w*|user = nginx|g" /etc/php7/php-fpm.d/www.conf && \
    sed -i -e "s|;listen\.mode\s*=\s*|listen.mode = |g" /etc/php7/php-fpm.d/www.conf && \
    chmod +x /start.sh

EXPOSE 80
VOLUME [ "/var/www/conf", "/var/www/data/attic", "/var/www/data/media", "/var/www/data/media_attic", "/var/www/data/media_meta", "/var/www/data/meta", "/var/www/data/pages", "/var/www/lib/plugins", "/var/www/lib/tpl" ]

CMD /start.sh
