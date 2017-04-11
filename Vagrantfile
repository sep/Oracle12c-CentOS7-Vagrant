# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most cuommon configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "jhcook/centos7"
  config.vm.network :forwarded_port, guest: 22, host: 2223, id:"ssh", auto_correct:true
  config.vm.network "private_network", ip: "192.168.56.102"
  config.vm.provision "shell", path: "setup-Oracle.sh"
  config.ssh.username = 'vagrant'
  config.ssh.password = 'vagrant'
  config.vm.provider "virtualbox" do |vb|
    # Customize the amount of memory on the VM:
     vb.memory = "5046"
   end
end
