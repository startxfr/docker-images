#!/bin/bash

echo "=================> STARTING TEST"
echo "=================> SETUP TEST ENVIRONMENT"
set -ev
mkdir /tmp/startx-docker-images;
cd /tmp/startx-docker-images;
git clone https://github.com/startxfr/docker-images.git .
echo "========> BUILDING OS Container (latest)"
sudo docker-compose -f docker-compose-os.yml build
echo "========> BUILDING SERVICES Containers (latest)"
sudo docker-compose -f docker-compose-sv.yml build
echo "========> BUILDING APPLICATIONS Containers (latest)"
sudo docker-compose -f docker-compose-app.yml build
echo "========> TESTING OS Container (latest)"
sudo docker-compose -f docker-compose-os.yml up -d
echo "========> TESTING SERVICES Containers (latest)"
sudo docker-compose -f docker-compose-sv.yml up -d
echo "========> TESTING APPLICATIONS Containers (latest)"
sudo docker-compose -f docker-compose-app.yml up -d
echo "========> RESULT"
sudo docker-compose -f docker-compose-os.yml ps
sudo docker-compose -f docker-compose-sv.yml ps
sudo docker-compose -f docker-compose-app.yml ps
echo "=================> TEST ENDED SUCCESSFULLY"
exit 0;





