#!/bin/bash
set -ev
mkdir /tmp/startx-docker-images;
cd /tmp/startx-docker-images;
git clone https://github.com/startxfr/docker-images.git /tmp/startx-docker-images
sudo docker-compose build
sudo docker-compose up -d
sudo docker-compose logs
echo $TRAVIS_PULL_REQUEST
if [ "${TRAVIS_PULL_REQUEST}" = "false" ]; then
	exit 0;
fi