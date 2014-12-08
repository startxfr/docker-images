#!/bin/bash
docker run -d -p 86:80 --name="centos6-lbapache" sv-apache:centos6
docker run -d -p 3312:3306 --name="centos6-lbmariadb" sv-mariadb:centos6
docker run -d -p 11217:11211 --name="centos6-lbmemcache" sv-memcache:centos6
docker run -d -p 27023:27017 --name="centos6-lbmongo" sv-mongo:centos6
docker run -d -p 8006:8000 --name="centos6-lbnodejs" sv-nodejs:centos6
docker run -d -p 88:80 --name="centos6-lbphp" sv-php:centos6
docker run -d -p 5438:5432 --name="centos6-lbpostgres" sv-postgres:centos6
docker run -d -p 2007:2002 --name="centos6-lbooconv" sv-ooconv:centos6
docker run -d -p 22028:22 --name="centos6-lbssh" sv-ssh:centos6

