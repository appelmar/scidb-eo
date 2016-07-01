#!/bin/bash

apt-get install --no-install-recommends -y libboost-dev libcurl4-openssl-dev


cd /tmp

# Build from source and create a binary installer package
git clone https://github.com/mappl/scidb4geo --branch dev-15.12
cd scidb4geo

make SCIDB=/opt/scidb/15.12

cd install
chmod +x setup.sh
yes | ./setup.sh /opt/scidb/15.12/etc/config.ini


su scidb <<'EOF'
/opt/scidb/15.12/bin/iquery -aq "load_library('scidb4geo')"
EOF

cd ../../
rm -Rf scidb4geo
