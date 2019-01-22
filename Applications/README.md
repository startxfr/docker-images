# STARTX Docker-Images Applications based on Fedora 28

This directory host various Open Source applications into docker containers based on [startx/fedora:28 container](https://hub.docker.com/r/startx/fedora)

You can use it to instanciate new container from the dockerhub public registry 
or as a parent container in your own container's. 
Each container is provided with various underlying OS version based on CentOS or 
Fedora Linux distribution.

If you're used to work with redhat like and distribution, you would prefer start working
from a container based on this distribution rather than ubuntu or debian like distributions.
OS, Services, VDI and application you will find here will be closer to your favorite distribution

Please **read each container manual** for more information on how you can use it in 
your project and start using stable or experimental applications in your applications

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=fc28)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx) | [Sources](https://github.com/startxfr/docker-images/)             | [STARTX Profile](https://github.com/startxfr) | 
|-------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------|-------------------------------------------------------------------|-----------------------------------------------|

## Available applications

| Service         | Docker Hub repository                                                          | Doc
|-----------------|--------------------------------------------------------------------------------|--------------------------------
| PhpMyAdmin      | [`startx/app-pma:fc28`](https://hub.docker.com/r/startx/app-pma)               | [manual](pma/README.md)
| RockMongo       | [`startx/app-rockmongo:fc28`](https://hub.docker.com/r/startx/app-rockmongo)   | [manual](rockmongo/README.md)


## Running from dockerhub registry

| Applications        | Command                                                                   |
|---------------------|---------------------------------------------------------------------------|
| **PhpMyAdmin**      | `docker run -d -p 80:80 --name="fc28-pma" startx/app-pma:fc28`            | 
| **RockMongo**       | `docker run -d -p 80:80 --name="fc28-rockmongo" startx/app-rockmongo:fc28`| 
