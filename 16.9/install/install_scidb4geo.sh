#!/bin/bash

apt-get install --no-install-recommends -y libboost-dev libcurl4-openssl-dev


cd /opt

# Build from source and create a binary installer package
git clone https://github.com/appelmar/scidb4geo --branch dev-16.9
cd scidb4geo

make SCIDB=/opt/scidb/16.9

cd install
chmod +x setup.sh
yes | ./setup.sh /opt/scidb/16.9/etc/config.ini


#su scidb <<'EOF'
#/opt/scidb/16.9/bin/iquery -aq "load_library('scidb4geo')"
#EOF

