# STARTX OS docker-images : Fedora
Fedora image builded with minimal and updated binaries

## Running from docker registry

	docker run -it --name="centos" startx/centos

## Build and run from local Dockerfile
### Building docker image
Copy sources in your docker host 

	mkdir startx-docker-images; 
	cd startx-docker-images;
	git clone https://github.com/startxfr/docker-images.git .

Build the container

	docker build -t centos OS/Centos/

### Running local image

	docker run -it --name="centos" centos bash

## Accessing server

	# Start interactive shell
	docker run -it startx/centos bash
	# Start as a daemon 
	docker run -d startx/centos bash
	docker exec -it centos /bin/bash

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/Services/centos)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/centos/)
* [Docker registry for Centos](https://registry.hub.docker.com/u/centos/)