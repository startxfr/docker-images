STARTX docker-images - Mysql
============================

**Description**  
Based on the docker [default mysql](https://registry.hub.docker.com/_/mysql/) Dockerfile

**Usage**  

          docker run -d -p 3306:3306 startx/sv-mysql
          docker run -d -p 3306:3306 --name="test-mysql" -e MYSQL_ROOT_PASSWORD=mysecretpassword startx/sv-mysql

          docker run -d --name="test-mysql" startx/sv-mysql // linked to another container
          docker run -d --name="test-www" --link test-mysql:mysql startx/sv-php
