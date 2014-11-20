# STARTX OS docker-images : Fedora

Fedora image builded with minimal and updated binaries

## Running from docker registry
	# docker run -it startx/fedora bash
## Build and run from local Dockerfile
### Building docker image
Copy the sources to your docker host 
        # mkdir startx-docker-images; 
        # cd startx-docker-images;
        # git clone https://github.com/startxfr/docker-images.git .
and build the container
        # docker build --rm -t yourname/fedora OS/Fedora/
### Running local image
	# docker run -it yourname/fedora bash
## Related Resources
* [Sources files](https://github.com/startxfr/docker-images/tree/master/OS/Fedora)
* [Github STARTX profile](https://github.com/startxfr/docker-images)
* [Docker registry for this container](https://registry.hub.docker.com/u/startx/fedora/)
* [Docker registry for Fedora](https://registry.hub.docker.com/u/fedora/)
