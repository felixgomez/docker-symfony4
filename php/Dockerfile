FROM php:7.2.6-apache-stretch

ARG LOCAL_UID
ARG LOCAL_GID
# Fix permission problems
RUN usermod -u ${LOCAL_UID:-33} www-data && groupmod -g ${LOCAL_GID:-33} www-data

COPY virtualHost.conf /etc/apache2/sites-enabled/000-a.conf

RUN a2enmod rewrite

# Install git, unzip
RUN apt-get update \
    && apt-get -y install git unzip vim

# php-intl (as example of extension)
RUN apt-get update \
    && apt-get install -y libicu-dev \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
    && docker-php-ext-install intl

# Install zip (phpUnit requirement)
RUN apt-get update && \
    apt-get install -y \
    zlib1g-dev \
    && docker-php-ext-install zip

# Install mysql
RUN docker-php-ext-install mysqli

RUN apt-get update && apt-get install -y mysql-client && rm -rf /var/lib/apt

# install gd mbstring pdo
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libpq-dev \
 	&& rm -rf /var/lib/apt/lists/* \
 	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mbstring pdo pdo_mysql pdo_pgsql

RUN echo 'alias ll="ls -l"' >> ~/.bashrc
RUN echo 'alias sf="php bin/console"' >> ~/.bashrc
