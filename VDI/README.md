[![startxfr/docker-images](https://raw.githubusercontent.com/startxfr/docker-images/master/.gitlab/img/logo-small.svg?sanitize=true)](https://gitlab.com/startx1/containers)

# STARTX Docker-Images Container Desktop Images Repository

This directory host various Open Source desktop tools into docker containers based on [startx/fedora container](https://hub.docker.com/r/startx/fedora)

You can use it to instanciate new container from the dockerhub public registry
or as a parent container in your own container's.
Each container is provided with various underlying OS version based on CentOS or
Fedora Linux distribution.

If you're used to work with redhat like and distribution, you would prefer start working
from a container based on this distribution rather than ubuntu or debian like distributions.
OS, Services, VDI and application you will find here will be closer to your favorite distribution

Please **read each container manual** for more information on how you can use it in
your project and start using stable or experimental Container-based desktop applications

| [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) | [Dockerhub Registry](https://hub.docker.com/r/startx) | [Sources](https://gitlab.com/startx1/containers/) | [STARTX Profile](https://github.com/startxfr) |
| ------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- | ----------------------------------------------------- | --------------------------------------------- |


## Available desktop applications

| Application | Docker Hub repository                                               | Fedora flavours                                                   | CentOS flavours       | Doc                         |
| ----------- | ------------------------------------------------------------------- | ----------------------------------------------------------------- | --------------------- | --------------------------- |
| Chrome      | [`startx/vdi-chrome`](https://hub.docker.com/r/startx/vdi-chrome)   | `:latest` `:fc28` `:fc27` `:fc28` `:fc29` `:fc30` `:fc31` `:fc32``:fc33``:fc34` | `:centos7` `:centos8` | [manual](chrome/README.md)  |
| Firefox     | [`startx/vdi-firefox`](https://hub.docker.com/r/startx/vdi-firefox) | `:latest` `:fc28` `:fc27` `:fc28` `:fc29` `:fc30` `:fc31` `:fc32``:fc33``:fc34` | `:centos7` `:centos8` | [manual](firefox/README.md) |

## Running from dockerhub registry

| Desktop application | Command                                                          |
| ------------------- | ---------------------------------------------------------------- |
| **chrome**          | `docker run -d -p 5900:5900 --name="chrome" startx/vdi-chrome`   |
| **firefox**         | `docker run -d -p 5900:5900 --name="firefox" startx/vdi-firefox` |

## Container flavours

| Application | Docker Hub repository                                               | Fedora                                                            | CentOS                |
| ----------- | ------------------------------------------------------------------- | ----------------------------------------------------------------- | --------------------- |
| Chrome      | [`startx/vdi-chrome`](https://hub.docker.com/r/startx/vdi-chrome)   | `:latest` `:fc28` `:fc27` `:fc28` `:fc29` `:fc30` `:fc31` `:fc32``:fc33``:fc34` | `:centos7` `:centos8` |
| Chrome      | [`startx/vdi-firefox`](https://hub.docker.com/r/startx/vdi-firefox) | `:latest` `:fc28` `:fc27` `:fc28` `:fc29` `:fc30` `:fc31` `:fc32``:fc33``:fc34` | `:centos7` `:centos8` |
