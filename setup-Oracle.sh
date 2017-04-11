#!/bin/bash

echo "Changing Timezone to America/New_York"
timedatectl set-timezone America/New_York

yum update -y
groupadd oinstall
groupadd dba
 
useradd -g oinstall -G dba oracle
echo -e "hackmenot\n" | passwd oracle --stdin

python /vagrant/add-params-to-sysctl.py

sysctl -p
sysctl -a
python /vagrant/add-oracle-limits.py

yum install -y zip unzip
unzip /vagrant/linuxamd64_12102_database_1of2.zip -d /stage/
unzip /vagrant/linuxamd64_12102_database_2of2.zip -d /stage/

chown -R oracle:oinstall /stage/

mkdir /u01
mkdir /u02
chown -R oracle:oinstall /u01
chown -R oracle:oinstall /u02
chmod -R 775 /u01
chmod -R 775 /u02
chmod g+s /u01
chmod g+s /u02

yum install -y binutils.x86_64 compat-libcap1.x86_64 \
gcc.x86_64 gcc-c++.x86_64 glibc.i686 glibc.x86_64 \
glibc-devel.i686 glibc-devel.x86_64 ksh compat-libstdc++-33 libaio.i686 \
libaio.x86_64 libaio-devel.i686 libaio-devel.x86_64 \
libgcc.i686 libgcc.x86_64 libstdc++.i686 libstdc++.x86_64 libstdc++- \
devel.i686 libstdc++-devel.x86_64 libXi.i686 libXi.x86_64 \
libXtst.i686 libXtst.x86_64 make.x86_64 sysstat.x86_64

su - oracle -c "cd /stage/database; ./runInstaller -silent -showProgress -responseFile /vagrant/db_install.rsp -waitForCompletion"

echo "Updating Oracle Bash Profile"
python /vagrant/update-bash-profile.py

echo "Reloading Oracle Bash Profile"
su - oracle -c ". .bash_profile"

echo "Configuring Firewall"
firewall-cmd --zone=public --add-port=1521/tcp --add-port=5500/tcp --add-port=5520/tcp --add-port=3938/tcp --permanent
firewall-cmd --reload

echo "Running oraInventory/orainstRoot.sh"
sh /u01/app/oraInventory/orainstRoot.sh

echo "Running root sh in Oracle Home"
echo -e "hackmenot\n" | sh /u01/app/oracle/product/12.1.0/db_1/root.sh

echo "Creating Database"
su - oracle -c "dbca -silent -createDatabase -templateName General_Purpose.dbc -gdbName orcl -createAsContainerDatabase true -sysPassword hackmenot -systemPassword hackmenot -emConfiguration NONE -storageType FS -characterSet AL32UTF8 -totalMemory 1024"
su - oracle -c "dbca -silent -createDatabase -templateName General_Purpose.dbc -gdbName WAREHOUSE -createAsContainerDatabase true -sysPassword hackmenot -systemPassword hackmenot -emConfiguration NONE -storageType FS -characterSet AL32UTF8 -totalMemory 1024"
su - oracle -c "dbca -silent -createDatabase -templateName General_Purpose.dbc -gdbName orcl2 -createAsContainerDatabase true -sysPassword hackmenot -systemPassword hackmenot -emConfiguration NONE -storageType FS -characterSet AL32UTF8 -totalMemory 1024"
su - oracle -c "netca -silent -responsefile /u01/app/oracle/product/12.1.0/db_1/network/install/netca_typ.rsp"

echo "Creating PDB Database for Unit tests"
su - oracle -c "cd /vagrant; sqlplus \"sys/hackmenot as sysdba\" @CreateUnitTestPdb.sql"

echo "Adding APPL Profile to orcl"
su - oracle -c "cd /vagrant; export ORACLE_SID=orcl; sqlplus \"sys/hackmenot as sysdba\" @CreateApplProfile.sql"

echo "Adding APPL Profile to orcl2"
su - oracle -c "cd /vagrant; export ORACLE_SID=orcl2; sqlplus \"sys/hackmenot as sysdba\" @CreateApplProfile.sql"

echo "Adding APPL Profile to WAREHOUS"
su - oracle -c "cd /vagrant; export ORACLE_SID=WAREHOUS; sqlplus \"sys/hackmenot as sysdba\" @CreateApplProfile.sql"

sh /vagrant/configure-oracle-start.sh
