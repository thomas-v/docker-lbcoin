FROM php:8.0-apache

EXPOSE 80

RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y zip unzip

RUN mkdir -p /prod/fizzbuzz-api
WORKDIR /prod/fizzbuzz-api

RUN git clone https://github.com/thomas-v/lbcoin.git ./
RUN php composer.phar install

COPY fizzbuzz-api.conf /etc/apache2/sites-available/fizzbuzz-api.conf

RUN docker-php-ext-install pdo pdo_mysql

RUN a2dissite 000-default.conf
RUN a2ensite fizzbuzz-api.conf
RUN a2enmod rewrite
