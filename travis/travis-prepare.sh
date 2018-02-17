#!/bin/bash

echo "========> START SETUP TEST ENVIRONMENT"
echo "INFO: Updating docker configuration (experimental)"
echo '{ "experimental": true, "storage-driver": "overlay2", "max-concurrent-downloads": 50, "max-concurrent-uploads": 50 }' | sudo tee /etc/docker/daemon.json
sudo service docker restart
echo "INFO: Cache fedora image"
docker pull fedora:rawhide
echo "========> END SETUP TEST ENVIRONMENT"
exit 0;