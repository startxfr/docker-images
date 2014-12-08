#!/bin/bash
<<<<<<< HEAD
docker run -d -p 91:80 --name="fc20-lbapache" sv-apache:fc20
docker run -d -p 3317:3306 --name="fc20-lbmariadb" sv-mariadb:fc20
docker run -d -p 11222:11211 --name="fc20-lbmemcache" sv-memcache:fc20
docker run -d -p 27028:27017 --name="fc20-lbmongo" sv-mongo:fc20
docker run -d -p 8011:8000 --name="fc20-lbnodejs" sv-nodejs:fc20
docker run -d -p 93:80 --name="fc20-lbphp" sv-php:fc20
docker run -d -p 5443:5432 --name="fc20-lbpostgres" sv-postgres:fc20
docker run -d -p 22033:22 --name="fc20-lbssh" sv-ssh:fc20
=======
docker run -d -p 81:80 --name="lbapache" sv-apache
docker run -d -p 3307:3306 --name="lbmariadb" sv-mariadb
docker run -d -p 11212:11211 --name="lbmemcache" sv-memcache
docker run -d -p 27018:27017 --name="lbmongo" sv-mongo
docker run -d -p 8001:8000 --name="lbnodejs" sv-nodejs
docker run -d -p 83:80 --name="lbphp" sv-php
docker run -d -p 5433:5432 --name="lbpostgres" sv-postgres
docker run -d -p 2002:2002 --name="lbooconv" sv-ooconv
docker run -d -p 22023:22 --name="lbssh" sv-ssh

>>>>>>> master
