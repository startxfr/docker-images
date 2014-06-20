STARTX docker-images - PhpMyAdmin
=================================

**Description**  
Based on the [maxexcloo phpmyadmin](https://github.com/maxexcloo/Docker) Dockerfile

**Usage**  

          docker run --name="test-phpmyadmin" -p 81:80 -d -e VIRTUAL_HOST=pma.project.dev.startx.fr startx/pma
          docker run --name="test-phpmyadmin" -d --link test-maria:test-maria -e VIRTUAL_HOST=pma.project.dev.startx.fr startx/app-phpmyadmin
