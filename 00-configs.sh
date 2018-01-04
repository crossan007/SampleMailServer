#!/usr/bin/env bash

DOVECOT_USER=vmail
MAIL_DIR=/var/$DOVECOT_USER
DB_USER="root"
DB_PASS="root"
DB_HOST="localhost"

PF_APACHE_USER="postfixadmin"
PF_APACHE_PASSWD="postfixadmin"
PF_DB_USER="postfix"
PF_DB_PASS="postfix"
PF_DB_NAME="postfix"
PF_VSERVER_NAME="postfix.admin"
PF_VSERVER_DOC_ROOT=/home/$PF_APACHE_USER/public_html
