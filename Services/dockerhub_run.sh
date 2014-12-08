#!/bin/bash
docker run -d -p 80:80 --name="apache" startx/sv-apache
docker run -d -p 3306:3306 --name="mariadb" startx/sv-mariadb
docker run -d -p 11211:11211 --name="memcache" startx/sv-memcache
docker run -d -p 27017:27017 --name="mongo" startx/sv-mongo
docker run -d -p 8000:8000 --name="nodejs" startx/sv-nodejs
docker run -d -p 82:80 --name="php" startx/sv-php
docker run -d -p 5432:5432 --name="postgres" startx/sv-postgres
docker run -d -p 2002:2002 --name="ooconv" startx/sv-ooconv
docker run -d -p 22022:22 --name="ssh" startx/sv-ssh