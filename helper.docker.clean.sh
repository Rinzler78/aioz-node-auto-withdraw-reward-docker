#!/bin/bash
name=$(cat helper.docker.name.txt)

# Remove aioznode image
pushd aioz-node-docker
./helper.docker.clean.sh
popd

echo "Remove docker containers : $name"
docker rm --force $name

echo "Remove docker image : $name"
docker rmi --force $name

echo "Clean images"
docker image prune -f
docker image prune -a -f
