# STARTX Services docker-images : MongoDB Server
This container run mariadb on fedora server. 

## Running from docker registry

	docker run -d -p 3306:3306 --name="mariadb" startx/sv-mariadb
	when linked to another container
	docker run -d --name="mariadb" startx/sv-mariadb
	docker run -d --name="php" --link mariadb:mariadb startx/sv-php

## Build and run from local Dockerfile
### Building docker image
Copy the sources to your docker host 

	mkdir startx-docker-images; 
	cd startx-docker-images;
	git clone https://github.com/startxfr/docker-images.git .

and build the container

	docker build -t sv-mariadb Services/mariadb/

### Running local image

	docker run -d -p 3306:3306 --name="mariadb" sv-mariadb

## Accessing server

	mysql -h localhost -p 3306

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/Services/mariadb)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/sv-mariadb/)
* [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)