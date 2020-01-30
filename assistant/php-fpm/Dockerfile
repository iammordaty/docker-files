FROM php:7.4-fpm

ENV TERM=xterm
ENV COMPOSER_ALLOW_SUPERUSER=1

# installation

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    git \
    libcurl4-gnutls-dev \
    libssl-dev \
    libzip-dev \
    locales \
    unzip \
    vim-tiny;

# PHP extensions

RUN pecl install inotify && \
    docker-php-ext-enable inotify

RUN docker-php-ext-configure zip && \
    docker-php-ext-install zip

RUN pecl install xdebug && \
    docker-php-ext-enable xdebug

RUN pecl install mongodb && \
    docker-php-ext-enable mongodb

RUN apt-get -y autoremove && \
    apt-get -y clean

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
