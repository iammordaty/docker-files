FROM php:5.6-fpm

# installation

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    libssl-dev \
    locales

# PHP extensions

RUN pecl install inotify-0.1.6 && \
    docker-php-ext-enable inotify

RUN pecl install xdebug-2.5.5 && \
    docker-php-ext-enable xdebug

RUN pecl install mongo && \
    docker-php-ext-enable mongo

RUN apt-get autoremove && \
    apt-get clean

# locale

RUN echo "pl_PL.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "Europe/Warsaw" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    locale-gen --purge

# tweaks

RUN echo "xdebug.cli_color=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini;

# composer

RUN curl -sS https://getcomposer.org/installer | php  && \
    mv composer.phar /usr/local/bin/composer.phar
