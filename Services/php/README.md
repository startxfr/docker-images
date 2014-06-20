STARTX docker-images - PHP
==========================

**Description**  
Based on the [tutum php](https://registry.hub.docker.com/u/tutum/apache-php) Dockerfile

**Usage**  
	
          docker run -d -p 80:80 startx/sv-php // minimum to run properly the server
          docker run -d -p 80:80 --name="test-www" -e VIRTUAL_HOST=php.project.dev.startx.fr startx/sv-php
