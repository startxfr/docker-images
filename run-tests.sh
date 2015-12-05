#!/bin/bash
echo "=================> STARTING TEST"
echo "=================> SETUP TEST ENVIRONMENT"
set -ev
mkdir /tmp/startx-docker-images;
cd /tmp/startx-docker-images;
git clone https://github.com/startxfr/docker-images.git .
echo " "
echo "=================> TESTING FLAVOUR 'latest' "
echo "========> TESTING 'latest' OS Container"
sudo docker-compose -f docker-compose-os.yml build
sudo docker-compose -f docker-compose-os.yml up -d
echo "========> TESTING 'latest' SERVICES Containers"
sudo docker-compose -f docker-compose-sv.yml build
sudo docker-compose -f docker-compose-sv.yml up -d
#echo "========> TESTING 'latest' APPLICATIONS Containers"
#sudo docker-compose -f docker-compose-app.yml build
#sudo docker-compose -f docker-compose-app.yml up -d
echo "=================> TEST FLAVOUR 'latest' ENDED SUCCESSFULLY"
echo " "
echo "=================> TESTING FLAVOUR 'fc23' "
git checkout fc23
echo "========> TESTING 'fc23' OS Container"
sudo docker-compose -f docker-compose-os.yml build
sudo docker-compose -f docker-compose-os.yml up -d
echo "========> TESTING 'fc23' SERVICES Containers"
sudo docker-compose -f docker-compose-sv.yml build
sudo docker-compose -f docker-compose-sv.yml up -d
#echo "========> TESTING 'fc23' APPLICATIONS Containers"
#sudo docker-compose -f docker-compose-app.yml build
#sudo docker-compose -f docker-compose-app.yml up -d
echo "=================> TEST FLAVOUR 'fc23' ENDED SUCCESSFULLY"
echo " "
echo "=================> TESTING FLAVOUR 'fc22' "
git checkout fc22
echo "========> TESTING 'fc22' OS Container"
sudo docker-compose -f docker-compose-os.yml build
sudo docker-compose -f docker-compose-os.yml up -d
echo "========> TESTING 'fc22' SERVICES Containers"
sudo docker-compose -f docker-compose-sv.yml build
sudo docker-compose -f docker-compose-sv.yml up -d
#echo "========> TESTING 'fc22' APPLICATIONS Containers"
#sudo docker-compose -f docker-compose-app.yml build
#sudo docker-compose -f docker-compose-app.yml up -d
echo "=================> TEST FLAVOUR 'fc22' ENDED SUCCESSFULLY"
echo " "
echo "=================> TEST ENDED SUCCESSFULLY"
exit 0;





