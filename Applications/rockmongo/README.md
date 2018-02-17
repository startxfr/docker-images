# STARTX Application docker-images : Rockmongo

Container running rockmongo under a centos server.

## Running from docker registry

	docker run -d -p 80:80 --name="rockmongo" startx/app-rockmongo:centos7
	when linked to another container
	docker run -d --name="mongo" startx/sv-mongo:centos7
	docker run -d -p 80:80 --name="rockmongo" --link mongo:mongo startx/app-rockmongo:centos7

## Build and run from local Dockerfile
### Building docker image
Copy sources in your docker host 

	mkdir startx-docker-images; 
	cd startx-docker-images;
	git clone https://github.com/startxfr/docker-images.git .

Build the container

	docker build -t app-rockmongo:centos7 Applications/rockmongo/

### Running local image

	docker run -d -p 80:80 --name="rockmongo" app-rockmongo:centos7

## Accessing server
access to the running webserver

	firefox http://localhost:80/rockmongo

access to the container itself

	docker exec -it rockmongo bash

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/Applications/rockmongo)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/app-rockmongo/)
* [Docker registry for Centos](https://registry.hub.docker.com/u/centos/)


