#!/bin/bash
docker run -d -p 81:80 --name="fc21-lbapache" sv-apache:fc21
docker run -d -p 3307:3306 --name="fc21-lbmariadb" sv-mariadb:fc21
docker run -d -p 11212:11211 --name="fc21-lbmemcache" sv-memcache:fc21
docker run -d -p 27018:27017 --name="fc21-lbmongo" sv-mongo:fc21
docker run -d -p 8001:8000 --name="fc21-lbnodejs" sv-nodejs:fc21
docker run -d -p 83:80 --name="fc21-lbphp" sv-php:fc21
docker run -d -p 5433:5432 --name="fc21-lbpostgres" sv-postgres:fc21
docker run -d -p 22023:22 --name="fc21-lbssh" sv-ssh:fc21