#!/bin/bash
echo "=================> STARTING TEST"
echo "=================> SETUP TEST ENVIRONMENT"
set -ev
mkdir /tmp/startx-docker-images;
cd /tmp/startx-docker-images;
git clone https://github.com/startxfr/docker-images.git .
git checkout fc23
echo "========> TESTING OS Container (fedora 23)"
sudo docker-compose -f docker-compose-os.yml build
sudo docker-compose -f docker-compose-os.yml up -d
echo "========> TESTING SERVICES Containers (fedora 23)"
sudo docker-compose -f docker-compose-sv.yml build
sudo docker-compose -f docker-compose-sv.yml up -d
#echo "========> TESTING APPLICATIONS Containers (fedora 23)"
#sudo docker-compose -f docker-compose-app.yml build
#sudo docker-compose -f docker-compose-app.yml up -d
echo "=================> TEST ENDED SUCCESSFULLY"
exit 0;





