#!/bin/bash

# install SciDB streaming interface
# see https://github.com/Paradigm4/streaming
cd /tmp
git clone https://github.com/paradigm4/streaming 
cd streaming
make SCIDB=/opt/scidb/16.9
cp *.so /opt/scidb/16.9/lib/scidb/plugins

#su scidb <<'EOF'
#cd ~
#source ~/.bashrc
#/opt/scidb/16.9/bin/iquery -aq "load_library('stream')"
#/opt/scidb/16.9/bin/iquery -aq "stream(filter(build(<val:double>[i=0:0,1,0],0),false), 'printf \"1\nWhat is up?\n\"')"
#EOF

#jsonlite, 
echo -e "Installing SciDB streaming R package..."
R CMD INSTALL r_pkg