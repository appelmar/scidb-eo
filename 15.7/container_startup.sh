#!/bin/bash
# This script automatically starts all relevant services on the container

#export SCIDB_BIN=/opt/scidb/14.12/bin

echo -e "\n\nStarting required services..."
/usr/sbin/sshd -D >/dev/null &
echo -e "... sshd started"

service postgresql start >/dev/null
sleep 2
echo -e "... postgresql started"

su - scidb -c"${SCIDB_BIN}/scidb.py startall scidb_docker" >/dev/null
sleep 5
echo -e "... scidb started"

service shimsvc start  >/dev/null
sleep 2
echo -e "... shim started"


#rstudio-server start
#sleep 3
#echo -e "... rstudio-server started"

R CMD Rserve
sleep 3
echo -e "... rserve started"


#su - scidb -c"${SCIDB_BIN}/iquery -anq \"load_library('r_exec');\""
#su - scidb -c"${SCIDB_BIN}/iquery -anq \"load_library('scidb4geo');\""
#sleep 2
#echo -e "... scidb plugins loaded"



echo -e "DONE.\n\n"
