#!/usr/bin/env bash

# Source https://github.com/postfixadmin/postfixadmin/blob/master/INSTALL.TXT


# DB Setup
. 00-configs.sh

sudo mysql -u"$DB_USER" -p"$DB_PASS" -e "CREATE DATABASE $PF_DB_NAME;"
sudo mysql -u"$DB_USER" -p"$DB_PASS" -e "CREATE USER '$PF_DB_USER'@'$DB_HOST' IDENTIFIED BY '$DB_PASS';"
sudo mysql -u"$DB_USER" -p"$DB_PASS" -e "GRANT ALL PRIVILEGES ON $PF_DB_NAME.* TO '$PF_DB_USER'@'$DB_HOST';"

pwd 
echo "Updating config file"
cp ./postfixadmin/config.php ./postfixadmin/temp/config.local.php
sudo sed -i "s/_DB_USER_/$DB_USER/g" ./postfixadmin/temp/config.local.php
sudo sed -i "s/_DB_PASS_/$DB_PASS/g" ./postfixadmin/temp/config.local.php
sudo sed -i "s/_PF_DB_NAME_/$PF_DB_NAME/g" ./postfixadmin/temp/config.local.phpp

echo "Downloading Postfix Admin"
wget https://github.com/postfixadmin/postfixadmin/archive/postfixadmin-3.1.tar.gz -O ./postfixadmin/temp/source.tar.gz
tar -xzvf ./postfixadmin/temp/source.tar.gz -C ./postfixadmin/temp


echo "Configuring system user for Apache to serve PostFixAdmin"
sudo useradd -s /bin/false -m -d /home/$PF_APACHE_USER  -U $PF_APACHE_USER
sudo echo -e "$PF_APACHE_PASSWD\n$PF_APACHE_PASSWD" | sudo passwd $PF_APACHE_USER
sudo -u $PF_APACHE_USER mkdir $PF_VSERVER_DOC_ROOT

echo "Copying PostFix admin and config to user dir"
sudo -u $PF_APACHE_USER  mv ./postfixadmin/temp/postfixadmin-postfixadmin-3.1/* $PF_VSERVER_DOC_ROOT
sudo -u $PF_APACHE_USER  mv ./postfixadmin/temp/config.local.php $PF_VSERVER_DOC_ROOT


echo "Building Apache config"
cp ./postfixadmin/postfixadmin.conf.default ./postfixadmin/temp/postfix.admin.conf
sudo sed -i "s@_PF_VSERVER_NAME_@$PF_VSERVER_NAME@g" ./postfixadmin/temp/postfix.admin.conf
sudo sed -i "s@_PF_VSERVER_DOC_ROOT_@$PF_VSERVER_DOC_ROOT@g" ./postfixadmin/temp/postfix.admin.conf
sudo sed -i "s/_PF_APACHE_USER_/$PF_APACHE_USER/g" ./postfixadmin/temp/postfix.admin.conf
sudo cp ./postfixadmin/temp/postfix.admin.conf /etc/apache2/sites-available/postfix.admin.conf
sudo a2ensite postfix.admin.conf
sudo service apache2 reload