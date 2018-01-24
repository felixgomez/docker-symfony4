FROM php:7.2-fpm
WORKDIR "/application"

# Install git, unzip
RUN apt-get update \
    && apt-get -y install git unzip 

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# php-intl (as example of extension)
RUN apt-get update \
    && apt-get install -y libicu-dev \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
    && docker-php-ext-install intl
    
# redis (as example of another extension from downloaded source code)
RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/3.1.6.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mkdir -p /usr/src/php/ext/redis \
    && mv phpredis-3.1.6/* /usr/src/php/ext/redis/ \
    && docker-php-ext-install redis

# Fix permission problems
RUN usermod -u 1000 www-data 

RUN echo 'alias ll="ls -l"' >> ~/.bashrc
RUN echo 'alias sf="php bin/console"' >> ~/.bashrc
