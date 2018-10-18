# STARTX Docker-Images Applications based on Fedora 29

This directory host various Open Source applications into docker containers based on [startx/fedora:29 container](https://hub.docker.com/r/startx/fedora)

You can use it to instanciate new container from the dockerhub public registry 
or as a parent container in your own container's. 
Each container is provided with various underlying OS version based on CentOS or 
Fedora Linux. Please visit [startx docker-images homepage](https://github.com/startxfr/docker-images/)
or [other applications flavours](https://github.com/startxfr/docker-images/Applications#container-flavours)

Please **read each container manual** for more information on how you can use it in 
your project and start using stable or experimental applications in your applications

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=fc29)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx) | [Sources](https://github.com/startxfr/docker-images/)             | [STARTX Profile](https://github.com/startxfr) | 
|-------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------|-------------------------------------------------------------------|-----------------------------------------------|

## Available applications

| Service         | Docker Hub repository                                                          | Doc
|-----------------|--------------------------------------------------------------------------------|--------------------------------
| PhpMyAdmin      | [`startx/app-pma:fc29`](https://hub.docker.com/r/startx/app-pma)               | [manual](pma/README.md)
| RockMongo       | [`startx/app-rockmongo:fc29`](https://hub.docker.com/r/startx/app-rockmongo)   | [manual](rockmongo/README.md)


## Running from dockerhub registry

| Applications        | Command                                                                   |
|---------------------|---------------------------------------------------------------------------|
| **PhpMyAdmin**      | `docker run -d -p 80:80 --name="fc29-pma" startx/app-pma:fc29`            | 
| **RockMongo**       | `docker run -d -p 80:80 --name="fc29-rockmongo" startx/app-rockmongo:fc29`| 
