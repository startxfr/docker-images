# STARTX Services docker-images : PHP Webserver

Container running apache + php daemon under a fedora server

## Running from docker registry

	docker run -d -p 80:80 --name="php" startx/sv-php:fc21
        # when used with a volume container (run data container, then run service)
	docker run -d -v /var/www/html -v /var/log/httpd --name php-data startx/sv-php:fc21  echo "Data container for php webserver"
	docker run -d -p 80:80 --volumes-from php-data --name="php" startx/sv-php:fc21
	when linked to another container
	docker run -d --name="mongo" startx/sv-mongo:fc21
	docker run -d -p 80:80 --name="php" --link mongo:mongo startx/sv-php:fc21

## Build and run from local Dockerfile
### Building docker image
Copy sources in your docker host 

	mkdir startx-docker-images; 
	cd startx-docker-images;
	git clone https://github.com/startxfr/docker-images.git .

Change configuration and personalize your base image. you can change file httpd.conf if you want to add some config into http server. File php.ini will be added into php init scripts and executed when server start.

Build the container

	docker build -t sv-php:fc21 Services/php/

### Running local image

	docker run -d -p 80:80 --name="php" sv-php:fc21

## Accessing server
access to the running webserver

	firefox http://localhost:80

access to the container itself

	docker exec -it php /bin/bash

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/Services/php)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/sv-php/)
* [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)