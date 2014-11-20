# STARTX Services docker-images : PHP Webserver
This container run php via apache on fedora server.

## Running from docker registry

	docker run -d -p 80:80 --name="php" startx/sv-php

## Build and run from local Dockerfile
### Building docker image
Copy the sources to your docker host 

        mkdir startx-docker-images; 
        cd startx-docker-images;
        git clone https://github.com/startxfr/docker-images.git .

and build the container

        docker build -t sv-php Services/php/

### Running local image

	docker run -d -p 80:80 --name="php" sv-php

## Accessing server

	firefox http://localhost

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/Services/php)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/sv-php/)
* [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)