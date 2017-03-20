#!/bin/bash

# install Rserve and r_exec
#apt-get install -qq --fix-missing -y --force-yes scidb-14.12-libboost1.54-all-dev liblog4cxx10-dev libpqxx3-dev
Rscript --vanilla -e 'install.packages(c("Rserve"), repos="http://cran.rstudio.com/")'
R CMD Rserve
git clone https://github.com/appelmar/r_exec.git --branch dev-15.12
cd r_exec 
make SCIDB=/opt/scidb/15.12
cp *.so /opt/scidb/15.12/lib/scidb/plugins
cd ..
rm -Rf r_exec

#su scidb <<'EOF'
#cd ~
#source ~/.bashrc
#********************************************************
#echo "***** ***** Testing installation using IQuery..."
#********************************************************
#/opt/scidb/15.12/bin/iquery -aq "load_library('r_exec')"
#/opt/scidb/15.12/bin/iquery -aq "r_exec(build(<z:double>[i=1:100,10,0],0),'expr=x<-runif(1000);y<-runif(1000);list(sum(x^2+y^2<1)/250)')"
#EOF

