#!/bin/bash
docker run -d -p 86:80 --name="lbapache" sv-apache:centos6
docker run -d -p 3312:3306 --name="lbmariadb" sv-mariadb:centos6
docker run -d -p 11217:11211 --name="lbmemcache" sv-memcache:centos6
docker run -d -p 27023:27017 --name="lbmongo" sv-mongo:centos6
docker run -d -p 8006:8000 --name="lbnodejs" sv-nodejs:centos6
docker run -d -p 88:80 --name="lbphp" sv-php:centos6
docker run -d -p 5438:5432 --name="lbpostgres" sv-postgres:centos6
docker run -d -p 2007:2002 --name="lbooconv" sv-ooconv:centos6
docker run -d -p 22028:22 --name="lbssh" sv-ssh:centos6

