#!/bin/bash
docker run -d -p 100:80 --name="fc21-apache" startx/sv-apache:fc21
docker run -d -p 3326:3306 --name="fc21-mariadb" startx/sv-mariadb:fc21
docker run -d -p 11231:11211 --name="fc21-memcache" startx/sv-memcache:fc21
docker run -d -p 27037:27017 --name="fc21-mongo" startx/sv-mongo:fc21
docker run -d -p 8020:8000 --name="fc21-nodejs" startx/sv-nodejs:fc21
docker run -d -p 102:80 --name="fc21-php" startx/sv-php:fc21
docker run -d -p 5452:5432 --name="fc21-postgres" startx/sv-postgres:fc21
docker run -d -p 2022:2002 --name="fc21-ooconv" startx/sv-ooconv:fc21
docker run -d -p 22042:22 --name="fc21-ssh" startx/sv-ssh:fc21
