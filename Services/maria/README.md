docker-images MariaDB
=====================

**Description**
Based on the [tutum php](https://registry.hub.docker.com/u/tutum/mariadb) Dockerfile

**Usage**  
	
          docker run --name="test-maria" -d startx/sv-maria

          docker run --name="test-maria" -d startx/sv-maria
          docker run -d -p 3306:3306 startx/sv-maria
          docker run -d -p 3306:3306 --name="test-maria" startx/sv-maria

          docker run -d --name="test-maria" startx/sv-maria // linked to another container
          docker run -d --name="test-www" --link test-maria:maria startx/sv-php
