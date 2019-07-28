# STARTX Docker-Images Applications based on CentOS 7

This directory host various Open Source applications into docker containers based on [startx/centos:7 container](https://hub.docker.com/r/startx/centos)

You can use it to instanciate new container from the dockerhub public registry 
or as a parent container in your own container's. 
Each container is provided with various underlying OS version based on CentOS or 
Fedora Linux distribution.

If you're used to work with redhat like and distribution, you would prefer start working
from a container based on this distribution rather than ubuntu or debian like distributions.
OS, Services, VDI and application you will find here will be closer to your favorite distribution

Please **read each container manual** for more information on how you can use it in 
your project and start using stable or experimental applications in your applications

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=centos7)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx) | [Sources](https://github.com/startxfr/docker-images/)             | [STARTX Profile](https://github.com/startxfr) | 
|-------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------|-------------------------------------------------------------------|-----------------------------------------------|

## Available applications

| Service         | Docker Hub repository                                                     | Fedora flavours                                                       | CentOS flavours | Doc                                        | 
|-----------------|---------------------------------------------------------------------------|-----------------------------------------------------------------------|-----------------|--------------------------------------------|
| PhpMyAdmin      | [`startx/app-pma`](https://hub.docker.com/r/startx/app-pma)               | `:latest` `:20` `:21` `:22` `:23` `:26` `:27` `:28` `:29` `:30` `:31` | `:6` `:7` `:8`  | [manual](pma/README.md)                    | 
| RockMongo       | [`startx/app-rockmongo`](https://hub.docker.com/r/startx/app-rockmongo)   | `:latest` `:20` `:21` `:22` `:23` `:26` `:27` `:28` `:29` `:30` `:31` | `:6` `:7` `:8`  | [manual](rockmongo/README.md)              | 


## Running from dockerhub registry

| Applications        | Command                                                                   |
|---------------------|---------------------------------------------------------------------------|
| **PhpMyAdmin**      | `docker run -d -p 80:80 --name="centos7-pma" startx/app-pma:centos8`            | 
| **RockMongo**       | `docker run -d -p 80:80 --name="centos7-rockmongo" startx/app-rockmongo:centos8`| 

## Container flavours

| Service    | Docker Hub repository                                                   | Fedora                                                    | CentOS 
|------------|-------------------------------------------------------------------------|-----------------------------------------------------------|----------------------
| PhpMyAdmin | [`startx/app-pma`](https://hub.docker.com/r/startx/app-pma)             | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` | `:centos6` `:centos7` `:centos8` |
| RockMongo  | [`startx/app-rockmongo`](https://hub.docker.com/r/startx/app-rockmongo) | `:latest` `:fc20` `:fc21` `:fc22` `:fc23` `:fc26` `:fc27` | `:centos6` `:centos7` `:centos8` |
