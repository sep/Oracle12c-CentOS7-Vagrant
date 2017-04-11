
This Vagrant project will provision a VirtualBox VM with CentOS7 and have Oracle 12c installed and configured. The provisioning scripts automate a manual process for installing oracle and configuring oracle to startup when the OS boots. The manual steps can be found in the  Reference folder in this repository.

To use the vagrant VM, do the following:

1. Download the Oracle 12c linuxamd64_12102_database_1of2.zip and linuxamd64_12102_database_2of2.zip and copy it into the root folder of the repository

1. Download and install Chocolatey. Open up cmd prompt as admin and run  <code>@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString
('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
</code>

1. Run <code>cinst vagrant -y</code> in a new cmd prompt as administrator

1. Change directory to the root folder of the repository

1. Run <code>vagrant up</code>

1. Wait several minutes for your new VM to build

For more about Vagrant see [https://www.vagrantup.com/docs/](https://www.vagrantup.com/docs/)
