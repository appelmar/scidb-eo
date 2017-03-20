#!/bin/bash


if [ -f /opt/.scidbpw ]
then
  PW=`cat /opt/.scidbpw`
else
  echo "Please enter scidb password:"
  read -s PW
fi


#********************************************************
echo "***** Installing SciDB..."
#********************************************************


export SCIDB_VER=16.9
export SCIDB_SOURCE_PATH=/home/root/scidbtrunk
export SCIDB_BUILD_PATH=${SCIDB_SOURCE_PATH}/stage/build
export SCIDB_INSTALL_PATH=/opt/scidb/${SCIDB_VER}
export SCIDB_BUILD_TYPE=RelWithDebInfo
export PATH=${SCIDB_INSTALL_PATH}/bin:$PATH

# Make environment variables persistent for the whole system
echo "SCIDB_VER=${SCIDB_VER}" >> /etc/environment 
echo "SCIDB_SOURCE_PATH=${SCIDB_SOURCE_PATH}" >> /etc/environment 
echo "SCIDB_BUILD_PATH=${SCIDB_BUILD_PATH}" >> /etc/environment 
echo "SCIDB_INSTALL_PATH=${SCIDB_INSTALL_PATH}" >> /etc/environment 
echo "SCIDB_BUILD_TYPE=${SCIDB_BUILD_TYPE}" >> /etc/environment 
echo "PATH=${SCIDB_INSTALL_PATH}/bin:$PATH" >> /etc/profile # appending does not work in /etc/environment

HOSTNAME=$( hostname )

# replace config.ini
cp /home/root/conf/scidb_docker.ini ${SCIDB_INSTALL_PATH}/etc/config.ini
sed -i "s/localhost/$HOSTNAME/g" /${SCIDB_INSTALL_PATH}/etc/config.ini




#su postgres -c"psql -c\"CREATE ROLE scidb SUPERUSER LOGIN CREATEROLE CREATEDB UNENCRYPTED PASSWORD '${PW}';\" "
cd $SCIDB_SOURCE_PATH
deployment/deploy.sh prepare_postgresql postgres $PW 0.0.0.0/0 $HOSTNAME
su postgres -c"/opt/scidb/16.9/bin/scidb.py init-syscat scidb_docker /opt/scidb/16.9/etc/config.ini -p ${PW}"



# Run SciDB as scidb system user

echo $PW > /home/scidb/.scidbpw 
chown -R scidb:scidb /home/scidb

su scidb <<'EOF'
cd ~
export PGPASSWORD=`cat /home/scidb/.scidbpw`
echo -e "${HOSTNAME}:5432:scidb_docker:scidb:${PGPASSWORD}\n" >> ~/.pgpass # to be removed
chmod 0600 ~/.pgpass # this is important, otherwise file will be ignored
/opt/scidb/16.9/bin/scidb.py initall-force scidb_docker
echo 'PATH="/opt/scidb/16.9/bin:$PATH"' >> $HOME/.bashrc # Add scidb binaries to PATH
/opt/scidb/16.9/bin/scidb.py startall scidb_docker
source ~/.bashrc
PATH=/opt/scidb/16.9/bin:$PATH
rm /home/scidb/.scidbpw

#********************************************************
echo "***** ***** Testing installation using IQuery..."
#********************************************************
iquery -naq "store(build(<num:double>[x=0:4,1,0, y=0:6,1,0], random()),TEST_ARRAY)"
iquery -aq "list('arrays')"
iquery -aq "scan(TEST_ARRAY)"
EOF

echo -e "\nDONE. If not yet done, please remember to remove /opt/.scidbpass after finishing your SciDB cluster installation."

#rm -Rf $SCIDB_SOURCE_PATH

#git clone https://github.com/Paradigm4/dev_tools
#cd dev_tools
#make SCIDB_VARIANT=1507
#cp *.so /opt/scidb/16.9/lib/scidb/plugins # must be done on all nodes
#iquery -aq "load_library('dev_tools')"


