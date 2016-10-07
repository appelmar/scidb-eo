#!/bin/bash
apt-get install --no-install-recommends -y bc
# install devtools scidb plugin
cd /tmp
git clone https://github.com/paradigm4/dev_tools 
cd dev_tools 
make SCIDB=/opt/scidb/15.12
cp *.so /opt/scidb/15.12/lib/scidb/plugins

su scidb <<'EOF'
cd ~
source ~/.bashrc
#********************************************************
echo "***** ***** Testing installation using IQuery..."
#********************************************************
/opt/scidb/15.12/bin/iquery -aq "load_library('dev_tools')"
EOF

