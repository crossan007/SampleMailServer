#!/usr/bin/env bash

. 00-configs.sh

useradd -r -m -d $MAIL_DIR  -s /sbin/nologin -c "Virtual maildir handler" -U $DOVECOT_USER
chmod 770 $MAIL_DIR
chown $DOVECOT_USER:$DOVECOT_USER $MAIL_DIR

#sudo sed -i -r 's/^#?\s*driver.*$/driver=mysql/g' /etc/dovecot/dovecot-sql.conf.ext
#sudo sed -i -r 's/^#?\s?connect.*$/connect = host=localhost dbname='"$PF_DB_NAME"' user='"$PF_DB_USER"' password='"$PF_DB_PASS"'/g' /etc/dovecot/dovecot-sql.conf.ext
#sudo sed -i -r 's/^#?\s?default_pass_scheme.*$/default_pass_scheme = MD5-CRYPT/g' /etc/dovecot/dovecot-sql.conf.ext


chown -R vmail:dovecot /etc/dovecot
chmod -R o-rwx /etc/dovecot