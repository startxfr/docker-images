# STARTX Application docker-images : PHPMyAdmin

Container running phpMyAdmin under a centos server.

## Running from docker registry

	docker run -d -p 80:80 --name="pma" startx/app-pma:centos6
	when linked to another container
	docker run -d --name="mariadb" startx/sv-mariadb:centos6
	docker run -d -p 80:80 --name="pma" --link mariadb:mariadb startx/app-pma:centos6

## Build and run from local Dockerfile
### Building docker image
Copy sources in your docker host 

	mkdir startx-docker-images; 
	cd startx-docker-images;
	git clone https://github.com/startxfr/docker-images.git .

Build the container

	docker build -t app-pma:centos6 Applications/phpmyadmin/

### Running local image

	docker run -d -p 80:80 --name="pma" app-pma:centos6

## Accessing server
access to the running webserver

	firefox http://localhost:80/pma

access to the container itself

	docker exec -it pma bash

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/centos6/Applications/phpmyadmin)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/app-phpmyadmin/)
* [Docker registry for Centos](https://registry.hub.docker.com/u/centos/)