# scidb-eo
Docker Images for Earth Observation Analytics with SciDB

---

## Description
We use the multidimensional array based data management and analytical system [SciDB](http://www.paradigm4.com/) to scale up analyses of large Earth observation datasets.

This repositories contains [Docker](https://www.docker.com/) images that run different versions of SciDB (currently 15.7, 15.12, and 16.9). Detailed instructions how to run the images can be found in separate `README.md` files in each subfolder.

The images contain [SciDB](http://www.paradigm4.com/) and its web service [Shim](https://github.com/Paradigm4/shim), the [scidb4geo](https://github.com/appelmar/scidb4geo) extension for spacetime arrays, a [GDAL driver](https://github.com/appelmar/scidb4gdal) to ingest and download Earth Observation datasets, [R](https://www.r-project.org), and [r_exec](https://github.com/Paradigm4/r_exec) to run R within database queries.

If you are interested in how to use these tools, please also check out a blog post on [http://r-spatial.org/](http://r-spatial.org/r/2016/05/11/scalable-earth-observation-analytics.html).



## License
These Docker images contain source code of SciDB. SciDB is copyright (C) 2008-2017 SciDB, Inc and licensed
under the AFFERO GNU General Public License as published by the Free Software Foundation. You should have received a copy of the AFFERO GNU General Public License. If not, see <http://www.gnu.org/licenses/agpl-3.0.html>

License of the Docker images can be found in the `LICENSE` file.


## Notes

These Docker images are for demonstration purposes only. Builds include both compiling software from sources and installing binaries. Some installations require downloading files which are not provided within this image (e.g. GDAL source code). If these links are not available or URLs become invalid, the build procedure might fail. 

----

Authors(s)

Marius Appel - marius.appel@uni-muenster.de
