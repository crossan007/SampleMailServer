#!/usr/bin/env bash

echo $(whoami)

echo "=========================================================="
echo "================  Update Base System  ===================="
echo "=========================================================="
sudo apt-get -qq update


echo "=========================================================="
echo "==========   Updating Vagrant Private Key     ============"
echo "=========================================================="
#
echo "Creating Vagrant user"
sudo useradd -m vagrant -s /bin/bash -d /home/vagrant
sudo usermod -aG sudo vagrant
echo -e "vagrant\nvagrant" | sudo passwd vagrant
echo "vagrant ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers

echo "Updating SSH Key as per https://www.vagrantup.com/docs/boxes/base.html"
sudo mkdir -p /home/vagrant/.ssh
chmod 0700 /home/vagrant/.ssh
wget --no-check-certificate \
    https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub \
    -O /home/vagrant/.ssh/authorized_keys
    
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh
sudo sed -i 's@^#AuthorizedKeysFile.*$@AuthorizedKeysFile %h/.ssh/authorized_keys@g' /etc/ssh/sshd_config
sudo service ssh restart