#!/bin/bash

echo "=================> STARTING TEST"
echo "=================> SETUP TEST ENVIRONMENT"
set -ev
mkdir /tmp/startx-docker-images;
cd /tmp/startx-docker-images;
git clone https://github.com/startxfr/docker-images.git .
git checkout fc21
echo "========> TESTING OS Container (fedora 21)"
sudo docker-compose -f docker-compose-os.yml build
echo "========> BUILDING SERVICES Containers (fedora 21)"
sudo docker-compose -f docker-compose-sv.yml build
echo "========> BUILDING APPLICATIONS Containers (fedora 21)"
sudo docker-compose -f docker-compose-app.yml build
echo "========> TESTING OS Container (fedora 21)"
sudo docker-compose -f docker-compose-os.yml up -d
echo "========> TESTING SERVICES Containers (fedora 21)"
sudo docker-compose -f docker-compose-sv.yml up -d
echo "========> TESTING APPLICATIONS Containers (fedora 21)"
sudo docker-compose -f docker-compose-app.yml up -d
echo "========> RESULT"
sudo docker-compose -f docker-compose-os.yml ps
sudo docker-compose -f docker-compose-sv.yml ps
sudo docker-compose -f docker-compose-app.yml ps
echo "=================> TEST ENDED SUCCESSFULLY"
exit 0;





