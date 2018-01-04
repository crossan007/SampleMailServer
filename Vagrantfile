# -*- mode: ruby -*-
# vi: set ft=ruby :

##################################################
#
# Startup vagrant on 192.168.33.99
# Map the src dir to the default httpd www/public dir


Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"
  config.vm.network "private_network", ip: "192.168.33.125"
  config.vm.hostname = "SampleMail"
  config.vm.provision :shell, :path => "bootstrap.sh"
  config.vbguest.auto_update = false
  config.vm.provider "virtualbox" do |v|
    v.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
    v.memory = 2048
    v.cpus = 4
  end
end
