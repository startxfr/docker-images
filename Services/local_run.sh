#!/bin/bash
docker run -d -p 81:80 --name="lbapache" sv-apache
docker run -d -p 3307:3306 --name="lbmariadb" sv-mariadb
docker run -d -p 11212:11211 --name="lbmemcache" sv-memcache
docker run -d -p 27018:27017 --name="lbmongo" sv-mongo
docker run -d -p 8001:8000 --name="lbnodejs" sv-nodejs
docker run -d -p 83:80 --name="lbphp" sv-php
docker run -d -p 5433:5432 --name="lbpostgres" sv-postgres
docker run -d -p 22023:22 --name="lbssh" sv-ssh