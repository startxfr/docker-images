# STARTX Services docker-images : NodeJS Server
This container run nodejs on fedora server.

## Running from docker registry

	docker run -d -p 8000:8000 --name="nodejs" startx/sv-nodejs:fc21
        # when used with a volume container (run data container, then run service)
	docker run -d -v /var/nodejs/app --name nodejs-data startx/sv-nodejs:fc21  echo "Data container for nodejs"
	docker run -d -p 8000:8000 --volumes-from nodejs-data --name="nodejs" startx/sv-nodejs:fc21
	when linked to another container
	docker run -d --name="mongo" startx/sv-mongo:fc21
	docker run -d -p 8000:8000 --name="nodejs" --link mongo:mongo startx/sv-nodejs:fc21

## Build and run from local Dockerfile
### Building docker image
Copy sources in your docker host 

	mkdir startx-docker-images; 
	cd startx-docker-images;
	git clone https://github.com/startxfr/docker-images.git .

Build the container

	docker build -t sv-nodejs:fc21 Services/nodejs/

### Running local image

	docker run -d -p 8000:8000 --name="nodejs" sv-nodejs:fc21

## Accessing server
access to the running webserver

	firefox http://localhost:8000

access to the container itself

	docker exec -it nodejs /bin/bash

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/Services/nodejs)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/sv-nodejs/)
* [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)