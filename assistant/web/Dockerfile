FROM debian:jessie

# sources

# RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E9C74FEEA2098A6E && \
#     echo "deb http://packages.dotdeb.org/ wheezy-php56 all" > /etc/apt/sources.list.d/php.list

# installation

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    bash-completion \
    supervisor \
    locales \
    ca-certificates \
    vim \
    nginx-light \
    php5-fpm \
    php5-cli \
    php5-curl

RUN apt-get install -y \
    php5-dev

# PHP extensions

RUN pecl install inotify-0.1.6 && \
    echo "extension=inotify.so" > /etc/php5/mods-available/inotify.ini && \
    php5enmod inotify

RUN pecl install xdebug && \
    echo "zend_extension=xdebug.so" > /etc/php5/mods-available/xdebug.ini && \
    php5enmod xdebug

RUN pecl install mongo && \
    echo "extension=mongo.so" > /etc/php5/mods-available/mongo.ini && \
    php5enmod mongo

RUN apt-get autoremove && \
    apt-get clean

# locale

RUN echo "pl_PL.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "Europe/Warsaw" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    locale-gen --purge

# tweaks

RUN sed -e 's/;daemonize = yes/daemonize = no/' -i /etc/php5/fpm/php-fpm.conf && \
    sed -e 's/;listen\.owner/listen.owner/' -i /etc/php5/fpm/pool.d/www.conf && \
    sed -e 's/;listen\.group/listen.group/' -i /etc/php5/fpm/pool.d/www.conf && \
    echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
    echo "xdebug.cli_color=1" >> /etc/php5/mods-available/xdebug.ini;

# composer

RUN curl -sS https://getcomposer.org/installer | php  && \
    mv composer.phar /usr/local/bin/composer.phar

# configs

COPY ./conf/vhost.conf /etc/nginx/sites-available/default
COPY ./conf/supervisor.conf /etc/supervisor/conf.d/supervisor.conf
COPY ./conf/php.ini /etc/php5/fpm/conf.d/
COPY ./conf/php.ini /etc/php5/cli/conf.d/

CMD ["/usr/bin/supervisord"]
