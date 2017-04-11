#!/bin/bash
sed -i -e 's/:N/:Y/g' /etc/oratab


cp /vagrant/dbora /etc/init.d/dbora

chgrp dba /etc/init.d/dbora
chmod 750 /etc/init.d/dbora
ln -s /etc/init.d/dbora /etc/rc.d/rc0.d/K01dbora
ln -s /etc/init.d/dbora /etc/rc.d/rc3.d/S99dbora 
ln -s /etc/init.d/dbora /etc/rc.d/rc5.d/S99dbora
