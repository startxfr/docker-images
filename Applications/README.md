<img align="right" src="https://raw.githubusercontent.com/startxfr/docker-images/master/travis/logo-small.svg?sanitize=true">

# STARTX Docker-Images Application Repository

[![STARTX Profile](https://img.shields.io/badge/provider-startx-green.svg)](https://github.com/startxfr) [![licence](https://img.shields.io/github/license/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Sources](https://img.shields.io/badge/startxfr-docker--images-blue.svg)](https://github.com/startxfr/docker-images/tree/master/)
 
[![last commit](https://img.shields.io/github/last-commit/startxfr/docker-images.svg)](https://github.com/startxfr/docker-images) [![Build Status](https://travis-ci.org/startxfr/docker-images.svg?branch=master)](https://travis-ci.org/startxfr/docker-images) [![Top language](https://img.shields.io/github/languages/count/startxfr/docker-images)](https://github.com/startxfr/docker-images) [![Code size](https://img.shields.io/github/languages/code-size/startxfr/docker-images)](https://github.com/startxfr/docker-images)

This directory host various Open Source applications into docker containers based on [startx/fedora container](https://hub.docker.com/r/startx/fedora)

You can use it to instanciate new container from the dockerhub public registry
or as a parent container in your own container's.
Each container is provided with various underlying OS version based on CentOS or
Fedora Linux distribution.

If you're used to work with redhat like and distribution, you would prefer start working
from a container based on this distribution rather than ubuntu or debian like distributions.
OS, Services, VDI and application you will find here will be closer to your favorite distribution

Please **read each container manual** for more information on how you can use it in
your project and start using stable or experimental applications in your applications

## Available services

| Service        | Docker.io                                                               | Quay.io                                                           | Docs                          |
| -------------- | ----------------------------------------------------------------------- | ----------------------------------------------------------------- | ----------------------------- |
| **PhpMyAdmin** | [`startx/app-pma`](https://hub.docker.com/r/startx/app-pma)             | [`startx/pma`](https://quay.io/repository/startx/pma)             | [manual](pma/README.md)       |
| **RockMongo**  | [`startx/app-rockmongo`](https://hub.docker.com/r/startx/app-rockmongo) | [`startx/rockmongo`](https://quay.io/repository/startx/rockmongo) | [manual](rockmongo/README.md) |

## Available Flavours

| Service        | Fedora flavours                                                                                                                                      | CentOS flavours | Alpine | UBI |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- | ------ | --- |
| **PhpMyAdmin** | `:latest` `:fc23` ` :fc24``:fc25 ` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30` `:fc31` `:fc32` `:fc33` `:fc34` | `:centos6` `:centos7` `:centos8` | `:alpine3` | `:ubi8` |
| **RockMongo**  | `:latest` `:fc23` ` :fc24``:fc25 ` `:fc26` `:fc27` `:fc28` `:fc29` `:fc30` `:fc31` `:fc32` `:fc33` `:fc34` | `:centos6` `:centos7` `:centos8` | `:alpine3` | `:ubi8` |

## Running from dockerhub registry

| Applications   | Command                                                          |
| -------------- | ---------------------------------------------------------------- |
| **PhpMyAdmin** | `docker run -d -p 80:80 --name="pma" startx/app-pma`             |
| **RockMongo**  | `docker run -d -p 80:80 --name="rockmongo" startx/app-rockmongo` |
