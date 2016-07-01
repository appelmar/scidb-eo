#!/bin/bash
export CONTAINER_NAME=scidb-gis-1512
export IMAGE_NAME=${CONTAINER_NAME}_img
export HOST_PORT_SSH=36360
export HOST_PORT_SHIM=$(( HOST_PORT_SSH + 1))
export HOST_PORT_SCIDB=$(( HOST_PORT_SSH + 2))
export HOST_PORT_TOMCAT=$(( HOST_PORT_SSH + 3))
export HOST_SHAREDFOLDER=~/docker.${CONTAINER_NAME}

echo "Creating docker image ${IMAGE_NAME} and container ${CONTAINER_NAME}."
read -p "Are you sure? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi


docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME
#docker rmi $IMAGE_NAME
docker build --tag="${IMAGE_NAME}" .

docker run -d --name="${CONTAINER_NAME}" --cpuset-cpus="0,1" --memory="6G" --ipc="host"  -h "${CONTAINER_NAME}"  -p ${HOST_PORT_SSH}:22 -p ${HOST_PORT_SHIM}:8083 -p ${HOST_PORT_TOMCAT}:8080 -p ${HOST_PORT_SCIDB}:1239 -v ${HOST_SHAREDFOLDER}:/opt/shared  ${IMAGE_NAME}

echo -e "\nDONE. Please remember to remove /opt/.scidbpass in all containers after setting up your SciDB cluster."

