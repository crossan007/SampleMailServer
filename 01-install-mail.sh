#!/usr/bin/env bash


apt-get install -q ssl-cert
make-ssl-cert generate-default-snakeoil --force-overwrite

apt-get install --assume-yes lamp-server^

apt-get install --assume-yes libapache2-mpm-itk

apt-get install --assume-yes \
  php7.0-mcrypt \
  php7.0-curl \
  php7.0-gd \
  php7.0-mbstring \
  php-apcu \
  php-xml-parser

  apt-get install --assume-yes mail-server^
  
  apt-get install --assume-yes \
  postfix-mysql \
  dovecot-mysql \
  postgrey \
  amavis \
  clamav \
  clamav-daemon \
  spamassassin \
  libdbi-perl \
  libdbd-mysql-perl \
  php7.0-imap \
  postfix-policyd-spf-python

