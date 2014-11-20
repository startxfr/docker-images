# STARTX Services docker-images : MongoDB Server
This container run mongod on fedora server. 

## Running from docker registry

	# docker run -d -p 27017:27017 --name="mongo" startx/sv-mongo
	# when linked to another container
	# docker run -d --name="mongo" startx/sv-mongo
	# docker run -d --name="php" --link mongo:mongo startx/sv-php

## Build and run from local Dockerfile
### Building docker image
Copy the sources to your docker host 

        mkdir startx-docker-images; 
        cd startx-docker-images;
        git clone https://github.com/startxfr/docker-images.git .

and build the container

        docker build -t sv-mongo Services/mongo/

### Running local image

	# docker run -d -p 27017:27017 --name="mongo" sv-mongo

## Accessing server

	# mongo -h localhost -p 27017

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/Services/mongo)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/sv-mongo/)
* [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)

