# STARTX Services docker-images : PostgreSQL Server
This container run memcached on fedora server. 

## Running from docker registry

	docker run -d -p 11211:11211 --name="memcache" startx/sv-memcache:fc20
	when linked to another container
	docker run -d --name="memcache" startx/sv-memcache:fc20
	docker run -d --name="php" --link memcache:memcache startx/sv-php:fc20

## Build and run from local Dockerfile
### Building docker image
Copy sources in your docker host 

	mkdir startx-docker-images; 
	cd startx-docker-images;
	git clone https://github.com/startxfr/docker-images.git .

Change configuration and personalize your base image. See sx/memcache_run.sh to perform some usefull when configuring or every time you run a container.

Build the container

	docker build -t sv-memcache:fc20 Services/memcache/

### Running local image

	docker run -d -p 11211:11211 --name="memcache" sv-memcache:fc20

## Accessing server
access to the container itself

	docker exec -it memcache /bin/bash

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/Services/memcache)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/sv-memcache/)
* [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)