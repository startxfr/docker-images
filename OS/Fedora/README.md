# STARTX OS docker-images OS : Fedora

## Running from docker registry

	# docker run -d -p 22 startx/fedora

## Running from local Dockerfile

### Building docker image
Copy the sources to your docker host 

	# mkdir startx-docker-images;
	# git clone https://github.com/startxfr/docker-images.git startx-docker-images/
	# cd startx-docker-images/OS/Fedora/

and build the container

	# docker build --rm -t <username>/fedora .

### Running local image

	# docker run -d -p 22 <username>/ssh

## Accessing server

	# ssh root@localhost 
