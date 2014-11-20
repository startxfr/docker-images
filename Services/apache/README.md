# STARTX Services docker-images : PHP Webserver
This container run apache on fedora server.

## Running from docker registry

	docker run -d -p 80:80 --name="apache" startx/sv-apache

## Build and run from local Dockerfile
### Building docker image
Copy the sources to your docker host 

        mkdir startx-docker-images; 
        cd startx-docker-images;
        git clone https://github.com/startxfr/docker-images.git .

and build the container

        docker build -t sv-apache Services/apache/

### Running local image

	docker run -d -p 80:80 --name="apache" sv-apache

## Accessing server

	firefox http://localhost

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/Services/apache)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/sv-apache/)
* [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)

