FROM php:8.3-fpm
ARG USER_ID
ARG GROUP_ID

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions gd xdebug @composer bcmath pdo pdo_mysql mysqli

#RUN docker-php-ext-enable xdebug

ADD ./php.ini /usr/local/etc/php/php.ini

RUN usermod -u ${USER_ID} www-data && groupmod -g ${GROUP_ID} www-data

WORKDIR /var/www/project

USER "${USER_ID}:${GROUP_ID}"

CMD ["php-fpm"]
