# STARTX OS docker-images : Fedora
Fedora image builded with minimal and updated binaries

## Running from docker registry
	docker run -it --name="fedora" startx/fedora

## Build and run from local Dockerfile
### Building docker image
* Copy sources in your docker host 
```
	mkdir startx-docker-images; 
	cd startx-docker-images;
	git clone https://github.com/startxfr/docker-images.git .
```
* Build the container
```
	docker build -t fedora OS/Fedora/
```
### Running local image

	docker run -it --name="fedora" startx/fedora bash

## Accessing server

	docker run -it startx/fedora bash

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/Services/fedora)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/fedora/)
* [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)