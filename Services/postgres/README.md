STARTX docker-images - Postgres
===============================

**Description**  
Based on the docker [default postgres](https://registry.hub.docker.com/u/library/postgres/) Dockerfile

**Usage**  
	
          docker run -d -p 5432:5432 startx/sv-postgres
          docker run -d -p 5432:5432 --name="test-postgres" startx/sv-postgres

          docker run -d --name="test-postgres" startx/sv-postgres // linked to another container
          docker run -d --name="test-www" --link test-postgres:postgres startx/sv-php

