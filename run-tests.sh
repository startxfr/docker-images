#!/bin/bash
set -ev
mkdir /tmp/startx-docker-images;
cd /tmp/startx-docker-images;
git clone https://github.com/startxfr/docker-images.git /tmp/startx-docker-images
sudo docker-compose build
sudo docker-compose up -d
exit 0;