FROM ubuntu:14.04
MAINTAINER Marius Appel <marius.appel@uni-muenster.de>


# Change this password before deployment!
RUN echo 'xxxx.xxxx.xxxx'  >> /opt/.scidbpw
RUN chmod 600 /opt/.scidbpw


# Set environment and locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN export LANGUAGE=en_US.UTF-8 && export LANG=en_US.UTF-8 && export LC_ALL=en_US.UTF-8 && locale-gen en_US.UTF-8 && dpkg-reconfigure locales && update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 LC_MESSAGES=n_US.UTF-8 && env




# install basic packages
RUN apt-get -qq update && apt-get install --fix-missing -y --force-yes --no-install-recommends \
	openssh-server \
	openssl \
	sudo \
	wget \
	gdebi \
	nano \  
	sshpass \ 
	git-core \ 
	apt-transport-https \
	net-tools \
	libedit-dev \
	libtool \
	autotools-dev \
	supervisor



# Configure users
RUN 	useradd --home /home/scidb --create-home --uid 1006 --group sudo --shell /bin/bash scidb && \
	echo 'root:'$(cat /opt/.scidbpw) | chpasswd && \
	echo 'scidb:'$(cat /opt/.scidbpw) | chpasswd 


RUN mkdir /var/run/sshd
RUN mkdir /home/scidb/data
RUN mkdir /home/scidb/catalog



# Configure SSH
RUN sed -i 's/PermitRootLogin.*/#PermitRootLogin/g' /etc/ssh/sshd_config # required for Ubuntu 14.04
RUN 	echo 'StrictHostKeyChecking no' >> /etc/ssh/ssh_config && stop ssh && start ssh


# Configure Postgres 
#RUN echo 'host  all all 255.255.0.0/16   md5' >> /etc/postgresql/9.3/main/pg_hba.conf
#RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf





# Add files
COPY install			/home/root/install
COPY conf 			/home/root/conf
RUN sed -i 's/db_passwd.*/#db_passwd/g' /home/root/conf/scidb_docker.ini && echo "db_passwd=$(cat /opt/.scidbpw)" >> /home/root/conf/scidb_docker.ini
COPY conf/supervisord.conf 	/etc/supervisor/conf.d/
COPY container_startup.sh 	/opt/container_startup.sh 


RUN chown -R root:root /home/root
RUN chown -R scidb:scidb /home/scidb 
RUN chmod +x  /home/root/install/*.sh
RUN chmod +x  /opt/container_startup.sh 


EXPOSE 22 8083 1239 5432 

CMD ["/usr/bin/supervisord"]



