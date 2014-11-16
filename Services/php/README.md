# STARTX Services docker-images : Apache-PHP

## Running from docker registry

	# docker run -d -p 8080:80 --name="test-www" startx/sv-php

## Running from local Dockerfile

### Building docker image
Copy the sources to your docker host 

	# mkdir startx-docker-images;
	# git clone https://github.com/startxfr/docker-images.git startx-docker-images/
	# cd startx-docker-images/Services/php/

and build the container

	# docker build --rm -t <username>/www .

### Running local image

	# docker run -d -p 8080:80 --name="test-www" <username>/www

## Accessing server

	# firefox http://localhost:8080

## Related Resources

* [Sources files](https://github.com/startxfr/docker-images/tree/master/Services/php)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/sv-php/)
* [tutum php](https://registry.hub.docker.com/u/tutum/apache-php)

