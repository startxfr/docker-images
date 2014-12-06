#!/bin/bash
docker run -d -p 90:80 --name="fc20-apache" startx/sv-apache:fc20
docker run -d -p 3316:3306 --name="fc20-mariadb" startx/sv-mariadb:fc20
docker run -d -p 11221:11211 --name="fc20-memcache" startx/sv-memcache:fc20
docker run -d -p 27027:27017 --name="fc20-mongo" startx/sv-mongo:fc20
docker run -d -p 8010:8000 --name="fc20-nodejs" startx/sv-nodejs:fc20
docker run -d -p 92:80 --name="fc20-php" startx/sv-php:fc20
docker run -d -p 5442:5432 --name="fc20-postgres" startx/sv-postgres:fc20
docker run -d -p 22032:22 --name="fc20-ssh" startx/sv-ssh:fc20