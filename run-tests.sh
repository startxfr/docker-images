#!/bin/bash
set -ev
sudo mkdir startx-docker-images;
sudo cd startx-docker-images;
sudo git clone https://github.com/startxfr/docker-images.git .
sudo docker build -t fedora OS/
sudo docker run -it --name="fedora" fedora bash
sudo docker-compose up -d
sudo docker-compose logs
exit 1;
if [ "${TRAVIS_PULL_REQUEST}" = "false" ]; then
	exit 0;
fi