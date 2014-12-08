#!/bin/bash
docker run -d -p 130:80 --name="fc21-lbapache" startx/sv-apache:fc21
docker run -d -p 3356:3306 --name="fc21-lbmariadb" startx/sv-mariadb:fc21
docker run -d -p 11261:11211 --name="fc21-lbmemcache" startx/sv-memcache:fc21
docker run -d -p 27067:27017 --name="fc21-lbmongo" startx/sv-mongo:fc21
docker run -d -p 8050:8000 --name="fc21-lbnodejs" startx/sv-nodejs:fc21
docker run -d -p 117:80 --name="fc21-lbphp" startx/sv-php:fc21
docker run -d -p 5482:5432 --name="fc21-lbpostgres" startx/sv-postgres:fc21
docker run -d -p 2072:2002 --name="fc21-lbooconv" startx/sv-ooconv:fc21
docker run -d -p 22042:22 --name="fc21-lbssh" startx/sv-ssh:fc21