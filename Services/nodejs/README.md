# STARTX Services docker-images : NodeJS Server
This container run nodejs on fedora server.

## Running from docker registry

	docker run -d -p 8000:8000 --name="nodejs" startx/sv-nodejs

## Build and run from local Dockerfile
### Building docker image
Copy sources in your docker host 

	mkdir startx-docker-images; 
	cd startx-docker-images;
	git clone https://github.com/startxfr/docker-images.git .

Build the container

	docker build -t sv-nodejs Services/nodejs/

### Running local image

	docker run -d -p 8000:8000 --name="nodejs" sv-nodejs

## Accessing server

	firefox http://localhost:8000

## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/Services/nodejs)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/sv-nodejs/)
* [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)