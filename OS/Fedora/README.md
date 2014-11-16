# STARTX OS docker-images : Fedora

## Running from docker registry

	# docker run -d -p 22022:22 --name="test-fedora" -e VIRTUAL_HOST=fedora.project.startx.fr startx/fedora

## Running from local Dockerfile

### Building docker image
Copy the sources to your docker host 

	# mkdir startx-docker-images;
	# git clone https://github.com/startxfr/docker-images.git startx-docker-images/
	# cd startx-docker-images/OS/Fedora/

and build the container

	# docker build --rm -t <username>/fedora .

### Running local image

	# docker run -d -p 22022:22 --name="test-fedora" -e VIRTUAL_HOST=fedora.project.startx.fr <username>/ssh

## Accessing server

	# ssh root@localhost 

## Related Resources

* [Sources files](https://github.com/startxfr/docker-images/tree/master/OS/Fedora)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/fedora/)
* [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/ssh/)
