#!/bin/bash
# This script automatically starts all relevant services on the container

echo -e "\n\nStarting required services..."
service ssh start 
sleep 2
echo -e "... sshd started"




service postgresql start
sleep 10
echo -e "... postgresql started"

if [ -f /opt/SCIDB_INIT_WHEN_RESTART  ]
then
  /home/root/install/init_scidb.sh # re init SciDB
  cd /opt/scidb4geo/install && yes | ./setup.sh /opt/scidb/15.12/etc/config.ini
  rm -f /opt/SCIDB_INIT_WHEN_RESTART
fi


sudo -H -u scidb bash -c '/opt/scidb/15.12/bin/scidb.py stop-all scidb_docker' 
sudo -H -u scidb bash -c '/opt/scidb/15.12/bin/scidb.py start-all scidb_docker' 
sleep 5
echo -e "... scidb started"

service shimsvc start  
sleep 2
echo -e "... shim started"

R CMD Rserve --vanilla &>/dev/null
sleep 2
echo -e "... rserve started"

/usr/lib/rstudio-server/bin/rserver
sleep 2
echo -e "... rstudio-server started"

su - scidb -c"/opt/scidb/15.12/bin/iquery -anq \"load_library('r_exec');\""
su - scidb -c"/opt/scidb/15.12/bin/iquery -anq \"load_library('scidb4geo');\""
su - scidb -c"/opt/scidb/15.12/bin/iquery -anq \"load_library('dense_linear_algebra');\""
#su - scidb -c"/opt/scidb/15.12/bin/iquery -anq \"load_library('stream');\""
echo -e "... scidb plugins loaded"

