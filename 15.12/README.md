# scidb-gis
A Docker container for SciDB and its GIS interfaces.

## Getting started


Before building the Docker image, you should check and modify some setttings in following files:

### 1. Preparation
1. Open `Dockerfile` and set a secure password in line 5.
2. `conf/scidb_docker.ini` is the SciDB configuration file. Depending on your hardware, you might change the number of instances, threads, and main memory limits (see [SciDB manual](http://www.paradigm4.com/HTMLmanual/14.8/scidb_ug/ch02s06s02.html) for details on configuration parameters).
3. `install.sh` is a bash script that automatically builds the Docker image and deploys a corresponding container afterwards. To change names of the image and the running container, to change port forwarding, and to add further Docker constraints (e.g. on main memory consumption or available CPU cores).

Please notice that we do not recommended to forward the SciDB port (1239) as no user authentication is needed to connect to the databases so far.

### 2. Building the image and running a container
Building the image and deploying a container is as simple as

`./install.sh`.

Depending on your Docker configuration, you might need to run this with sudo rights.



### 3. Install software in the container

1. Login to the container as root user with `ssh -p SSHPORT  root@localhost` where you need to replace SSHPORT with the corresponding port forwarding settings in `install.sh`. 
2. Change the directory to `cd /home/root/install`. This directory contains a few scripts to install software inside the container.
3. Install the following software (in recommended order):
    1. SciDB `./install_scidb.sh`
	2. Shim `./install_shim.sh`
	3. scidb4geo `./install_scidb4geo.sh`
	4. scidb4gdal `./install_scidb4gdal.sh`
	5. R`./install_R.sh`
	6. r_exec `./install_r_exec.sh`
4. The container should now run SciDB and developed GIS tools.




## Files
Below, a list of files and their description can be found.

| File        | Description           |
| :------------- | :-------------------------------------------------------| 
| install/ | Directory for installation scripts |
| install/install_scidb.sh | Installs SciDB 14.12 |
| install/install_shim.sh | Installs Shim |
| install/install_scidb4geo.sh | Installs the scidb4geo plugin |
| install/install_gdal.sh | Installs GDAL with SciDB driver |
| install/install_R.sh | Installs the latest R version  |
| install/install_r_exec.sh | Installs the r_exec SciDB plugin to run R functions in AFL queries including Rserve |
| install/scidb-15.7.0.9267.tgz| SciDB source code |
| conf/ | Directory for configuration files |
| conf/scidb_docker.ini | SciDB configuration file |
| conf/supervisord.conf | Configuration file to manage autostarts in Docker containers |
| conf/iquery.conf | Default configuration file for iquery |
| conf/shim.conf | Default configuration file for shim |
| Dockerfile | Docker image definition file |
| container_startup.sh | Script that is automatically executed after the Docker container has started  |
| install.sh | Script to create and run a new SciDB Docker container  |



## License
This Docker image contains source code of SciDB in scidb-15.12.1.4cadab5.tar.gz. SciDB is copyright (C) 2008-2016 SciDB, Inc and licensed
under the AFFERO GNU General Public License as published by the Free Software Foundation. You should have received a copy of the AFFERO GNU General Public License

If not, see <http://www.gnu.org/licenses/agpl-3.0.html>

License of this Docker image can be found in the `LICENSE`file.

----

Authors(s)

Marius Appel - marius.appel@uni-muenster.de