# STARTX Services docker-images : PHP Webserver
This container run apache on fedora server.

## Running from docker registry

	docker run -d -p 80:80 --name="apache" startx/sv-apache
        # when used with a volume container (run data container, then run service)
        docker run -d -v /var/www/html -v /var/log/httpd --name apache-data startx/sv-apache echo "Data container for apache"
        docker run -d -p 80:80 --volumes-from apache-data --name="apache" startx/sv-apache
	# when used in a linked container
	docker run -d --name="apache" startx/sv-apache
	docker run -d -p 80:80 --name="apache2" --link apache:apache startx/sv-apache

## Build and run from local Dockerfile
### Building docker image
Copy sources in your docker host 

	mkdir startx-docker-images; 
	cd startx-docker-images;
	git clone https://github.com/startxfr/docker-images.git .

Change configuration and personalize your base image. you can change file httpd.conf if you want to add some config into http server

Build the container

	docker build -t sv-apache Services/apache/

### Running local image

	docker run -d -p 80:80 --name="apache" sv-apache

## Accessing server
access to the running webserver

	firefox http://localhost:80

access to the container itself

	docker exec -it apache /bin/bash

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/Services/apache)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/sv-apache/)
* [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)

