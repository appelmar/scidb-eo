#!/bin/bash

# install Shim
#cd ~ 
echo -e "Cloning SciDB streaming repository..."
cd /tmp
git clone https://github.com/Paradigm4/streaming
cd streaming

echo -e "Installing SciDB streaming plugin..."
make SCIDB=/opt/scidb/15.12/
cp libstream.so /opt/scidb/15.12/lib/scidb/plugins/

echo -e "Installing SciDB streaming R package..."
R CMD INSTALL r_pkg

echo -e "\nDONE. "

