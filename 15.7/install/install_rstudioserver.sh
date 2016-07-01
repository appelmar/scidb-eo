#!/bin/bash
wget https://download2.rstudio.org/rstudio-server-0.99.467-amd64.deb
gdebi -n rstudio-server-0.99.467-amd64.deb
rstudio-server verify-installation
rstudio-server verify-installation
rm rstudio-server-0.99.467-amd64.deb
