#!/bin/bash
./helper.docker.stop.sh

name=$(cat helper.docker.name.txt)
echo "Launching : docker compose -f docker-compose-dev.yml up"

docker compose -f docker-compose-dev.yml up
