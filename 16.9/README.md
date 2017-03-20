# scidb-eo
Docker Images for Earth Observation Analytics with SciDB

---


## Prerequisites
- [Docker Engine](https://www.docker.com/products/docker-engine) (>1.10.0) 
- Around 15 GBs free disk space 
- Internet connection to download software and dependencies


## Getting started

_**Note**: Depending on your Docker configuration, the following commands must be executed with sudo rights._

### 1. Build the Docker image (1-2 hours)

The provided Docker image is based on a minimally sized Ubuntu OS. Among others, it includes the compilation and installation of [SciDB](http://www.paradigm4.com/), [GDAL](http://gdal.org/), SciDB extensions ([scidb4geo](https://github.com/appelmar/scidb4geo),  [scidb4gdal](https://github.com/appelmar/scidb4gdal)) and the installation of all dependencies. The image will take around 15 GBs of disk space. It can be created by executing:

```
git clone https://github.com/appelmar/scidb-eo && cd scidb-eo/16.9
docker build --tag="scidb-eo:16.9" . # don't miss the dot
``` 

_Note that by default, this includes a rather careful SciDB configuration with relatively little demand for main memory. You may modify `conf/scidb_docker.ini` if you have a powerful machine._


### 2. Start a container 

The following command starts a cointainer in detached mode, i.e. it will run as a service until it is explicitly stopped with `docker stop scidbeo-scalbf`.

_Note that the following command limits the number of CPU cores and main memory available to the container. Feel free to use different settings for `--cpuset-cpu` and `-m`._


```
sudo docker run -d --name="scidb-eo-1609" --cpuset-cpus="0,1" -m "4G" -h "scidb-eo-1609" -p 33330:22 -p 33331:8083 -p 33332:8787 scidb-eo:16.9 
```

The container is now accessible to the host system via SSH (port 33330), Shim (port 33331), and Rstudio Server (port 33332).


### 3. Clean up
To clean up your system, you can remove containers and the image with

1. `sudo docker rm -f scidb-eo-1609`  and 
2. `sudo docker rmi scidb-eo:16.09`.

	
	
## Files

| File        | Description           |
| :------------- | :-------------------------------------------------------| 
| install/ | Directory for installation scripts |
| install/install_scidb.sh | Installs SciDB 16.9 from sources |
| install/init_scidb.sh | Initializes SciDB based on provided configuration file |
| install/install_shim.sh | Installs Shim |
| install/install_scidb4geo.sh | Installs the scidb4geo plugin |
| install/install_gdal.sh | Installs GDAL with SciDB driver |
| install/install_R.sh | Installs the latest R version  |
| install/install_streaming.sh | Installs SciDB's streaming plugin |
| install/scidb-16.9.0.db1a98f.tgz| SciDB 16.9 source code |
| install/install.packages.R | Installs relevant R packages |
| conf/ | Directory for configuration files |
| conf/scidb_docker.ini | SciDB configuration file |
| conf/supervisord.conf | Configuration file to manage automatic starts in Docker containers |
| conf/iquery.conf | Default configuration file for iquery |
| conf/shim.conf | Default configuration file for shim |
| Dockerfile | Docker image definition file |
| container_startup.sh | Script that starts SciDB, Rserve, and other system services within a container  |



## License
This Docker image contains source code of SciDB in install/scidb-16.9.0.db1a98f.tgz. SciDB is copyright (C) 2008-2017 SciDB, Inc. and licensed under the AFFERO GNU General Public License as published by the Free Software Foundation. You should have received a copy of the AFFERO GNU General Public License. If not, see <http://www.gnu.org/licenses/agpl-3.0.html>

License of this Docker image can be found in the `LICENSE`file.

## Notes
This Docker image is for demonstration purposes only. Building the image includes both compiling software from sources and installing binaries. Some installations require downloading files which are not provided within this image (e.g. GDAL source code). If these links are not available or URLs become invalid, the build procedure might fail. 



----

## Author

Marius Appel  <marius.appel@uni-muenster.de>
