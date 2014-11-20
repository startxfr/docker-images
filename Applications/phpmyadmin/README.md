# STARTX Application docker-images : PHPMyAdmin
This container run phpMyAdmin on PHP server running under a fedora server. 

## Running from docker registry
	docker run -d -p 80:80 --name="pma" startx/app-pma

## Build and run from local Dockerfile
### Building docker image
Copy sources in your docker host 

	mkdir startx-docker-images; 
	cd startx-docker-images;
	git clone https://github.com/startxfr/docker-images.git .

Build the container

	docker build -t startx/app-pma Applications/phpmyadmin/

### Running local image

	docker run -d -p 80:80 --name="pma" startx/app-pma

## Accessing server

	firefox http://localhost/pma

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/Applications/phpmyadmin)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/app-phpmyadmin/)
* [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)