#!/bin/bash

# install Shim
#cd ~ 
apt-get install -y --force-yes --no-install-recommends ruby-dev # for fpm / deb package building

git clone https://github.com/Paradigm4/shim
cd shim

protoc --proto_path=src/network/proto --cpp_out=src/network/proto src/network/proto/scidb_msg.proto
make SCIDB=/opt/scidb/15.12 
make SCIDB=/opt/scidb/15.12 install
gem install fpm
make SCIDB=/opt/scidb/15.12 deb-pkg # we install it from package to automatically use P4's SSL cert
gdebi -n shim_15.12_amd64.deb

/etc/init.d/shimsvc stop

# replace standard config by user provided
cp /home/root/conf/shim.conf /var/lib/shim/conf

# Setup digest authentification
if [ -f /opt/.scidbpw ]
then
  PW=`cat /opt/.scidbpw`
else
  echo "Please enter scidb password:"
  read -s PW
fi
echo "scidb:${PW}" >> /var/lib/shim/wwwroot/.htpasswd
chmod 600 /var/lib/shim/wwwroot/.htpasswd

/etc/init.d/shimsvc start

echo -e "\nDONE. If not yet done, please remember to remove /opt/.scidbpass after finishing your SciDB cluster installation."

