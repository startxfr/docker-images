#!/bin/bash
docker run -d -p 91:80 --name="fc20-lbapache" sv-apache:fc20
docker run -d -p 3317:3306 --name="fc20-lbmariadb" sv-mariadb:fc20
docker run -d -p 11222:11211 --name="fc20-lbmemcache" sv-memcache:fc20
docker run -d -p 27028:27017 --name="fc20-lbmongo" sv-mongo:fc20
docker run -d -p 8011:8000 --name="fc20-lbnodejs" sv-nodejs:fc20
docker run -d -p 93:80 --name="fc20-lbphp" sv-php:fc20
docker run -d -p 5443:5432 --name="fc20-lbpostgres" sv-postgres:fc20
docker run -d -p 22033:22 --name="fc20-lbssh" sv-ssh:fc20