# STARTX Application docker-images : PhpMyAdmin

## Running from docker registry

	# docker run -d -p 8080:80 --name="test-pma" -e VIRTUAL_HOST=pma.project.startx.fr startx/app-phpmyadmin

## Running from local Dockerfile

### Building docker image
Copy the sources to your docker host 

	# mkdir startx-docker-images;
	# git clone https://github.com/startxfr/docker-images.git startx-docker-images/
	# cd startx-docker-images/Applications/phpmyadmin/

and build the container

	# docker build --rm -t <username>/pma .

### Running local image

	# docker run -d -p 8080:80 --name="test-pma" -e VIRTUAL_HOST=pma.project.startx.fr <username>/pma

## Accessing server

	# firefox http://localhost:8080

## Related Resources

* [Sources files](https://github.com/startxfr/docker-images/tree/master/Applications/phpmyadmin)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/app-phpmyadmin/)