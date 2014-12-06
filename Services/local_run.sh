#!/bin/bash
docker run -d -p 101:80 --name="fc21-lbapache" sv-apache:fc21
docker run -d -p 3327:3306 --name="fc21-lbmariadb" sv-mariadb:fc21
docker run -d -p 11232:11211 --name="fc21-lbmemcache" sv-memcache:fc21
docker run -d -p 27038:27017 --name="fc21-lbmongo" sv-mongo:fc21
docker run -d -p 8021:8000 --name="fc21-lbnodejs" sv-nodejs:fc21
docker run -d -p 103:80 --name="fc21-lbphp" sv-php:fc21
docker run -d -p 5453:5432 --name="fc21-lbpostgres" sv-postgres:fc21
docker run -d -p 22043:22 --name="fc21-lbssh" sv-ssh:fc21