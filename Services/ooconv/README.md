# STARTX Services docker-images : NodeJS Server
This container run ooconv on fedora server.

## Running from docker registry

	docker run -d -p 2002:2002 --name="ooconv" startx/sv-ooconv:fc21
        # when used with a volume container (run data container, then run service)
	docker run -d -v /tmp/ootmp --name ooconv-data startx/sv-ooconv:fc21  echo "Data container for ooconv"
	docker run -d -p 2002:2002 --volumes-from ooconv-data --name="ooconv" startx/sv-ooconv:fc21
	when linked to another container
	docker run -d --name="ooconv" startx/sv-ooconv:fc21
	docker run -d -p 80:80 --name="php" --link ooconv:ooconv startx/sv-php:fc21

## Build and run from local Dockerfile
### Building docker image
Copy sources in your docker host 

	mkdir startx-docker-images; 
	cd startx-docker-images;
	git clone https://github.com/startxfr/docker-images.git .

Build the container

	docker build -t sv-ooconv:fc21 Services/ooconv/

### Running local image

	docker run -d -p 2002:2002 --name="ooconv" sv-ooconv:fc21

## Accessing server
access to the running webserver

	firefox http://localhost:2002

access to the container itself

	docker exec -it ooconv /bin/bash

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/Services/ooconv)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/sv-ooconv/)
* [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)

STARTX docker-images - OOConv
=============================

**Description**  
Based on the docker default centos Dockerfile

**Usage**  

	  docker run --name="test-ooconv" startx/sv-ooconv unoconv
	  docker run -d -p 2002:2002 --name="test-ooconv" startx/sv-ooconv


**Converting documents**

	// Start the server 
	unoconv --listener --server 1.2.3.4 --port 2002

	// Use the client to connect to the convertion server
	unoconv --server 1.2.3.4 --port 2002
