#!/bin/bash
set -ev
mkdir /tmp/startx-docker-images;
cd /tmp/startx-docker-images;
git clone https://github.com/startxfr/docker-images.git /tmp/startx-docker-images
sudo docker build -t fedora OS/
sudo docker run -it --name="fedora" fedora bash
sudo docker-compose up -d
sudo docker-compose logs
exit 1;
if [ "${TRAVIS_PULL_REQUEST}" = "false" ]; then
	exit 0;
fi