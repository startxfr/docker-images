# STARTX OS docker-images : Fedora 
[Docker Hub](https://registry.hub.docker.com/u/startx/fedora/) [GitHub](https://github.com/startx/fedora) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg)](https://travis-ci.org/startxfr/docker-images)



Fedora image builded with minimal and updated rpm and core-utils loaded

## Running from docker registry

	docker run -it --name="fedora" startx/fedora

## Build and run from local Dockerfile
1. Building docker image

        # Step 1 : Copy sources in your docker host 
	mkdir startx-docker-images; 
	cd startx-docker-images;
	git clone https://github.com/startxfr/docker-images.git .
        # Step 2 : Build the container
	docker build -t fedora OS/

2. Running local image

	docker run -it --name="fedora" fedora bash


## Building and running using docker-compose
1. Building from source

        # Step 1 : Copy sources in your docker host 
	mkdir startx-docker-images; 
	git clone https://github.com/startxfr/docker-images.git startx-docker-images;
        cd startx-docker-images/OS;
        # Step 2 : Build the container
	docker-compose build;

2. Running this service

	docker-compose up -d;
	docker-compose logs;

## Accessing server

	# Start interactive shell
	docker run -it startx/fedora bash
	# Start as a daemon 
	docker run -d startx/fedora bash
	docker exec -it fedora /bin/bash

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/Services/fedora)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/fedora/)
* [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)