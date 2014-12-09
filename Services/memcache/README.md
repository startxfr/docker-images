# STARTX Services docker-images : Memcache Server

Container running memcached daemon under a centos server
This container run memcached on fedora server. 

## Running from docker registry

	docker run -d -p 11211:11211 --name="memcache" startx/sv-memcache:centos7
	when linked to another container
	docker run -d --name="memcache" startx/sv-memcache:centos7
	docker run -d --name="php" --link memcache:memcache startx/sv-php:centos7

## Build and run from local Dockerfile
### Building docker image
Copy sources in your docker host 

	mkdir startx-docker-images; 
	cd startx-docker-images;
	git clone https://github.com/startxfr/docker-images.git .

Change configuration and personalize your base image. See sx/memcache_run.sh to perform some usefull when configuring or every time you run a container.

Build the container

	docker build -t sv-memcache:centos7 Services/memcache/

### Running local image

	docker run -d -p 11211:11211 --name="memcache" sv-memcache:centos7

## Accessing server
access to the container itself

	docker exec -it memcache /bin/bash

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/Services/memcache)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/sv-memcache/)
* [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)